import 'package:dio/dio.dart';
import 'package:memory_practice/components/global.dart';
import 'package:memory_practice/components/store.dart';

class GrowNetwork {
  Dio dio=Dio();
  Future<bool> addItem(String name,double time)async {
    try{
      globalData.updateTimesAll(time);
      return true;
      // var response= await dio.post(
      //     'http://101.43.148.116:9003/v1/admin/twt/history',
      //     queryParameters: {
      //       "name":name,
      //       "time":time,
      //     }
      // );
      // if(response.data['code']==200){
      //   return true;
      // }else{
      //   return false;
      // }

    }catch(e){
      print(e);
      return false;
    }
  }

  Future<List> getMyData() async{
    try{
      globalData.getTimesAll();
      var dataList=[];
      for(int i=1;i<=globalData.timesAll;i++){
        double value=await SharedPreferenceUnit.getData<double>("t$i");
        dataList.add(value);
      }
      return dataList;
    }catch(e){
      print(e);
      return [];
    }
  }

  // Future<List> getData(String name) async{
  //   try{
  //     var response=await dio.get(
  //       'http://101.43.148.116:9003/v1/admin/twt/history',
  //       queryParameters: {
  //         "name":name
  //       }
  //     );
  //     return response.data['result'].toList();
  //   }catch(e){
  //     print(e);
  //     return [];
  //   }
  // }
  Future<int> getNum(String name) async{
    try{
      // var response=await dio.get(
      //   'http://101.43.148.116:9003/v1/admin/twt/history/num',
      //   queryParameters: {
      //     "name":name
      //   }
      // );
      return globalData.timesAll;
    }catch(e){
      return 0;
    }
  }
}