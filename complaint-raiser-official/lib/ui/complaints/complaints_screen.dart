import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_raiser_official/models/category_model.dart';
import 'package:complaint_raiser_official/models/complaint_model.dart';
import 'package:complaint_raiser_official/providers/auth_provider.dart';
import 'package:complaint_raiser_official/ui/widgets/typo/dataText.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/firestore_database.dart';
import '../../services/firestore_path.dart';
import '../widgets/components/complaint_card.dart';
import 'complaint_screen.dart';

class ComplaintsArgument {
  final ComplaintStatus status;

  ComplaintsArgument(this.status);
}

class ComplaintsScreen extends StatefulWidget {
  final ComplaintStatus status;

  const ComplaintsScreen({Key? key, required this.status}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    print('sssssssss+++++++++++++++++++++++++++++++++++++++');
    firestoreDatabase = Provider.of<FirestoreDatabase>(context, listen: false);
    collectionRef = getQuery();
    // collection = collectionRef.withConverter<ComplaintModel>(
    //   fromFirestore: (snapshot, _) => ComplaintModel.fromMap(snapshot.data()!, snapshot.id),
    //   toFirestore: (complaint, _) => complaint.toMap(),
    // );
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

  Query getQuery() {
    if (widget.status == ComplaintStatus.completed) {
      return FirebaseFirestore.instance
          .collection(FirestorePath.complaints())
          .where('status', isEqualTo: 'Completed');
    } else if (widget.status == ComplaintStatus.rejected) {
      return FirebaseFirestore.instance
          .collection(FirestorePath.complaints())
          .where('status', isEqualTo: 'Rejected');
    } else {
      return FirebaseFirestore.instance
          .collection(FirestorePath.complaints())
          .where('status', whereIn: ['Requested', 'Accepted']);
    }
  }

  String getTitle() {
    if (widget.status == ComplaintStatus.completed) {
      return 'Completed Complaints';
    } else if (widget.status == ComplaintStatus.rejected) {
      return 'Rejected Complaints';
    } else {
      return 'Pending Complaints';
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
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
