import 'package:flutter/material.dart';

typedef OnClick = void Function();
///左边是豆瓣热门，右边是全部
class ItemCountTitle extends StatelessWidget{
  final count;
  final OnClick onClick;
  final String title;
  final double fontSize;

  ItemCountTitle(this.title, {Key key, this.onClick, this.count, this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      child: Container(
        child: Text('itemcount title'),
      ),
    );
  }
  
}