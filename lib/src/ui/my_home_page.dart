import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/application/fetch_joke.dart';
import 'package:cpmdf/src/domain/joke_model.dart';
import 'package:cpmdf/src/ui/favourites_page.dart';


class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joke = ref.watch(callApiProvider);

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
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: ((context) => FavouritesPage()),
                ),
              );
            }
          ),
        ],
      ),
      body: Center(
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding:
                EdgeInsets.only(left: 60, bottom: 10, right: 60, top: 0),
                child: Image(image: AssetImage('assets/icon.png')),
              ),
              FutureBuilder<Joke>(
                future: joke,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(snapshot.data!.value,
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.center),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Next'),
        icon: const Icon(
          Icons.arrow_forward_rounded,
          size: 24.0,
        ),
        onPressed: () {
          ref.read(callApiProvider.notifier).call();
        },
      ),
    );
  }
}
