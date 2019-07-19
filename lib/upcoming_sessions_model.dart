import 'dart:async';
import 'dart:convert';

import 'dart:io';

class UpcomingSessions {
  final String date;
  final String name;
  final String type;
  final String imgPic;
  String imageUrl;

  UpcomingSessions(this.date, this.name, this.type, this.imgPic);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }
    // Get an Image
    HttpClient http = new HttpClient();
    try {
      var uri = new Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var decoded = json.decode(responseBody);
      var url = decoded['message'];
      imageUrl = url;
    } catch (exception) {
      print(exception);
    }
  }
}
