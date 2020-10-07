import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subreddit_app/api.dart';
import 'package:subreddit_app/detail.dart';
import 'package:subreddit_app/model.dart';

void main() {
  runApp(MaterialApp(title: 'Subreddit App', theme: ThemeData(primarySwatch: Colors.red,),home: HotPosts(),));
}

class HotPosts extends StatefulWidget {

  @override
  _HotPostsState createState() => _HotPostsState();
}

class _HotPostsState extends State<HotPosts> {
  Api api = new Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Posts>> data = api.getData();
    return Scaffold(
        appBar: AppBar(
          title: Text("What's hot on r/FlutterDev"),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: FutureBuilder(
              future: data,
              builder: (context, snap) {
                if(snap.connectionState == ConnectionState.none && snap.hasData == null){
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(snap.data[index].title),
                        subtitle: Text(checkText(snap.data[index].text)),
                        onTap: () {
                          changeRoute(snap.data[index].title, snap.data[index].text);
                        },
                      );
                    }
                );
              }
          ),
        )

    );
  }

  checkText(input){
    return (input.length > 50) ? input.substring(0, 49) : input;
  }

  changeRoute(String title, String text) async {
    Future.delayed(Duration.zero, () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => Detail(title: title, text: text,),
          ));
    });
  }

  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      Future<List<Posts>> data = api.getData();
    });
    return null;
  }
}