import 'package:dio/dio.dart';

class RankMyItem {
  Dio dio=Dio();
  Future<void> addItem(String name,double time) async{
    try{
      var response=await dio.post(
        'http://101.43.148.116:9002/v1/admin/twt/sort',
        queryParameters: {
          'name':name,
          'time':'$time',
        },
      );
      if(response.data['code']=='200'){
        print(response.data);
      }else{

      }
    }catch(e){

    }
  }
  Future<Map> getAllRank(int head,int tail) async{
    try{
      var response=await dio.get(
        'http://101.43.148.116:9002/v1/admin/twt/list',
        queryParameters: {
          'head': '$head',
          'tail': '$tail',
        }
      );
      //print(response.data);
      return response.data;
    }catch(e){
      print(e);
      return {};
    }
  }
  Future<Map> getOneTime(String name) async{
    try{
      var response=await dio.get(
        'http://101.43.148.116:9002/v1/admin/twt/sort',
        queryParameters: {
          'name':name,
        }
      );
      return response.data;
    }
    catch(e){
      return {};
    }
  }
  Future<double> getOneOnlyTime(String name) async{
    try{
      var response=await dio.get(
        'http://101.43.148.116:9002/v1/admin/twt/sort/time',
        queryParameters: {
          'name':name,
        }
      );
      return response.data['result'].toDouble();
    }catch(e){
      return -0.01;
    }
  }
  Future<bool> isInRank(String name) async{
    try{
      var response=await dio.get(
        'http://101.43.148.116:9002/v1/admin/twt/sort/exist',
        queryParameters: {
          'name':name,
        }
      );
      return response.data['result']=='1';
    }catch(e){

      return false;
    }
  }
  Future<int> getAllNum()async{
    try{
      var response=await dio.get(
        'http://101.43.148.116:9002/v1/admin/twt/sorts/num',
      );
      return response.data['result'].toInt();
    }catch(e){
      return -1;
    }
  }
  Future<int> getOneRank(String name)async{
    try{
      var response=await dio.get(
        'http://localhost:9002/v1/admin/twt/ranking',
        queryParameters:{
          'name':name,
        }
      );
      return response.data['result'].toInt();
    }catch(e){
      return -1;
    }
  }
}