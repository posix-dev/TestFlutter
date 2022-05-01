import 'package:test_project_flutter/api/constants.dart';

class RestApi {
  RestApi._();

  static RestApi get instance => RestApi._();

  static const _baseUrl = 'https://picsum.photos/';

  static picsumListApi(int page) => _baseUrl + 'v2/list' + '?page=$page&limit=$pageLimit';

  static picsumImageApi(String id) => 'http://picsum.photos/' + 'id/$id/' + '200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U';
}
