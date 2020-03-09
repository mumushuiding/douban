class TopItemBean{
  var count;//共多少部
  var imgUrl;//图片url
  List<Item> items;//多少个电影
  TopItemBean(this.count, this.imgUrl, this.items);
}
class Item {
  var title; //电影名称
  var average; //评分
  bool upOrDown; //热度上升还是下降

  Item(this.title, this.average, this.upOrDown);
}