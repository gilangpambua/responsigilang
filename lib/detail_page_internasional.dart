import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPageInternasional extends StatelessWidget {
  final dynamic post;

  const DetailPageInternasional({required Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = post['title'];
    final String pubDate = post['pubDate'];
    final String thumbnail = post['thumbnail'];
    final String description = post['description'];
    final String link = post['link'];
    final DateTime pubDateTime = DateTime.parse(pubDate);
    final formattedPubDate = DateFormat('EEEE, d MMMM yyyy').format(pubDateTime);

    void launchUrl(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        centerTitle: true,
        backgroundColor: Color(0xff017b6e),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(formattedPubDate),
            ),
            if (thumbnail.isNotEmpty)
              Image.network(
                thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    launchUrl(link);
                  },
                  child: Text(
                    'Baca selengkapnya...',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}