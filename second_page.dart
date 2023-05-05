import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_first_flutter_project/main.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key, required this.title});

  final String title;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> _numberImages = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {

    final databaseRef = FirebaseDatabase.instance.reference().child('numbers');
    DatabaseEvent databaseEvent = await databaseRef.once();
    DataSnapshot dataSnapshot = databaseEvent.snapshot;

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> numbersData = dataSnapshot.value as Map<dynamic, dynamic>;

      List<Map<String, dynamic>> numberImages = [];

      numbersData.forEach((number, images) {
        images.forEach((key, imageUrl) {
          numberImages.add({'number': number, 'imageUrl': imageUrl});
        });
      });

      setState(() {
        _numberImages = numberImages;
        _numberImages.shuffle(Random());
      });
    }
  }

  void _nextNumber() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _numberImages.length;
    });
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home',)),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(65, 65),
                      shape: const CircleBorder(),
                      side: const BorderSide(width: 2.0, color: Colors.green),
                    ),
                    child: const Icon(
                      Icons.home, color: Colors.green, size: 33,),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 80,
              child: Column(
                children: [
                    ElevatedButton(
                      onPressed: _nextNumber,
                      child: Image.network(
                        _numberImages[_currentIndex]['imageUrl']!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                      const SizedBox(height: 24),
                      Text(
                          _numberImages[_currentIndex]['number']!,
                        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _nextNumber,
                        child: const Text(
                          'Next Number',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      );
    }
}