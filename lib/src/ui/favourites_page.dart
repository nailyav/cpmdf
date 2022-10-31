import 'package:cpmdf/src/application/fetch_favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/ui/app_bar.dart';


class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<List> favourites = ref.watch(fetchFavouritesProvider);

    return Scaffold(
      appBar: const MyAppBar('Favourites'),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
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
