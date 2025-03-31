import 'package:flutter/material.dart';
import 'package:fys/screens/routine_screen.dart';
import 'package:fys/screens/streaks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreenInd = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        backgroundColor: Colors.pink.shade50,
        elevation: 10,
        currentIndex: _currentScreenInd,
          onTap: (index) {
            setState(() {
              _currentScreenInd = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Routine"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                label: "Streaks"
            )
          ]
      ),

    );
  }

  Widget _getCurrentScreen(){
    if(_currentScreenInd == 0){
      return const RoutineScreen();
    }else{
      return const StreaksScreen();
    }
  }

}
