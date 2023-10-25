import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/dialog.dart';
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
      widget: const NoticeDialog(),
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