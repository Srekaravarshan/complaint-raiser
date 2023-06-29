// complaint_categories
//  - electricity
//  - drainage & water
//  - road
//  - street lights
//  - other complaints

import 'package:complaint_raiser_corp/models/category_model.dart';
import 'package:complaint_raiser_corp/routes.dart';
import 'package:complaint_raiser_corp/ui/complaints/complaint_form.dart';
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
    {'name': 'Electricity', 'imagePath': '', 'type': CategoryType.electricity},
    {'name': 'Drainage & Water', 'imagePath': '', 'type': CategoryType.drainage},
    {'name': 'Road', 'imagePath': '', 'type': CategoryType.road},
    {'name': 'Street Lights', 'imagePath': '', 'type': CategoryType.streetLights},
    {'name': 'Other Complaints', 'imagePath': '', 'type': CategoryType.other},
  ];

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Complain Raiser'),
        actions: [
          IconButton(
              onPressed: () => authProvider.signOut(), icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Categories'),
            ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.complaintForm, arguments: ComplaintFormArguments(categoryType: categories[index]['type'])),
                child: Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.grey.shade100,

                  child: Center(child: Text(categories[index]['name'])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
