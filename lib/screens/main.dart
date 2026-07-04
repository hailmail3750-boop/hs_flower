import 'package:flutter/material.dart';
import 'my_flowers.dart';
import 'search.dart';
import 'settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const blue = Color(0xFF4674C3);
  static const gray = Color(0xFFAFAFAF);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomTabIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      const HomeScreen(),
      const MyFlowersScreen(),
      const SearchScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),

      body: screens[bottomTabIndex],

      bottomNavigationBar: Center(
        heightFactor: 1,
        child: SizedBox(
          width: 600,
          height: 54,
          child: Container(
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: BottomTabItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isSelected: bottomTabIndex == 0,
                    onTap: () {
                      setState(() {
                        bottomTabIndex = 0;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: BottomTabItem(
                    icon: Icons.local_florist,
                    label: '나만의 꽃',
                    isSelected: bottomTabIndex == 1,
                    onTap: () {
                      setState(() {
                        bottomTabIndex = 1;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: BottomTabItem(
                    icon: Icons.search,
                    label: '검색',
                    isSelected: bottomTabIndex == 2,
                    onTap: () {
                      setState(() {
                        bottomTabIndex = 2;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: BottomTabItem(
                    icon: Icons.settings,
                    label: '설정',
                    isSelected: bottomTabIndex == 3,
                    onTap: () {
                      setState(() {
                        bottomTabIndex = 3;
                      });
                    },
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const blue = Color(0xFF4674C3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Center(
          child: Container(
            width: 600,
            color: Colors.white,
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Bloomy',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: Container(
          width: 600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BottomTabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const BottomTabItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? MainScreen.blue
                  : MainScreen.gray,
            ),

            const SizedBox(height: 2),

            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? MainScreen.blue
                    : MainScreen.gray,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}