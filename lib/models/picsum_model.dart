import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Picsum> picsumModelFromJson(String str) =>
    List<Picsum>.from(json.decode(str).map((x) => Picsum.fromJson(x)));

String picsumFromJson(String data) => json.decode(data);

class Picsum extends Equatable {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  Picsum({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  factory Picsum.fromJson(Map<String, dynamic> json) => Picsum(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['author'] = author;
    map['width'] = width;
    map['height'] = height;
    map['url'] = url;
    map['download_url'] = downloadUrl;
    return map;
  }

  @override
  List<Object?> get props => [id, url, downloadUrl];
}
