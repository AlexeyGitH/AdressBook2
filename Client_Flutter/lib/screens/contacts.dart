
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address book', style: Theme.of(context).textTheme.headline1),
        //backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/filters'),
          ),
        ],
      ),
      body: Container(
        //color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text("ff 11 33"),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

