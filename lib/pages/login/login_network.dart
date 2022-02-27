import 'package:dio/dio.dart';

class LoginNetwork {
  Future<bool> login(String name,String password) async{
    try{
      Dio dio=Dio();
      var response=await dio.get(
        'http://101.43.148.116:9004/v1/login',
        queryParameters: {
          "name":name,
          'password':password,
        }
      );
      if(response.data['result'].toString().contains('成功')){
        return true;
      }
      return false;
    }catch(e){
      print(e);
      return false;
    }
  }

  //0失败，1已被注册，2成功
  Future<int> register(String name,String password) async{
    try{
      Dio dio=Dio();
      var response=await dio.post(
        'http://101.43.148.116:9004/v1/register',
        queryParameters: {
          "name":name,
          "password":password,
        }
      );
      if(response.data['code']=='200'|| response.data['code']==200){
        if(response.data['result'].toString().contains('注册')){
          return 1;
        }else{
          return 2;
        }

      }
      return 0;
    }catch(e){
      print(e);
      return 0;
    }
  }
}