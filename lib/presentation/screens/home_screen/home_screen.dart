import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: ListView.builder(itemBuilder: (context, index) {
        return const ListTile(
          leading: CircleAvatar(),
          title: Text('title'),
          subtitle: Text('subtitle'),
        );
      },)),
    );
  }
}