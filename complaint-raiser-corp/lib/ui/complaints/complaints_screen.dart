import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_raiser_corp/models/category_model.dart';
import 'package:complaint_raiser_corp/models/complaint_model.dart';
import 'package:complaint_raiser_corp/providers/auth_provider.dart';
import 'package:complaint_raiser_corp/services/firestore_database.dart';
import 'package:complaint_raiser_corp/ui/widgets/typo/dataText.dart';
import 'package:complaint_raiser_corp/ui/widgets/widgets.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/firestore_path.dart';
import 'complaint_screen.dart';

class ComplaintsArgument {
  final bool pendingComplaints;

  ComplaintsArgument(this.pendingComplaints);
}

class ComplaintsScreen extends StatefulWidget {
  final bool pendingComplaints;

  const ComplaintsScreen({Key? key, required this.pendingComplaints})
      : super(key: key);

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  late Future<void> initComplaintsData;
  late List<ComplaintModel> complaints;
  late FirestoreDatabase firestoreDatabase;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late Query collectionRef;
  // late CollectionReference collection;

  @override
  void initState() {
    super.initState();
    print('sssssssss+++++++++++++++++++++++++++++++++++++++');
    firestoreDatabase = Provider.of<FirestoreDatabase>(context, listen: false);
    collectionRef = widget.pendingComplaints
        ? FirebaseFirestore.instance
            .collection(FirestorePath.complaints())
            .where('status', whereIn: ['Requested', 'Accepted'])
        : FirebaseFirestore.instance
            .collection(FirestorePath.complaints())
            .where('status', whereIn: ['Completed']);
    initComplaintsData = getComplaints();
  }

  Future<void> getComplaints() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<QueryDocumentSnapshot> snapshots = querySnapshot.docs;
    List<ComplaintModel> complaintsList = [];
    snapshots.forEach((QueryDocumentSnapshot snapshot) {
      complaintsList.add(ComplaintModel.fromDoc(snapshot));
    });
    complaints = complaintsList;
  }

  Future<void> refreshComplaints() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<QueryDocumentSnapshot> snapshots = querySnapshot.docs;
    List<ComplaintModel> complaintsList = [];
    snapshots.forEach((QueryDocumentSnapshot snapshot) {
      complaintsList.add(ComplaintModel.fromDoc(snapshot));
    });
    setState(() {
      complaints = complaintsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.pendingComplaints ? 'Pending Complaints' : 'Completed'),
      ),
      body: FutureBuilder<void>(
        future: initComplaintsData,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return Center(
                  child: Text('Loading...'),
                );
              }
            case ConnectionState.done:
              {
                return RefreshIndicator(
                  onRefresh: refreshComplaints,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: complaints.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 24),
                            itemBuilder: (context, index) {
                              print(
                                  'heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
                              ComplaintModel complaint = complaints[index];

                              return ComplaintCard(complaint: complaint);
                            }),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
