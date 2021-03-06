import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project_flutter/api/picsum_api.dart';
import 'package:test_project_flutter/models/api_response.dart';
import 'package:test_project_flutter/models/picsum_model.dart';

class PicsumController extends ChangeNotifier {
  int currentIndex = 0;

  int currentPage = 1;
  int totalAvailablePage = 1;

  bool isLoading = true;

  bool isError = false;
  String errorMessage = '';

  List<Picsum> picsumModelList = [];
  String picsumModel = "";

  Future<void> loadingData() async {
    ApiResponse result = await PicsumApi.instance.getPicsumList(currentPage);

    if (result.error) {
      isError = result.error;
      errorMessage = result.message;
    }

    if (!result.error) {
      picsumModelList.addAll(result.picsumList!);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadingImg(String imgId) async {
    ApiResponse result = await PicsumApi.instance.getPicsumImage(imgId);

    if (result.error) {
      isError = result.error;
      errorMessage = result.message;
    }

    if (!result.error) {
      picsumModel = result.picsumImg!;
    }

    isLoading = false;
    notifyListeners();
  }

  void navbarIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}