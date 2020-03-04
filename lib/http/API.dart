import 'package:douban/model/search_result.dart';

import 'http_request.dart';
import 'mock_request.dart';

typedef RequestCallBack<T> = void Function(T value);

class API{
  static const BASE_URL = 'https://api.douban.com';

  ///TOP250
  static const String TOP_250 = '/v2/movie/top250';

  ///正在热映
  static const String IN_THEATERS = '/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///即将上映
  static const String COMING_SOON = '/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///一周口碑榜
  static const String WEEKLY = '/v2/movie/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///影人条目信息
  static const String CELEBRITY = '/v2/movie/celebrity/';

  static const String REIVIEWS = '/v2/movie/subject/26266893/reviews';

  var _request = HttpRequest(API.BASE_URL);

  void searchMovie(
    String searchContent, RequestCallBack requestCallBack) async {
    // 访问远程数据
    //   final result= await _request.get(
    //     '/v2/movie/search?q=$searchContent&apikey=0b2bdeda43b5688921839c8ecb20399b');
    
    // 若接口不能使用，使用模拟数据
    var req = MockRequest();
    var result = await req.get(API.COMING_SOON);

    // 将json 转换成对象
    SearchResult bean = SearchResult.fromJson(result);
    requestCallBack(bean);
    }
}