import 'package:flutter/material.dart';

import 'group/group_page.dart';
import 'home/home_page.dart';
import 'movie/book_audio_video_page.dart';
import 'person/person_center_page.dart';
import 'shop_page.dart';
// 整个App的最外层容器
class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
   
    return _ContainerPageState();
  }
}
class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon,this.normalIcon);
}
class _ContainerPageState extends State<ContainerPage> {
  final ShopPageWidget shopPageWidget = ShopPageWidget();
  List<Widget> pages;
  final defaultItemColor = Color.fromARGB(255, 125, 125, 125);

  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.png',
        'assets/images/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/ic_tab_subject_active.png',
        'assets/images/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/ic_tab_group_active.png',
        'assets/images/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/ic_tab_shiji_active.png',
        'assets/images/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/ic_tab_profile_active.png',
        'assets/images/ic_tab_profile_normal.png')
  ];

  List<BottomNavigationBarItem> itemList;

  @override
  void initState(){
    super.initState();
    print('initState _ContainerPageState');
    if (pages == null){
      pages = [
        HomePage(),
        BookAudioVideoPage(),
        GroupPage(),
        shopPageWidget,
        PersonCenterPage()
      ];
    }
    if (itemList == null){
      itemList = itemNames.map((item) => BottomNavigationBarItem(
        icon: Image.asset(
          item.normalIcon,
          width: 30.0,
          height: 30.0,
        ),
        title: Text(
          item.name,
          style: TextStyle(fontSize: 10.0),
        ),
        activeIcon: Image.asset(
          item.activeIcon,
          width: 30.0,
          height: 30.0,
        ),
      )).toList();
    }
  }
  int _selectIndex = 0;

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(enabled: _selectIndex == index, child: pages[index]),
    );
  }

  @override
  void didUpdateWidget(ContainerPage oldWidget){
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  Widget build(BuildContext context) {
    print('build _ContainerPageState');
    return Scaffold(
      body: new Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ]
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          print('bottomNavigationBar onTap $index');
          setState((){
            ///这里根据点击的index来显示，非index的page均隐藏
            _selectIndex = index;
            //这个是用来控制比较特别的shopPage中WebView不能动态隐藏的问题
            shopPageWidget.setShowState(pages.indexOf(shopPageWidget) == _selectIndex);
          });
        },
        //图标大小
        iconSize: 24,
        //当前选中的索引
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

}