import 'package:flutter/material.dart';

class PersonCenterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // Scaffold 实现了基本的 material 布局
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea 解决异形屏的问题
      body: SafeArea(
        child: Padding (
          padding: EdgeInsets.only(top:10.0),
          child: CustomScrollView(
            // physics 对用户输入的反应方式
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.green,
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.red,
                  child: Text('box 1'),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.blue,
                  child: Text('box 2'),
                ),
              ),
              _divider(),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.red,
                  child: Text('box 3'),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.blue,
                  child: Text('box 4'),
                ),
              ),
              _divider(),
              _dataSelect(),
              _divider(),
              _personItem('ic_me_journal.png', '我的发布'),
              _personItem('ic_me_follows.png', '我的关注'),
              _personItem('ic_me_photo_album.png', '相册'),
              _personItem('ic_me_doulist.png', '豆列 / 收藏'),
              _divider(),
              _personItem('ic_me_wallet.png', '钱包'),
            ],
          ),
        ),
      ),
    );
  }
  // 分割线
  SliverToBoxAdapter _divider(){
    return SliverToBoxAdapter(
      child: Container(
        height:10.0,
        color: const Color.fromARGB(255, 247, 247, 247),
      ),
    );
  }
  _dataSelect(){
    return UseNetDataWidget();
  }
}
///这个用来改变书影音数据来自网络还是本地模拟
class UseNetDataWidget extends StatefulWidget{
  @override
  _UseNet
}
class _UseNetDataWidget extends State<UseNetDataWidget> {

}