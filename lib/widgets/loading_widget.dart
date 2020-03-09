import 'package:flutter/material.dart';

class LoadingWidget{
  static Widget getLoading({Color backgroundColor,Color loadingColr}){
    return Container(
      alignment: AlignmentDirectional.center,
      child: Text('加载中'),
    );
  }
}