import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_page_islam.dart';

class IslamPage extends StatefulWidget {
  @override
  _IslamPageState createState() => _IslamPageState();
}

class _IslamPageState extends State<IslamPage> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('https://api-berita-indonesia.vercel.app/republika/islam/'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> postsData = jsonData['data']['posts'];
      setState(() {
        posts = postsData;
      });
    } else {

    }
  }

  void navigateToDetailPage(dynamic post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPageIslam(
          post: post,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPUBLIKA ISLAM'),
        centerTitle: true,
        backgroundColor: Color(0xff017b6e),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = posts[index];
          final String thumbnail = post['thumbnail'];
          final String title = post['title'];

          return Card(
            child: InkWell(
              onTap: () => navigateToDetailPage(post),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: thumbnail.isNotEmpty
                      ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : Container(
                    width: 100,
                    height: 100,
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
