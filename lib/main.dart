import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ass1',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Tinder with Chuck Norris'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Joke> fetchJoke() async {
    final response =
        await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the joke');
    }
  }

  late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke();
  }

  void _callApi() {
    setState(() {
      futureJoke = fetchJoke();
    });
  }

  void _openPersonalInfo() {
    setState(() {
      futureJoke = fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          )
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
                future: futureJoke,
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
          _callApi();
        },
      ),
    );
  }
}

@JsonSerializable()
class Joke {
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  Joke(this.iconUrl, this.id, this.url, this.value);

  Joke.fromJson(Map<String, dynamic> json)
      : iconUrl = json['icon_url'],
        id = json['id'],
        url = json['url'],
        value = json['value'];

  // Map<String, dynamic> toJson() => {
  //   'icon_url': iconUrl,
  //   'id': id,
  //   'url': url,
  //   'value': value,
  // };
}
