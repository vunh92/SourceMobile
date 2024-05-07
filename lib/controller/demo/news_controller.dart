import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/demo/article_model.dart';
import '../../model/demo/news_model.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  ScrollController scrollController = ScrollController();
  RxBool notFound = false.obs;
  RxBool isLoadmore = false.obs;
  RxString country = ''.obs;
  RxInt pageNum = 1.obs;
  RxBool isPageLoading = false.obs;
  RxInt pageSize = 10.obs;
  String baseApi = "https://newsapi.org/v2/top-headlines?";

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    getData();
    super.onInit();
  }

  _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent
        && isLoadmore.value && !isPageLoading.value) {
      getData(loadmore: true);
    }
  }

  getData({searchKey = '', loadmore = false, reload = false}) async {
    notFound.value = false;
    isPageLoading.value = true;
    if (loadmore) {
      pageNum++;
    }
    if (reload) {
      isPageLoading.value = true;
      pageNum.value = 1;
    }
    baseApi = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
    baseApi += country.isEmpty ? 'country=in&' : 'country=$country&';
    baseApi += 'apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6';
    if (searchKey != '') {
      country.value = '';
      baseApi =
      "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&q=$searchKey&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6";
    }
    print(baseApi);
    getDataFromApi(baseApi);
  }

  getDataFromApi(url) async {
    update();
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final dataResponse = NewsModel.newsFromJson(res.body);
      if (dataResponse.articles.isEmpty) {
        notFound.value = true;
        isLoadmore.value = false;
        isPageLoading.value = false;
        update();
      } else {
        if(isPageLoading.value) {
          if (isLoadmore.value) {
            articles.value = [...articles, ...dataResponse.articles];
          }else {
            articles.value = [...dataResponse.articles];
          }
          isLoadmore.value = !(dataResponse.articles.length < pageSize.value);
        }
        notFound.value = false;
        isPageLoading.value = false;
        update();
      }
    } else {
      notFound.value = true;
      update();
    }
  }
}
