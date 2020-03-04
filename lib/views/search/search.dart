import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget{
  final String searchHintContent;
  ///搜索框中的默认显示内容
  SearchPage({Key key,this.searchHintContent = '默认'})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 在标题上显示参数值
        title: Text(searchHintContent),
      ),
      body: Center(
        child: RaisedButton(
                    onPressed: () => Navigator.pop(context, '来自第二个界面'),
                    child: Text('返回上一个界面')
                )
      ),
    );
  }
}