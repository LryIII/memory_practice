import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/global.dart';
import 'package:memory_practice/components/store.dart';
import 'package:memory_practice/pages/login/login_network.dart';
import 'package:memory_practice/pages/login/verify_code.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final double unitH=GlobalUnit().unitHeight;
  final double unitW=GlobalUnit().unitWidth;

  final StreamController<String?> _userNameStreamController=StreamController<String?>();
  final StreamController<String?> _passWordStreamController=StreamController<String?>();
  final StreamController<String?> _passWordAgainStreamController=StreamController<String?>();
  final StreamController<String?> _verifyCodeStreamController=StreamController<String?>();
  final FocusNode _userNameFocus=FocusNode();
  final FocusNode _passWordFocus=FocusNode();
  final FocusNode _passWordAgainFocus=FocusNode();
  final FocusNode _verifyCodeFocus=FocusNode();
  final TextEditingController _userNameEditingController=TextEditingController();
  final TextEditingController _passWordEditingController=TextEditingController();
  final TextEditingController _passWordAgainEditingController=TextEditingController();
  final TextEditingController _verifyCodeEditingController=TextEditingController();
  late bool isNotShowPassWord;
  late String rightVerifyCode;
  @override
  void initState() {
    isNotShowPassWord=true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        loseFocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "注册",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(0xff, 246, 246, 246),
          elevation: 0.8,
        ),
        body: Container(
          width: double.infinity,
          height:double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(0xff, 246, 246, 246),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30*unitH,),
                userNameTextField(),
                passWordTextField(),
                passWordAgainTextField(),
                verifiedCodeTextField(),
                enterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<String?> userNameTextField() {
    return StreamBuilder<String?>(
      stream: _userNameStreamController.stream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            focusNode: _userNameFocus,
            controller: _userNameEditingController,
            decoration: InputDecoration(
              errorText: snapshot.data,
              labelText: "用户名",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: '请输入不超过8位的用户名',
            ),
            onSubmitted: (value){
              if(checkUserName()){
                _userNameFocus.unfocus();
                FocusScope.of(context).requestFocus(_passWordFocus);
              }else{
                FocusScope.of(context).requestFocus(_userNameFocus);
              }
            },
            onChanged: (value){
              if(value.length>=8){
                _userNameStreamController.add('用户名不得超过8个字符');
                return ;
              }
              if(!_userNameEditingController.text.contains(RegExp(r"^[\u4e00-\u9fa5A-Za-z0-9_]+$"))
                  && _userNameEditingController.text!=''
                  && _userNameEditingController.text.isNotEmpty){
                _userNameStreamController.add('用户名请勿包含特殊字符');
                return ;
              }
              _userNameStreamController.add(null);
            },
          ),
        );
      },
    );
  }

  StreamBuilder<String?> passWordTextField() {
    return StreamBuilder<String?>(
      stream: _passWordStreamController.stream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            focusNode: _passWordFocus,
            controller: _passWordEditingController,
            obscureText: isNotShowPassWord,
            decoration: InputDecoration(
              errorText: snapshot.data,
              labelText: "密码",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: "请输入不短于6位，由字母数字组成的密码"
            ),
            onSubmitted: (value){
              if(checkPassWord()){
                FocusScope.of(context).requestFocus(_passWordAgainFocus);
                return ;
              }else{
                FocusScope.of(context).requestFocus(_passWordFocus);
              }
              if(value==''){
                _passWordStreamController.add(null);
              }
            },
            onChanged: (value){
              if(!value.contains(RegExp(r'^[A-Za-z0-9]+$')) && value!=''){
                _passWordStreamController.add("密码只能包含字母数字");
                return ;
              }
              _passWordStreamController.add(null);
              return ;
            },
          ),
        );
      },
    );
  }
  StreamBuilder<String?> passWordAgainTextField() {
    return StreamBuilder<String?>(
      stream: _passWordAgainStreamController.stream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            focusNode: _passWordAgainFocus,
            controller: _passWordAgainEditingController,
            obscureText: true,
            decoration: InputDecoration(
              errorText: snapshot.data,
              labelText: "确认密码",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: "请再次输入密码",
            ),
            onSubmitted: (value){
              if(checkPassWordAgain() && value!=''){
                FocusScope.of(context).requestFocus(_verifyCodeFocus);
              }else{
                FocusScope.of(context).requestFocus(_passWordAgainFocus);
              }
            },
            onChanged: (value){
              if(value==''){
                _passWordAgainStreamController.add(null);
              }
            },
          ),
        );
      },
    );
  }
  Widget verifiedCodeTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 100.0*unitH,
          width: 223.5*unitW,
          child: Padding(
            padding: EdgeInsets.all(8.0*unitW),
            child: StreamBuilder<String?>(
              stream: _verifyCodeStreamController.stream,
              builder: (BuildContext context,AsyncSnapshot snapshot) {
                return TextField(
                  focusNode: _verifyCodeFocus,
                  controller: _verifyCodeEditingController,
                  decoration: InputDecoration(
                    labelText: "验证码",
                    errorText: snapshot.data,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value){
                    if(value==''){
                      _verifyCodeStreamController.add(null);
                    }
                  },
                  onSubmitted: (value){
                    if(checkVerifyCode()){
                      registerAll();
                    }
                    else{
                      FocusScope.of(context).requestFocus(_verifyCodeFocus);
                    }
                  },
                );
              })
          ),
        ),
        VerifyCode(
          width: 140.0*unitW,
          height: 50.0*unitH,
          verifyCallback: (value){
            rightVerifyCode=value.toLowerCase();
          },
        ),
      ],
    );
  }
  Widget enterButton() {
    return SizedBox(
      height: 50*unitH,
      width: GlobalUnit().screenWidth,
      child: Padding(
        padding: EdgeInsets.only(
          left: 18.0*unitW,
          right: 18.0*unitW,
        ),
        child: ElevatedButton(
          child: const Text(
            "注册",
          ),
          onPressed: (){
            registerAll();
          },
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
          ),
        ),
      ),
    );
  }
  bool checkUserName() {
    String userName=_userNameEditingController.text;
    if(userName.isEmpty){
      _userNameStreamController.add('用户名不得为空');
      return false;
    }
    if(userName.length>=8){
      _userNameStreamController.add('用户名不得超过8个字符');
      return false;
    }
    if(!userName.contains(RegExp(r"^[\u4e00-\u9fa5A-Za-z0-9_]+$"))
        && _userNameEditingController.text!=''
        && _userNameEditingController.text.isNotEmpty){
      _userNameStreamController.add('用户名请勿包含特殊字符');
      return false;
    }
    _userNameStreamController.add(null);
    return true;
  }
  bool checkPassWord(){
    String pwd=_passWordEditingController.text;
    if(!pwd.contains(RegExp(r'^[ZA-ZZa-z0-9_]+$'))){
      _passWordStreamController.add("密码只能包含字母数字");
      return false;
    }
    if(pwd.length<6){
      _passWordStreamController.add("密码不得短于6个字符");
      return false;
    }
    _passWordStreamController.add(null);
    return true;
  }
  bool checkPassWordAgain(){
    String pwd=_passWordAgainEditingController.text;
    if(pwd!=_passWordEditingController.text){
      _passWordAgainStreamController.add("两次输入密码不相同");
      return false;
    }
    _passWordAgainStreamController.add(null);
    return true;
  }
  bool checkVerifyCode(){
    if(rightVerifyCode!=_verifyCodeEditingController.text.toLowerCase()){
      _verifyCodeStreamController.add('验证码错误');
      return false;
    }
    _verifyCodeStreamController.add(null);
    return true;
  }
  void loseFocus() {
    _userNameFocus.unfocus();
    _passWordFocus.unfocus();
    _verifyCodeFocus.unfocus();
    _passWordAgainFocus.unfocus();
    if(_passWordAgainEditingController.text==''){
      _passWordAgainStreamController.add(null);
    }
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  void registerAll(){
    loseFocus();
    checkUserName();
    checkPassWord();
    checkPassWordAgain();
    checkVerifyCode();
    if(checkUserName() &&  checkPassWord() &&
      checkPassWordAgain() && checkVerifyCode()){
      registerFunction();
    }
    else{
      setState(() {});
    }
  }
  void registerFunction() async{
    int success=await LoginNetwork().register(
      _userNameEditingController.text,
      _passWordEditingController.text,
    );
    if(success==2){
      await SharedPreferenceUnit.saveData<String>('%userName', _userNameEditingController.text);
      await SharedPreferenceUnit.saveData<String>('%passWord', _passWordEditingController.text);

      SmartDialog.showToast('注册成功',time: const Duration(milliseconds: 1500));
      Navigator.of(context).pop();
    }else if(success==1){
      SmartDialog.showToast('该用户名已经被注册过',time: const Duration(milliseconds: 1500));
    }else{
      SmartDialog.showToast('注册失败',time: const Duration(milliseconds: 1500));
    }
  }
}
