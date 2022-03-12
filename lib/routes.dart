import 'package:flutter/material.dart';
import 'package:memory_practice/pages/about/about_us_page.dart';
import 'package:memory_practice/pages/game/game_main.dart';
import 'package:memory_practice/pages/grow/grow_main.dart';
import 'package:memory_practice/pages/home/entrance.dart';
import 'package:memory_practice/pages/home/home_content.dart';
import 'package:memory_practice/pages/login/login_main.dart';
import 'package:memory_practice/pages/login/register_main.dart';
import 'package:memory_practice/pages/rank/rank_main.dart';
import 'package:memory_practice/pages/update/update_page.dart';
final routes={
  '/':(_)=>const HomeContent(),
  '/entrance':(_)=>const EntrancePage(),
  '/game_main':(_,{arguments})=>GameMain(arguments:arguments),
  '/rank':(_)=>const RankContent(),
  '/grow':(_)=>const GrowContent(),
  '/login':(_)=>const LoginPage(),
  '/register':(_)=>const RegisterPage(),
  '/about':(_)=>const AboutUsPage(),
  '/update':(_)=>const UpdatePage(),
};
Route? onGenerateRoute(RouteSettings settings){
  final String? name=settings.name;
  final Function? pageContentBuilder = routes[name];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = MaterialPageRoute(
        builder:(context)=>pageContentBuilder(
          context,
          arguments:settings.arguments,
        ),
      );
      return route;
    }
    else{
      final Route route = MaterialPageRoute(
        builder: (context)=>pageContentBuilder(context),
      );
      return route;
    }
  }
  return null;
}