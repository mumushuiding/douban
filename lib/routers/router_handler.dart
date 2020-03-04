import '../views/search/search.dart';
import '../views/home/home_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return HomePage();
  }
);
var searchPageHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    // 获取参数值
    String searchHintContent = params['searchHintContent']?.first;
    return SearchPage(searchHintContent: searchHintContent,);
  }
);