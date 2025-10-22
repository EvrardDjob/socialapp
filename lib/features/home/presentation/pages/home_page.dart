import 'package:flutter/material.dart';

import 'package:social_app/features/home/presentation/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // scaffold
    return Scaffold(
      //app bar
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
          
      ), 

      // drawer
      drawer: const MyDrawer(),
    );
  }
}