import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/demo/news_controller.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  NewsController newsController = Get.put(NewsController());

  @override
  void dispose() {
    //Todo: clear controller
    // Get.delete<NewsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Demo Page"),
      ),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          return controller.notFound.value
              ? const Center(child: Text("Not Found", style: TextStyle(fontSize: 30)))
              : controller.articles.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            controller: controller.scrollController,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        // onTap: () => Get.to(ViewNews(
                        //     newsUrl: controller.demoList[index].url)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Stack(children: [
                                controller.articles[index].urlToImage ==
                                    null
                                    ? Container()
                                    : ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    placeholder: (context,
                                        url) =>
                                        Container(
                                            child:
                                            const CircularProgressIndicator()),
                                    errorWidget:
                                        (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl: controller
                                        .articles[index]
                                        .urlToImage ??
                                        '',
                                  ),
                                ),
                              ]),
                              const Divider(),
                              Text(controller.articles[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  index == controller.articles.length - 1 &&
                      controller.isPageLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(),
                ],
              );
            },
            itemCount: controller.articles.length,
          );
        },
        init: NewsController(),
      ),
    );
  }
}
