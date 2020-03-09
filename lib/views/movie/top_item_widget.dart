import 'package:douban/model/top_item_bean.dart';
import 'package:flutter/material.dart';

class TopItemWidget extends StatelessWidget{
  final String title;
  final TopItemBean bean;
  final Color partColor;

//  var _imgSize;

  TopItemWidget({
    Key key,
    @required this.title,
    @required this.bean,
    this.partColor = Colors.brown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Text('Top item widget'),
    );
  }
  
}