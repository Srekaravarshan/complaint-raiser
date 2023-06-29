// complaint_categories
//  - electricity
//  - drainage & water
//  - road
//  - street lights
//  - other complaints

import 'package:complaint_raiser/constants/app_themes.dart';
import 'package:complaint_raiser/models/category_model.dart';
import 'package:complaint_raiser/routes.dart';
import 'package:complaint_raiser/ui/complaints/complaint_form.dart';
import 'package:complaint_raiser/ui/widgets/typo/heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RaiseComplaintScreen extends StatefulWidget {
  const RaiseComplaintScreen({Key? key}) : super(key: key);

  @override
  State<RaiseComplaintScreen> createState() => _RaiseComplaintScreenState();
}

class _RaiseComplaintScreenState extends State<RaiseComplaintScreen> {
  List categories = [
    {
      'name': 'Electricity',
      'imagePath': 'electric',
      'type': CategoryType.electricity,
    },
    {
      'name': 'Drainage & Water',
      'imagePath': 'water',
      'type': CategoryType.drainage,
    },
    {
      'name': 'Road',
      'imagePath': 'road',
      'type': CategoryType.road,
    },
    {
      'name': 'Street Lights',
      'imagePath': 'light',
      'type': CategoryType.streetLights,
    },
    {
      'name': 'Other Complaints',
      'imagePath': 'other',
      'type': CategoryType.other,
    },
  ];

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complain Raiser'),
        actions: [
          // IconButton(
          //     onPressed: () => authProvider.signOut(),
          //     icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(25),
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.complaintForm,
              arguments: ComplaintFormArguments(
                  categoryType: categories[index]['type'])),
          child: Container(
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/${categories[index]['imagePath']}.png',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Align(
                alignment: Alignment.bottomLeft,
                child:
                    heading(categories[index]['name'], color: AppThemes.light)),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
