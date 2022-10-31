import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/domain/joke_model.dart';


class FetchFavourites extends Notifier<Future<List>> {

  final List favourites = [];

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    return '$path/favourites.json';
  }

  Future<File> getLocalFile() async {
    File file = File(await getLocalPath());
    return file;
  }

  Future<List> writeJokeJson(Joke newJoke) async {
    final file = await getLocalFile();
    favourites.add(newJoke);
    favourites.map((joke) => joke.toJson()).toList();
    file.writeAsStringSync(json.encode(favourites));

    return favourites;
  }

  Future<List> writeListJson(List list) async {
    final file = await getLocalFile();
    file.writeAsStringSync(json.encode(list));

    return list;
  }

  @override
  Future<List> build() {
    return writeListJson(favourites);
  }

  void addFavourite(Joke joke) {
    joke.isFavourite = true;
    state = writeJokeJson(joke);
  }

  void removeFavourite(String id) async {
    final joke = favourites.singleWhere((element) =>
    element.id == id, orElse: () {
      return null;
    });
    joke.isFavourite = false;
    favourites.removeWhere((element) => element.id == id);
    state = writeListJson(favourites);
  }
}

final fetchFavouritesProvider = NotifierProvider<FetchFavourites, Future<List>>(() {
  return FetchFavourites();
});