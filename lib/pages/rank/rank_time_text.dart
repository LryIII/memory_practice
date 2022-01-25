import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RankItem
{
  final String username;
  final int userMilliseconds;
  final String userPicUrl;
  RankItem(this.username,this.userMilliseconds,this.userPicUrl);
}
class RankTimeText extends StatelessWidget {
  final int type;
  final Widget child;
  RankItem? rankItem=RankItem('',10,'');
  RankTimeText({
    required this.child,
    required this.type,//0=纯文字，1=气泡文字
    this.rankItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(type==0){
      return Container(
        width: 120,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            child,
          ],
        ),
      );
    }
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(155, 0, 0, 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
