import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infoanetask/app/data/models/duckgo.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  Future<Welcome> getdata({required String query}) async {
    var client = http.Client();
    dynamic newsmodel;
    var response = await client.get(Uri.parse(
        'http://api.duckduckgo.com/?q=simpsons+characters&format=json'));
    if (response.statusCode == 200) {
      var jsonstring = response.body;
      var jsonmap = json.decode(jsonstring);
      newsmodel = Welcome.fromJson(jsonmap);
    }
    return newsmodel;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
