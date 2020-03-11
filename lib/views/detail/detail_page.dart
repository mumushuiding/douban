import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget{
  final subjectId;
  DetailPage({this.subjectId,Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    print('detail page subjectId=$subjectId');
    return Container(
      child: Text(
        'detail page'
      ),
    );
  }
  
}