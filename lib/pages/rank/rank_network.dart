import 'package:dio/dio.dart';

class RankMyItem {
  Dio dio=Dio();
  void addItem(String username,double time) async{
    try{
      var response=await dio.post(
        'http://101.43.148.116:9002/v1/admin/twt/sort',
        queryParameters: {
          'name':username,
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
  Future<Map> getRank(int head,int tail) async{

    try{
      var response=await dio.get(
        'http://101.43.148.116:9002/v1/admin/twt/list',
        queryParameters: {
          'head': '$head',
          'tail': '$tail',
        }
      );
      print(response.data);
      return response.data;
    }catch(e){
      print(e);
      return {};
    }
  }
}