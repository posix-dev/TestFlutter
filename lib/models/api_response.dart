import 'package:test_project_flutter/models/picsum_model.dart';

class ApiResponse {
  List<Picsum>? picsumList;
  String? picsumImg;
  bool error;
  String message;

  ApiResponse({this.picsumList, required this.error, required this.message, this.picsumImg});
}
