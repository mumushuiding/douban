import '../../router.dart';
import '../../widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import '../model/subject.dart';
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print('build HomePage');
    return getWidget();
  }
}
var _tabs = ['动态', '推荐'];
// 返回默认的Tab控制器
DefaultTabController getWidget() {
  return DefaultTabController(
    initialIndex: 1,
    length: _tabs.length,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            // SliverAppBar 待完善
            child: SliverAppBar(
                pinned: true,
                expandedHeight: 120.0,
                primary: true,
                titleSpacing: 0.0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(  
                collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Colors.green,
                    child: SearchTextFieldWidget(
                      hintText: '影视作品中你难忘的离别',
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      onTab: () {
                        Router.push(context, Router.searchPage, '影视作品中你难忘的离别');
                      },
                    ),
                    alignment: Alignment(0.0, 0.0),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: _tabs
                    .map((String name) => Container(
                          child: Text(
                            name,
                          ),
                          padding: const EdgeInsets.only(bottom: 5.0),
                        ))
                    .toList(),
                )
            )
          )
        ];
      },
      body: TabBarView(
        // tab下的内容
        children: _tabs.map((String name) {
          return SliverContainer(
            name: name,
          );
        }).toList(),
      )
    ),
  );
}
class SliverContainer extends StatefulWidget{
  final String name;
  SliverContainer({Key key, @required this.name}) : super(key:key);
  @override
  _SliverContainerState createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer>{

  @override
  void initState() {
    super.initState();
    print('init state${widget.name}');
    ///请求动态数据
    if (list == null || list.isEmpty) {
      if (_tabs[0] == widget.name) {
        requestAPI();
      } else {
        ///请求推荐数据
        requestAPI();
      }
    }
  }

  // 添加 subject
  List<Subject> list;

  void requestAPI() {
    print("请求动态数据");
  }

  @override
  Widget build(BuildContext context) {
    
    return getContentSliver(context, list);
  }
  getContentSliver(BuildContext context, List<Subject> list) {
    if (widget.name == _tabs[0]) {
      return _loginContainer(context);
    }

    print('getContentSliver');

    if (list == null || list.length == 0) {
      return Center(
        child: Text('暂无数据')
      );
    }
    // 返回SafeArea
    return Center(
        child: Text('返回SafeArea')
      );
  }
  ///动态TAB
  _loginContainer(BuildContext context){
    return Text('_loginContainer');
  }
}