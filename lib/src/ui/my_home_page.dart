import 'package:cpmdf/src/application/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      body: pages.elementAt(selectedIndex),
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
          }),
    );
  }
}
