import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const blue = Color(0xFF4674C3);
  static const gray = Color(0xFFAFAFAF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 600,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 515,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text('알림 설정'),
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: blue,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('다크 모드'),
                        trailing: Switch(
                          value: false,
                          onChanged: (value) {},
                          activeColor: blue,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('언어 설정'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
