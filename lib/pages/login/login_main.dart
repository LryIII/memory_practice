import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/store.dart';
import 'package:memory_practice/pages/login/login_network.dart';

import '../../components/global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;

  final StreamController<String?> _userNameStreamController=StreamController<String?>();
  final StreamController<String?> _passWordStreamController=StreamController<String?>();
  final FocusNode _userNameFocus=FocusNode();
  final FocusNode _passWordFocus=FocusNode();
  final TextEditingController _userNameEditingController=TextEditingController();
  final TextEditingController _passWordEditingController=TextEditingController();

  late bool isNotShowPassWord;

  @override
  void initState() {
    isNotShowPassWord=true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return globalData.isLogin?haveLogin():loginWidget();
  }

  Widget haveLogin(){
    return Scaffold(
      appBar: AppBar(
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
        elevation: 0.8,
        backgroundColor: const Color.fromARGB(0xff, 246, 246, 246),
        title: const Text(
          "登录",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height:double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(0xff, 246, 246, 246),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 660*unitH,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "您已经登录过啦",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "无需重复操作",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.0*unitH,
                ),
                ElevatedButton(
                  onPressed: () async{
                    await SharedPreferenceUnit.saveData<bool>("isLogin", false);
                    //print(await SharedPreferenceUnit.getData<bool>("isLogin"));
                    globalData.logout();
                    setState(() {

                    });
                  },
                  child: const Text(
                    "登出"
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget loginWidget(){
    return GestureDetector(
      onTap: (){
        loseFocus();
      },
      child: Scaffold(
        appBar: AppBar(
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
          elevation: 0.8,
          backgroundColor: const Color.fromARGB(0xff, 246, 246, 246),
          title: const Text(
            "登录",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
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
                SizedBox(height: 50*unitH,),
                userNameTextField(),
                SizedBox(height: 25*unitH,),
                passWordTextField(),
                SizedBox(height: 1*unitH,),
                registerButton(),
                loginButton(),
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
              )
            ),
            onSubmitted: (value){
              if(checkUserName()){
                _userNameFocus.unfocus();
                //print(userName);
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
              if(!value.contains(RegExp(r"[\u4e00-\u9fa5ZA-ZZa-z0-9_]+$")) && value!=''){
                _userNameStreamController.add('用户名仅能包含大，小写英文字母，数字，汉字，下划线');
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
              suffixIcon: IconButton(
                icon: Icon(
                  isNotShowPassWord ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isNotShowPassWord = !isNotShowPassWord;
                  });
                },
              ),
            ),
            onSubmitted: (value){
              loginAll();
            },
          ),
        );
      },
    );
  }

  Widget loginButton() {
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
            "登录",
          ),
          onPressed: (){
            loginAll();
          },
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )
            )
          ),
        ),
      ),
    );
  }
  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: const Text(
            "注册",
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/register');
          },
        )
      ],
    );
  }

  void loseFocus() {
    //输入框失去焦点
    _userNameFocus.unfocus();
    _passWordFocus.unfocus();
    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void loginAll() {
    loseFocus();
    if(checkUserName() && checkPassWord()) {
      loginFunction();
    }
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
    if(!userName.contains(RegExp(r"[\u4e00-\u9fa5ZA-ZZa-z0-9_]+$"))){
      _userNameStreamController.add('用户名仅能包含大，小写英文字母，数字，汉字，下划线');
      return false;
    }
    _userNameStreamController.add(null);
    return true;
  }

  bool checkPassWord() {
    String pwd=_passWordEditingController.text;
    if(pwd.isEmpty){
      _passWordStreamController.add('密码不得为空');
      return false;
    }
    if(pwd.length<6){
      _passWordStreamController.add('密码不得短于6位');
      return false;
    }
    _passWordStreamController.add(null);
    return true;
  }

  void loginFunction() async{
    try{
      bool success=await LoginNetwork().login(
        _userNameEditingController.text,
        _passWordEditingController.text,
      );
      if(success){
        SmartDialog.showToast('登录成功');
        await SharedPreferenceUnit.saveData<bool>('isLogin', true);
        await SharedPreferenceUnit.saveData<String>(
          '%userName',
          _userNameEditingController.text,
        );
        await SharedPreferenceUnit.saveData<String>(
          '%passWord',
          _passWordEditingController.text,
        );
        globalData.userName=_userNameEditingController.text;
        globalData.passWord=_passWordEditingController.text;
        globalData.isLogin=true;
        Navigator.of(context).pop();
      }
      else{
        SmartDialog.showToast('密码错误');
      }
    }catch(e){
      SmartDialog.showToast('用户名不存在');
      print(e);
      return ;
    }
  }
}
