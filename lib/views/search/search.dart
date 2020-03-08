import 'package:douban/http/API.dart';
import 'package:douban/model/search_result.dart';
import 'package:douban/widgets/search_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  final String searchHintContent;

  SearchPage({Key key, this.searchHintContent = '阿甘正传'}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    
    return _SearchPageState();
  }

}
class _SearchPageState extends State<SearchPage>{
  final API _api = API();
  SearchResult _searchResult;
  var imgW;
  var imgH;
  bool showLoading = false;
  @override
  Widget build(BuildContext context) {

    //  图片长宽
    if (imgW == null){
      imgW = MediaQuery.of(context).size.width /7;
      imgH = imgW /0.75;
    }
    //  查询结果排序


    return Scaffold(
      body: SafeArea(
        child: showLoading ? Center(
          child: CupertinoActivityIndicator(),
        ) : _searchResult == null ? getSearchWidget() : Column(
          children: <Widget>[
            getSearchWidget(),
            // 搜索结果展示
            _searchResult.subjects ==null ? Container(child: Text('搜索结果为空'),) : Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  SearchResultSubject bean = _searchResult.subjects[index];
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: _getItem(bean, index),
                      onTap: (){
                        // 显示细节
                        // Application.router.navigateTo(context, '${Routes.detailPage}?id=${bean.id}');
                      },
                    ),
                    
                  );
                },
                itemCount: _searchResult.subjects.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  //  搜索组件
  Widget getSearchWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SearchTextFieldWidget(
              hintText: widget.searchHintContent,
              onSubmitted: (searchContent) {
                showLoading = true;
                // 搜索电影
                _api.searchMovie(searchContent, (searchResult) {
                  setState(() {
                    showLoading = false;
                    _searchResult = searchResult;
                  });
                });

              },
            ),
          ),
          // 检测点击拖动等交互操作
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                ' 取消',
              style: TextStyle(
                color: Colors.green,
                fontSize: 17.0,
                fontWeight:  FontWeight.bold
              ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

   String getType(String subtype) {
    switch (subtype) {
      case 'movie':
        return '电影';
    }
    return '';
  }
  TextStyle getStyle(Color color, double fontSize, {bool bold = false}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
  String listConvertString2(List<SearchResultSubjectsDirector> genres) {
    if (genres.isEmpty) {
      return '';
    } else {
      String tmp = '';
      for (SearchResultSubjectsDirector item in genres) {
        tmp = tmp + item.name;
      }
      return tmp;
    }
  }
  String listConvertString(List<String> genres) {
    if (genres.isEmpty) {
      return '';
    } else {
      String tmp = '';
      for (String item in genres) {
        tmp = tmp + item;
      }
      return tmp;
    }
  }
  Widget _getItem(SearchResultSubject bean, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Image.network(
            bean.images.medium,
            fit: BoxFit.cover,
            width: imgW,
            height: imgH,
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getType(bean.subtype),
                style: getStyle(Colors.grey, 12.0),
              ),
              Text(bean.title + '(${bean.year})',
                  style: getStyle(Colors.black, 15.0, bold: true)),
              Text(
                  '${bean.rating.average} 分 / ${listConvertString(bean.pubdates)} / ${listConvertString(bean.genres)} / ${listConvertString2(bean.directors)}',
                  style: getStyle(Colors.grey, 13.0))
            ],
          ),
        )
      ],
    );
  }

}