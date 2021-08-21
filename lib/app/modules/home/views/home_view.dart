import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoanetask/app/data/models/duckgo.dart' as duck;
import 'package:infoanetask/app/modules/detail/views/detail_view.dart';

import 'package:infoanetask/app/modules/home/controllers/home_controller.dart';
import 'package:infoanetask/app/modules/home/widgets/searchdelegate.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<duck.Welcome> we;

  final controller = Get.put(HomeController());
  @override
  void initState() {
    we = controller.getdata(query: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('characterlist'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Namesearch());
                },
                icon: Icon(
                  Icons.search,
                  size: 40,
                ))
          ],
        ),
        body: StreamBuilder<duck.Welcome>(
            stream: we.asStream(),
            builder: (context, as) {
              if (as.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: (as.data?.relatedTopics.length),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              SizerUtil.deviceType == DeviceType.mobile
                                  ? Get.to(DetailView(), arguments: {
                                      'imageurl': (as
                                          .data?.relatedTopics[index].icon.url
                                          .toString()),
                                      'title':
                                          (as.data?.relatedTopics[index].text)
                                    })
                                  : print('hh');
                              ;
                            },
                            child: ListTile(
                              title: Text((as.data?.relatedTopics[index].text)
                                  .toString()),
                            ),
                          ),
                          SizerUtil.deviceType == DeviceType.tablet
                              ? Image.network(
                                  'http://api.duckduckgo.com/${as.data?.relatedTopics[index].icon.url}')
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      );
                    });
              }
            }));
  }
}
