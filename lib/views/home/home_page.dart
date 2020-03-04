import 'dart:convert';

import 'package:douban/application.dart';
import 'package:douban/routers/routers.dart';

import '../../http/mock_request.dart';
import '../../widgets/search_text_field_widget.dart';
import '../../http/API.dart';
import 'package:flutter/material.dart';
import '../../model/subject.dart';
import '../../constant/constant.dart';
import '../../widgets/image/radius_img.dart';
import '../../widgets/video_widget.dart';
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
                // 固定在顶部
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: 100.0,
                forceElevated: false,
                titleSpacing: NavigationToolbar.kMiddleSpacing,
                backgroundColor: Colors.green,
                flexibleSpace: new FlexibleSpaceBar(  
                  collapseMode: CollapseMode.pin,
                  background: Container(
                  color: Colors.green,
                  child: SearchTextFieldWidget(
                    hintText: '影视作品中你难忘的离别',
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    onTab: () {
                      // 必须重新编码
                      var json = Uri.encodeComponent('影视作品中你难忘的离别');
                      Application.router.navigateTo(context, '${Routes.searchPage}?searchHintContent=$json');
                    },
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
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

  void requestAPI() async{
    print("请求动态数据");
    var _request = MockRequest();
    var result = await _request.get(API.TOP_250);
    var resultList = result['subjects'];
    list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    setState(() {});
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
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context){
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: PageStorageKey<String>(widget.name),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return getCommonItem(list, index);
                  },
                  childCount: list.length
                ),
              )
            ],
          );
        },
      ),
    );
  }
  double singleLineImgHeight = 180.0;
  double contentVideoHeight = 350.0;
  ///列表的普通单个item
   getCommonItem(List<Subject> items, int index){
     Subject item = items[index];
     bool showVideo = index == 1 || index == 3;
    return Container(
      height: showVideo ? contentVideoHeight : singleLineImgHeight,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(
          left: Constant.MARGIN_LEFT,
          right: Constant.MARGIN_RIGHT,
          top: Constant.MARGIN_RIGHT,
          bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(item.casts[0].avatars.medium),
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(item.title),
              ),
              Expanded(
                child: Align(
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  alignment: Alignment.centerRight,
                ),
              )
            ]
          ),
          // 填充多余空间
          Expanded(
            child: Container(
              child: showVideo ? getContentVideo(index) : getItemCenterImg(item),
            )
          ),
          // 底下评论点赞标志
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_vote.png',
                  width: 25.0,
                  height: 25.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG +
                      'ic_notification_tv_calendar_comments.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_status_detail_reshare_icon.png',
                  width: 25.0,
                  height: 25.0,
                ),
              ],
            ),
          ),
          
        ]
      ),
    );
   }

   getContentVideo(int index) {
      if(!mounted){
        return Container();
      }
      return VideoWidget(
        index == 1 ? Constant.URL_MP4_DEMO_0 :  Constant.URL_MP4_DEMO_1,
        showProgressBar: false,
      );
   }
   getItemCenterImg(Subject item){
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
         Expanded(
           child: RadiusImg.get(
             item.images.large, null,
             shape: RoundedRectangleBorder(
               borderRadius:BorderRadius.only(
                 topLeft: Radius.circular(5.0),
                 bottomLeft: Radius.circular(5.0)
               ),
             )
           ),
         ),
         Expanded(
           child: RadiusImg.get(item.casts[1].avatars.medium, null, radius: 0.0),
         ),
         Expanded(
           child: RadiusImg.get(item.casts[2].avatars.medium, null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)))),
         ),
       ]
     );
   }
}
///动态TAB
_loginContainer(BuildContext context){
  return Text('_loginContainer');
}