import 'dart:convert';

import 'package:appentus_flutter_task/models/image_gallery_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// the code below is used to create a screen to display the images with author
// name from the api
class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({Key? key}) : super(key: key);

  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  // the code below is used to create a method to get the data from the api
  Future<List<ImageGalleryModel>> getDataFromApi() async {
    http.Response response = await http.get(
      Uri.parse("https://picsum.photos/v2/list"),
    );
    // if the status code is 200 then returning the response else returning the
    // error
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      // the below line of code is for debugging purpose
      print("the response from the api: ${response.body}");

      return jsonResponse.map((e) => ImageGalleryModel.fromJSON(e)).toList();
    } else {
      throw ("Cannot get data from api");
    }
  }

  //the code below is used to get the list of the data from the api
  List<Widget> getDataList(AsyncSnapshot<List<ImageGalleryModel>> snapshot) {
    List<Widget> widgetList = [];
    Widget widget;
    for (var index = 0; index < snapshot.data!.length; index++) {
      widget = Column(
        children: <Widget>[
          Flexible(
            child: Image.network(
              snapshot.data![index].imagePath.toString(),
              height: snapshot.data![index].height!.toDouble(),
              width: snapshot.data![index].width!.toDouble(),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            snapshot.data![index].authorName.toString(),
          ),
        ],
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  // using the initstate method below
  @override
  void initState() {
    super.initState();
    getDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ImageGalleryModel>>(
        future: getDataFromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: getDataList(snapshot),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
