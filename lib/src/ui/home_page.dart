import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/application/fetch_joke.dart';
import 'package:cpmdf/src/domain/joke_model.dart';
import 'package:cpmdf/src/ui/home_app_bar.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joke = ref.watch(callApiProvider);

    return Scaffold(
      appBar: HomeAppBar(joke, 'Tinder with Chuck Norris'),
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
