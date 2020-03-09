

import 'package:douban/application.dart';
import 'package:douban/routers/routers.dart';
import 'package:douban/widgets/my_tab_bar_widget.dart';
import 'package:douban/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

var titleList = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

List<Widget> tabList;
TabController _tabController;
class BookAudioVideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BookAudioVideoPageState();
}
class _BookAudioVideoPageState extends State<BookAudioVideoPage> with SingleTickerProviderStateMixin{
  var tabBar;

  @override
  void initState(){
    super.initState();
    tabBar = HomePageTabBar();
    tabList = getTabList();
    // _tabController = TabController(vsync: this, length: tabList.length);
  }
  List<Widget> getTabList(){
    return titleList.map((item)=> Text('$item',style: TextStyle(fontSize: 15),)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: DefaultTabController(
          length: tabList.length,
          child: _getNestedScrollView(tabBar),
        ),
      ),
    );
  }
}

Widget _getNestedScrollView(Widget tabBar){
  String hintText = '用一部电影来形容你的2018';
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child:Row(
              children: <Widget>[
                Expanded(
                  child: SearchTextFieldWidget(
                      hintText: hintText,
                      onTab: () {
                        Application.router.navigateTo(context, '${Routes.searchPage}?searchHintContent=${Uri.encodeComponent(hintText)}');
                      },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: (){
                    print('message');
                  },
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: _SliverAppBarDelegate(
            maxHeight: 49.0,
            minHeight: 49.0,
            child: Container(
              color: Colors.white,
              child: tabBar,
            )
          ),
        ),
        
      ];
    },
    body: FlutterTabBarView(
      tabController: _tabController,
    ),
  );
}
class HomePageTabBar extends StatefulWidget{
  HomePageTabBar({Key key}):super(key:key);
  
  @override
  State<StatefulWidget> createState() => _HomePageTabBarState();

}
class _HomePageTabBarState extends State<HomePageTabBar>{
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Colors.black;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Colors.grey)),
      ),
      margin: EdgeInsets.only(top:10.0,bottom: 10.0),
      child: TabBar(
        tabs: tabList,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectedStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate{

   _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight),minExtent);

  @override
  double get minExtent => minHeight;

  @override
  // 返回真就重新渲染SliverPersistentHeader
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {

    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child!=oldDelegate.child;
  }
  
}