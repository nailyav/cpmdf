import 'package:cpmdf/src/application/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cpmdf/src/application/fetch_joke.dart';
import 'package:cpmdf/src/ui/favourites_page.dart';
import 'package:cpmdf/src/ui/home_page.dart';


class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(indexProvider) as int;

    List<Widget> pages = <Widget>[
      const HomePage(),
      const FavouritesPage(),
    ];

    return Scaffold(
      body:pages.elementAt(selectedIndex),
    // body: Center(
    //   child: SafeArea(
    //     bottom: false,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Padding(
    //           padding:
    //           EdgeInsets.only(left: 60, bottom: 10, right: 60, top: 0),
    //           child: Image(image: AssetImage('assets/icon.png')),
    //         ),
    //         FutureBuilder<Joke>(
    //           future: joke,
    //           builder: (context, snapshot) {
    //             if (snapshot.hasData) {
    //               return Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 20),
    //                 child: Text(snapshot.data!.value,
    //                     style: const TextStyle(fontSize: 15),
    //                     textAlign: TextAlign.center),
    //               );
    //             } else if (snapshot.hasError) {
    //               return Text('${snapshot.error}');
    //             }
    //             return const CircularProgressIndicator();
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_sharp),
            label: 'Favourites',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (i) {
          ref.read(indexProvider.notifier).value = i;
          // controller.animateToPage(i,
          //     duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        }),
    );
  }
}
