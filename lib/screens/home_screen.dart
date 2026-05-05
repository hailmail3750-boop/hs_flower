import 'package:flutter/material.dart';
import 'builder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HS Flower'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('꽃다발 만들기 시작'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const BuilderScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}