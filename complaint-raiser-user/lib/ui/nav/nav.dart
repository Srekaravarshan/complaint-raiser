import 'package:complaint_raiser/constants/app_themes.dart';
import 'package:complaint_raiser/providers/auth_provider.dart';
import 'package:complaint_raiser/ui/complaints/complaints_screen.dart';
import 'package:complaint_raiser/ui/complaints/raise_complaint_screen.dart';

import 'package:complaint_raiser/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> pages;
  late RaiseComplaintScreen raiseComplaintScreen;
  late ComplaintsScreen complaintsScreen;
  late ComplaintsScreen allComplaintsScreen;


  @override
  void initState() {
    super.initState();
    raiseComplaintScreen = const RaiseComplaintScreen();
    complaintsScreen = const ComplaintsScreen(myComplaints: true);
    allComplaintsScreen = const ComplaintsScreen(myComplaints: true);
    pages = [
      raiseComplaintScreen,
      complaintsScreen,
      allComplaintsScreen,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Your Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: 'All Complaints',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: AppThemes.primaryColor,
        onTap: _onItemTapped,
        // unselectedItemColor: ,
      ),
      body: IndexedStack(index: _selectedIndex,children: pages),
    );
  }

}
