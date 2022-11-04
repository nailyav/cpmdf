import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/ui/favourites_app_bar.dart';
import 'package:cpmdf/src/application/fetch_favourites.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<List> favourites = ref.watch(fetchFavouritesProvider);

    return Scaffold(
      appBar: const FavouritesAppBar('Favourites'),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
                future: favourites,
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List;
                    return Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  title: Text(data[index].value),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        snapshot.data![index].isFavourite
                                            ? ref
                                                .read(fetchFavouritesProvider
                                                    .notifier)
                                                .removeFavourite(
                                                    snapshot.data![index].id)
                                            : ref
                                                .read(fetchFavouritesProvider
                                                    .notifier)
                                                .addFavourite(
                                                    snapshot.data![index]);
                                      }),
                                ),
                              );
                            }));
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
