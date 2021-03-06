import 'package:douban/application.dart';
import 'package:douban/constant/color_constant.dart';
import 'package:douban/constant/constant.dart';
import 'package:douban/model/subject.dart';
import 'package:douban/model/top_item_bean.dart';
import 'package:douban/repository/movie_repository.dart';
import 'package:douban/routers/routers.dart';
import 'package:douban/views/movie/hot_soon_tab_bar.dart';
import 'package:douban/views/movie/title_widget.dart';
import 'package:douban/views/movie/today_play_movie_widget.dart';
import 'package:douban/views/movie/top_item_widget.dart';
import 'package:douban/widgets/image/cache_img_radius.dart';
import 'package:douban/widgets/item_count_title.dart';
import 'package:douban/widgets/loading_widget.dart';
import 'package:douban/widgets/rating_bar.dart';
import 'package:douban/widgets/subject_mark_image_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef OnTab = void Function();
// 电影页面
class MoviePage extends StatefulWidget{
  MoviePage({Key key}):super(key:key);
  @override
  State<StatefulWidget> createState() => _MoviePageState();
}
// 电影页面
class _MoviePageState extends State<MoviePage> with AutomaticKeepAliveClientMixin{
  Widget titleWidget, hotSoonTabBarPadding;
  HotSoonTabBar hotSoonTabBar;
  List<Subject> hotShowBeans = List(); //影院热映
  List<Subject> comingSoonBeans = List(); //即将上映
  List<Subject> hotBeans = List(); //豆瓣榜单
  List<SubjectEntity> weeklyBeans = List(); //一周口碑电影榜
  List<Subject> top250Beans = List(); //Top250
  var hotChildAspectRatio;
  var comingSoonChildAspectRatio;
  int selectIndex = 0; //选中的是热映、即将上映
  var itemW;
  var imgSize;
  List<String> todayUrls = [];
  TopItemBean weeklyTopBean, weeklyHotBean, weeklyTop250Bean;
  Color weeklyTopColor, weeklyHotColor, weeklyTop250Color;
  Color todayPlayBg = Color.fromARGB(255, 47, 22, 74);
  // 页面保存在内存中不销毁
  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    super.initState();
    print('init movie_page');
    titleWidget = Padding(
      padding: EdgeInsets.only(top:10.0),
      child: TitleWidget(),
    );
    hotSoonTabBar = HotSoonTabBar(
      onTabCallBack: (index){
        setState(() {
          selectIndex = index;
        });
      }
    );
    hotSoonTabBarPadding = Padding(
      padding: EdgeInsets.only(top:35.0,bottom: 15.0),
      child: hotSoonTabBar,
    );
    requestAPI();
  }

  @override 
  Widget build(BuildContext context){
    print('build movie_page');
    if (itemW == null || imgSize <= 0) {
      MediaQuery.of(context);
      var w = MediaQuery.of(context).size.width;
      imgSize = w / 5 * 3;
      itemW = (w - 30.0 - 20.0) / 3;
      hotChildAspectRatio = (377.0 / 674.0);
      comingSoonChildAspectRatio = (377.0 / 742.0);
    }
    return Stack(
      children: <Widget>[
        // 主体内容
        containerBody(),
        // 正在加载页面，加载内容时会覆盖页面
        Offstage(
          child: LoadingWidget.getLoading(backgroundColor: Colors.green),
          offstage: !loading,
        ),  
      ],
    );
  }
  Widget containerBody(){
    return Padding(
      padding: EdgeInsets.only(left: 15,right:15),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          // title
          SliverToBoxAdapter(
            child: titleWidget,
          ),
          SliverToBoxAdapter(
            child: Padding(
              child:
                  TodayPlayMovieWidget(todayUrls, backgroundColor: todayPlayBg),
              padding: EdgeInsets.only(top: 22.0),
            ),
          ),
          SliverToBoxAdapter(
            child: hotSoonTabBarPadding,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context,int index){
                var hotMovieBean;
                var comingSoonBean;
                if (hotShowBeans.length>0){
                  hotMovieBean = hotShowBeans[index];
                }
                if(comingSoonBeans.length>0){
                  comingSoonBean  = comingSoonBeans[index];
                }
                return Stack(
                  children: <Widget>[
                    Offstage(
                      child: _getComingSoonItem(comingSoonBean,itemW),
                      offstage: !(selectIndex == 1 && comingSoonBeans!=null && comingSoonBeans.length>0),
                    ),
                    Offstage(
                      child: _getHotMovieItem(hotMovieBean, itemW),
                      offstage: !(selectIndex == 0 &&
                          hotShowBeans != null &&
                          hotShowBeans.length > 0)
                    ),
                  ],
                );
              },
              childCount: math.min(_getChildCount(),6)
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: _getRatio()
            ),
          ),
          getCommonImg(Constant.IMG_TMP1, null),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: ItemCountTitle(
                '豆瓣热门',
                fontSize: 13.0,
                count: hotBeans == null ? 0 : hotBeans.length,
              ),
            ),
          ),
          getCommonSliverGrid(hotBeans),
          getCommonImg(Constant.IMG_TMP2, null),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: ItemCountTitle(
                '豆瓣榜单',
                count: weeklyBeans == null ? 0 : weeklyBeans.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: imgSize,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  TopItemWidget(
                    title: '一周口碑电影榜',
                    bean: weeklyTopBean,
                    partColor: weeklyTopColor,
                  ),
                  TopItemWidget(
                    title: '一周热门电影榜',
                    bean: weeklyHotBean,
                    partColor: weeklyHotColor,
                  ),
                  TopItemWidget(
                    title: '豆瓣电影 Top250',
                    bean: weeklyTop250Bean,
                    partColor: weeklyTop250Color,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getRatio(){
    if (selectIndex == 0) {
      return hotChildAspectRatio;
    } else {
      return comingSoonChildAspectRatio;
    }
  }
  int _getChildCount() {
    if (selectIndex == 0) {
      return hotShowBeans.length;
    } else {
      return comingSoonBeans.length;
    }
  }
  getCommonImg(String url, OnTab onTab){
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top:15.0),
        child: CacheImgRadius(
          imgUrl:url,
          radius: 5.0,
          onTab: () {
            if (onTab !=null){
              onTab();
            }
          }
        ),
      ),
    );
  }
  MovieRepository repository = MovieRepository();
  bool loading = true;
  void requestAPI() async {
    Future(()=>(repository.requestAPI())).then((value){
      hotShowBeans = value.hotShowBeans;
      comingSoonBeans = value.comingSoonBeans;
      hotBeans = value.hotBeans;
      weeklyBeans = value.weeklyBeans;
      top250Beans = value.top250Beans;
      todayUrls = value.todayUrls;
      weeklyTopBean = value.weeklyTopBean;
      weeklyHotBean = value.weeklyHotBean;
      weeklyTop250Bean = value.weeklyTop250Bean;
      weeklyTopColor = value.weeklyTopColor;
      weeklyHotColor = value.weeklyHotColor;
      weeklyTop250Color = value.weeklyTop250Color;
      todayPlayBg = value.todayPlayBg;
      hotSoonTabBar.setCount(hotShowBeans);
      hotSoonTabBar.setComingSoon(comingSoonBeans);
    //  hotTitle.setCount(hotBeans.length);
    //  topTitle.setCount(weeklyBeans.length);
      setState(() {
        loading = false;
      });
    });
  }
  // 即将上映item
  Widget _getComingSoonItem(Subject comingSoonBean, var itemW){
    if (comingSoonBean == null) {
      return Container();
    }
    String mainlandPubdate = comingSoonBean.mainland_pubdate;
    mainlandPubdate = mainlandPubdate.substring(5, mainlandPubdate.length);
    mainlandPubdate = mainlandPubdate.replaceFirst(RegExp(r'-'), '月') + '日';
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context,'${Routes.detailPage}?subjectId=${comingSoonBean.id}');
      },
      child: Container(
        alignment: Alignment.topLeft,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SubjectMarkImageWidget(
              comingSoonBean.images.large,
              width: itemW,
            ),
            Padding(
              padding: EdgeInsets.only(top:5.0, bottom:5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  comingSoonBean.title,
                  // 是否多行显示
                  softWrap: false,
                  // 多出的文本渐隐
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.colorRed277),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    mainlandPubdate,
                    style: TextStyle(
                        fontSize: 8.0, color: ColorConstant.colorRed277),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///影院热映item
  Widget _getHotMovieItem(Subject hotMovieBean, var itemW) {
    if (hotMovieBean == null) {
      return Container();
    }
    return GestureDetector(
      onTap:(){
        Application.router.navigateTo(context, '${Routes.detailPage}?subjectId=${hotMovieBean.id}');
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SubjectMarkImageWidget(
              hotMovieBean.images.large,
              width: itemW,
            ),
            Padding(
              padding: EdgeInsets.only(top:5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  hotMovieBean.title,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            RatingBar(
              hotMovieBean.rating.average,
              size: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  ///豆瓣热门
  Widget getCommonSliverGrid(List<Subject> hotBeans) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context,int index){
          return _getHotMovieItem(hotBeans[index], itemW);
        },
        childCount: math.min(hotBeans.length,6),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 0.0,
        childAspectRatio: hotChildAspectRatio
      ),
    );
  }
}
