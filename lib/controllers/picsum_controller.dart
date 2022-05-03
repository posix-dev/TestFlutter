import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project_flutter/api/picsum_api.dart';
import 'package:test_project_flutter/models/api_response.dart';
import 'package:test_project_flutter/models/picsum_model.dart';

class PicsumController extends ChangeNotifier {
  final controller = ScrollController();

  int currentIndex = 0;

  int totalAvailablePage = 6;

  bool isLoading = false;

  bool isError = false;
  String errorMessage = '';

  String picsumModel = "";

  Future<List<Picsum>?> loadData({int page = 1}) async {
    ApiResponse result = await PicsumApi.instance.getPicsumList(page);

    isLoading = false;

    if (result.error) {
      isError = result.error;
      errorMessage = result.message;
      notifyListeners();
    }

    if (!result.error) {
      notifyListeners();
      return result.picsumList;
    }
  }
}