import 'package:flutter/material.dart';
import 'package:memory_practice/pages/game/game_main.dart';
import 'package:memory_practice/pages/home/entrance.dart';
import 'package:memory_practice/pages/home/home_content.dart';
final routes={
  '/':(_)=>HomeContent(),
  '/entrance':(_)=>const EntrancePage(),
  '/game_main':(_)=>const GameMain(),
};
Route? onGenerateRoute(RouteSettings settings){
  final String? name=settings.name;
  final Function? pageContentBuilder = routes[name];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = MaterialPageRoute(
          builder:(context)=>pageContentBuilder(
              context,
              arguments:settings.arguments
          )
      );
      return route;
    }
    else{
      final Route route = MaterialPageRoute(
          builder: (context)=>pageContentBuilder(context)
      );
      return route;
    }
  }
  return null;
}