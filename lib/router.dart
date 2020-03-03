import 'package:flutter/material.dart';
class Router {
  static const searchPage = 'app://SearchPage';
  Router.push(BuildContext context, String url,dynamic params) {
    print('router push');
  }
}