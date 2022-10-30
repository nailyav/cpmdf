import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' as rootBundle;
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

  void createFile() async {
    File file = File(await getLocalPath());
    Joke joke = Joke("", "0", "", "this is a demo joke");
    favourites.add(joke);
    favourites.map((joke) => joke.toJson()).toList();

    file.writeAsStringSync(json.encode(favourites));
  }

  Future<File> getLocalFile() async {
    createFile();
    File file = File(await getLocalPath());
    print('File created successfully!');
    return file;
  }

  Future<List> readJson() async {
    final file = await getLocalFile();
    final String response = await file.readAsString();
    final data = await jsonDecode(response) as List<dynamic>;

    return data.map((joke) => Joke.fromJson(joke)).toList();
  }

  Future<List> writeJson(Joke newJoke) async {
    // final file = await getLocalFile();
    File file = File(await getLocalPath());
    favourites.add(newJoke);
    favourites.map((joke) => joke.toJson()).toList();

    file.writeAsStringSync(json.encode(favourites));

    return favourites;
  }

  @override
  Future<List> build() {
    return readJson();
  }

  void getFavourites() {
    try {
      state = readJson();
    } on Exception catch (e) {
      print(e);
    }
  }

  void addFavourite(Joke joke) {
    state = writeJson(joke);
  }

  void deleteFavourite(int id) {

  }
}

final fetchFavouritesProvider = NotifierProvider<FetchFavourites, Future<List>>(() {
  return FetchFavourites();
});