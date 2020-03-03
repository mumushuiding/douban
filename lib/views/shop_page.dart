import 'package:flutter/material.dart';
bool _closed = false;
bool _isShow = true;
class ShopPageWidget extends StatelessWidget{

  void setShowState(bool isShow){
    _isShow = isShow;
    if (!isShow) {
      _closed = true;
      // _webviewReference.hide();
      // _webviewReference.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Text('Shop Page'),
    );
  }
  
}