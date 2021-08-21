import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    print('${Get.arguments['imageurl']}');
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Get.arguments['imageurl'].length == 0
                ? Image.network(
                    'https://i.pinimg.com/originals/16/2d/94/162d943ece4cc130aa6ad893b8430d92.jpg')
                : Image.network(
                    'http://api.duckduckgo.com/${Get.arguments['imageurl']}'),
            Text('${Get.arguments['title']}')
          ],
        ),
      ),
    );
  }
}
