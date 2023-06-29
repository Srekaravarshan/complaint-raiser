import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_raiser/models/complaint_model.dart';
import 'package:complaint_raiser/providers/auth_provider.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/firestore_database.dart';
import '../../services/firestore_path.dart';
import '../widgets/components/complaint_card.dart';
import 'complaint_screen.dart';

class ComplaintsArgument {
  final bool myComplaints;

  ComplaintsArgument(this.myComplaints);
}

class ComplaintsScreen extends StatefulWidget {
  final bool myComplaints;

  const ComplaintsScreen({Key? key, required this.myComplaints})
      : super(key: key);

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  late Future<void> initComplaintsData;
  late List<ComplaintModel> complaints;
  late FirestoreDatabase firestoreDatabase;
  late AuthProvider authProvider;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late Query collectionRef;
  // late CollectionReference collection;

  @override
  void initState() {
    super.initState();
    print('sssssssss+++++++++++++++++++++++++++++++++++++++');
    firestoreDatabase = Provider.of<FirestoreDatabase>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    collectionRef = widget.myComplaints
        ? FirebaseFirestore.instance
            .collection(FirestorePath.complaints())
            .where('uid', isEqualTo: authProvider.currentUser!.uid)
        : FirebaseFirestore.instance
            .collection(FirestorePath.complaints())
            .orderBy('status');
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
        title: Text(widget.myComplaints ? 'Your Complaints' : 'All Complaints'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authProvider.signOut(),
          )
        ],
      ),
      body: FutureBuilder<void>(
        future: initComplaintsData,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return const Center(
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: complaints.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                            padding: const EdgeInsets.symmetric(
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
