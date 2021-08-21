import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:infoanetask/app/data/models/duckgo.dart' as duck;

import 'package:infoanetask/app/modules/detail/views/detail_view.dart';
import 'package:infoanetask/app/modules/home/controllers/home_controller.dart';

class Namesearch extends SearchDelegate<String> {
  final cities = ['hyderabad', 'banglore', 'chennai', 'pune', 'vizag'];
  final recentcities = ['vizag', 'hyderabad', 'chennai'];
  final controller = Get.find<HomeController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              navigator?.pop();
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          navigator?.pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_city,
            size: 120,
          ),
          SizedBox(
            height: 20,
          ),
          Text(query)
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<duck.Welcome>(
        future: (controller.getdata(query: query)),
        builder: (context, as) {
          if (as.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: (query.isEmpty
                    ? as.data?.relatedTopics.length
                    : as.data?.relatedTopics
                        .where((element) {
                          final qt = query.toLowerCase();
                          final et = element.text.toLowerCase();
                          return et.startsWith(qt);
                        })
                        .toList()
                        .length),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.to(DetailView(), arguments: {
                            'imageurl': query.isEmpty
                                ? (as.data?.relatedTopics[index].icon.url
                                    .toString())
                                : as.data?.relatedTopics
                                    .where((element) {
                                      final qt = query.toLowerCase();
                                      final et = element.text.toLowerCase();
                                      return et.startsWith(qt);
                                    })
                                    .toList()[index]
                                    .icon
                                    .url,
                            'title': query.isEmpty
                                ? (as.data?.relatedTopics[index].text)
                                : as.data?.relatedTopics
                                    .where((element) {
                                      final qt = query.toLowerCase();
                                      final et = element.text.toLowerCase();
                                      return et.startsWith(qt);
                                    })
                                    .toList()[index]
                                    .text
                          });
                        },
                        title: query.isEmpty
                            ? Text(
                                (as.data?.relatedTopics[index].text).toString())
                            : Text((as.data?.relatedTopics
                                    .where((element) {
                                      final qt = query.toLowerCase();
                                      final et = element.text.toLowerCase();
                                      return et.startsWith(qt);
                                    })
                                    .toList()[index]
                                    .text)
                                .toString()),
                      ),
                      Divider(
                        thickness: 2,
                      )
                    ],
                  );
                });
          }
        });
  }
}
