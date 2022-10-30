import 'dart:convert';
import 'dart:ffi';

import 'package:cpmdf/src/application/fetch_favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/joke_model.dart';


class FavouritesPage extends ConsumerWidget {
  FavouritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<List> favourites = ref.watch(fetchFavouritesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favourites',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Display the data loaded from sample.json
            FutureBuilder<List<dynamic>>(
            future: favourites,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(data[index].value);
                      }
                  );
                }
                return const CircularProgressIndicator();
              }
            ),
          ],
        ),
      ),
    );
  }
}
