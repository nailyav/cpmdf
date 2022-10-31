import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/application/fetch_favourites.dart';
import 'package:cpmdf/src/domain/joke_model.dart';


class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar(this.joke, this.title, {super.key});
  final Future<Joke> joke;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchFavouritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person_rounded,
              color: Colors.white,
            ),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Personal Info'),
                content: const Text(
                    'name: Nailya Valiullina\nemail: n.valiullina@innopolis.university\ntg: @not_toxic14'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<Joke>(
            future: joke,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                    icon: Icon(
                      snapshot.data!.isFavourite ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: ()
                    {
                      snapshot.data!.isFavourite ? ref.read(fetchFavouritesProvider.notifier).removeFavourite(snapshot.data!.id)
                          : ref.read(fetchFavouritesProvider.notifier).addFavourite(snapshot.data!);
                    }
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.favorite_outline,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     icon: const Icon(
          //       Icons.favorite,
          //       color: Colors.white,
          //     );
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: ((context) => const FavouritesPage()),
          //       ),
          //     );
          //   }
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
