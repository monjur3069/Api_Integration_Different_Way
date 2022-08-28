import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondExample extends StatefulWidget {
  static const String routeName = '/secondexample';

  const SecondExample({Key? key}) : super(key: key);

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPostsPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      photosList.clear();
      for (Map i in data) {
        PhotosModel photos =
            PhotosModel(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Method fetch data'),
      ),
      body: FutureBuilder(
        future: getPostsPhotos(),
        builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: photosList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150/92c952'),
                  ),

                        title: Text(snapshot.data![index].id.toString()),
                        //1st way to get data
                        subtitle: Text(photosList[index]
                            .title
                            .toString()), //second way to get data
                      ),
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

class PhotosModel {
  String title, url;
  num id;

  PhotosModel({required this.title, required this.url, required this.id});
}
