import 'package:flutter/material.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarScaffold extends StatefulWidget {
  const BottomNavigationBarScaffold({super.key, required this.child});

	final Widget child;

  @override
  State<BottomNavigationBarScaffold> createState() => _BottomNavigationBarScaffoldState();
}

class _BottomNavigationBarScaffoldState extends State<BottomNavigationBarScaffold> {

	int currentIndex = 0;

	void changeTab(int index) {
    switch(index){
      case 0:  
        context.go('/');
        break;
      case 1:  
        context.go('/dashboard');
        break;
      default:
        context.go('/');
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        currentIndex: currentIndex,

				// style the navigation
				backgroundColor: AppColors.secondaryColor,
				selectedItemColor: AppColors.titleColor,
				unselectedItemColor: AppColors.textColor,
				selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
        ],
      ),
		);
  }
}
