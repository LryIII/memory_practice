import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/global.dart';
import 'package:memory_practice/components/net_status.dart';
import 'package:memory_practice/components/store.dart';
import 'package:memory_practice/pages/grow/grow_network.dart';
import 'package:memory_practice/pages/home/home_content.dart';
import 'package:memory_practice/routes.dart';
import 'package:after_layout/after_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NetStatusListener.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp>{

  initAll() async{
    try{
      var isLogin=await SharedPreferenceUnit.getData<bool>("isLogin");
      if(isLogin==true){
        globalData.changeLogin(true);
        globalData.userName=await SharedPreferenceUnit.getData<String>('%userName');
        globalData.passWord=await SharedPreferenceUnit.getData<String>('%passWord');
        globalData.recordList=await GrowNetwork().getData(globalData.userName);
        await globalData.getBestTime();
        await globalData.getMyRank();
        setState(() {

        });
      }
    }catch(e){
      print(e);
      rethrow;
    }
  }

  @override
  void initState() {
    initAll();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    SmartDialog.show(
      widget: Container(
        height: 320,
        width: 270,
        decoration: BoxDecoration(
          color: const Color.fromARGB(0xff, 246, 246, 246),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "重要提醒",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "由于某些未知的原因",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Text(
              "（能力真的有限，修了好久没修好",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Text(
              "在校园网情况下",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Text(
              "需要联网的界面加载会异常缓慢",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Text(
              "在加载缓慢的情况下，建议退出重进几次",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Text(
              "或者在通过流量加载",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute:onGenerateRoute,
      home: const HomeContent(),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}