import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:subreddit_app/model.dart';
import 'package:http/http.dart' as http;

class Api {
  Dio dio = Dio();


  Future<List<Posts>> getData() async {
    var jsonData = await http.get("https://www.reddit.com/r/FlutterDev/.json?count=20");
    var rawData = jsonDecode(jsonData.body);
    List<Posts> posts = [];
    for(var u in rawData['data']['children']){
      Posts post = Posts(title: u['data']['title'], text: u['data']['selftext']);
      posts.add(post);
    }
    return posts;
  }
}
