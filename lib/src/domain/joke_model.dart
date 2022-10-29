import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@JsonSerializable()
class Joke {
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  Joke(this.iconUrl, this.id, this.url, this.value);

  Joke.fromJson(Map<String, dynamic> json)
      : iconUrl = json['icon_url'],
        id = json['id'],
        url = json['url'],
        value = json['value'];
}

final jokeProvider = Provider<Joke>((ref) {
  throw UnimplementedError();
});