import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef BoolCallback = void Function(bool markAdded);
///点击图片变成订阅状态的缓存图片控件
class SubjectMarkImageWidget extends StatefulWidget{
  final imgNetUrl;
  final BoolCallback markAdd;
  final width;
  SubjectMarkImageWidget(this.imgNetUrl,
      {Key key, this.markAdd, this.width = 150.0})
      : super(key: key);
  var height;
  @override
  State<StatefulWidget> createState(){
    height = this.width/150.0 * 210.0;
    return _SubjectMarkImageWidgetState();
  }
}

class _SubjectMarkImageWidgetState extends State<SubjectMarkImageWidget>{
  var markAddedIcon, defaultMarkIcon;
  var imgWH = 28.0;
  var loadImg;
  var markAdded = false;
  @override
  void initState(){
    super.initState();
    markAddedIcon = Image(
      image: AssetImage('assets/images/ic_subject_mark_added.png'),
      width: imgWH,
      height: imgWH,
    );
    defaultMarkIcon = ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0)),
      child: Image(
        image: AssetImage('assets/images/ic_subject_rating_mark_wish.png'),
        width: imgWH,
        height: imgWH,
      ),
    );
    var defaultImg = Image.asset('assets/images/ic_default_img_subject_movie.9.png');
    loadImg = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: CachedNetworkImage(
        imageUrl: widget.imgNetUrl,
        width: widget.width,
        height: widget.height,
        fit:BoxFit.fill,
        placeholder: (BuildContext context,String url){
          return defaultImg;
        },
        fadeInDuration: Duration(microseconds: 80),
        fadeOutDuration: Duration(microseconds: 80),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: <Widget>[
        loadImg,
        GestureDetector(
          child: markAdded ? markAddedIcon:defaultMarkIcon,
          onTap: (){
            if(widget.markAdd !=null ) {
              widget.markAdd(markAdded);
            }
            setState(() {
              markAdded = !markAdded;
            });
          }
        ),
      ],
    );
  }

}