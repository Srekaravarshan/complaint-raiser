import 'package:complaint_raiser_corp/ui/complaints/complaints_screen.dart';
import 'package:complaint_raiser_corp/ui/complaints/raise_complaint_screen.dart';

import 'package:flutter/material.dart';

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
  late ComplaintsScreen complaintsScreen;
  late ComplaintsScreen allComplaintsScreen;


  @override
  void initState() {
    super.initState();
    complaintsScreen = const ComplaintsScreen(pendingComplaints: true);
    allComplaintsScreen = const ComplaintsScreen(pendingComplaints: false);
    pages = [
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
            icon: Icon(Icons.access_time_filled),
            label: 'Pending Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline_rounded),
            label: 'Finished Complaints',
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
