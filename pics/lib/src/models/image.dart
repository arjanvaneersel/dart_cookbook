import 'dart:convert';

class ImageModel {
  int id;
  String url;
  String title;

  ImageModel(this.id, this.url, this.title);
  
  ImageModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    url = data['url'];
    title = data['title'];
  }
}