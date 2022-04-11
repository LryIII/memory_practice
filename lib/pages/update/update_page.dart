
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  ///初始化
  void initXUpdate() {
    Future<void> setErrorMessage(Map<String, dynamic>? message) async {
      if(message!['code']==2004){
        SmartDialog.showToast("已经是最新版本");
      }
      setState(() {
        //_message = message;
      });
    }
    void updateMessage(String newMessage){

    }

    FlutterXUpdate.init(
      ///是否输出日志
      debug: true,
          ///是否使用post请求
      isPost: false,
          ///post请求是否是上传json
      isPostJson: false,
          ///是否开启自动模式
      isWifiOnly: false,
          ///是否开启自动模式
      isAutoMode: false,
          ///需要设置的公共参数
      supportSilentInstall: false,
      ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
      enableRetry: false,
    ).then((value) {
      updateMessage("初始化成功: $value");
    }).catchError((error) {
      //print(error);
      SmartDialog.showToast("出现未知错误，请重试");
    });
    FlutterXUpdate.setErrorHandler(
      onUpdateError: setErrorMessage
    );
  }

  @override
  void initState() {
    initXUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "版本信息",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromARGB(0xff, 246, 246, 246)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const SizedBox(height: 40.0,),
            const SizedBox(
              width: 177*1.3,
              height: 47*1.3,
              child: Image(
                image: AssetImage('assets/images/leave.png'),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "version: V1.0.4",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                  ),
                )
              ],
            ),
            const SizedBox(height: 30,),
            Container(
              width: 300.0,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                  ),
                  top: BorderSide(
                    width: 1.0,
                  ),
                ),
              ),
              child: OutlinedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/about');
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide.none,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //SizedBox(width: 10.0,),
                    Text(
                      "应用信息",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 30.0,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 300.0,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                  ),
                ),
              ),
              child: OutlinedButton(
                onPressed: (){
                  FlutterXUpdate.checkUpdate(url: "https://gitee.com/Liangruiyang/leave-apk-release/raw/master/appinfo.json");
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide.none,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //SizedBox(width: 10.0,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.update,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 30.0,),
                    Text(
                      "检查更新",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
