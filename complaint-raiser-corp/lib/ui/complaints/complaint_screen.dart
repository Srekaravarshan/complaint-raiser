import 'dart:io';

import 'package:complaint_raiser_corp/constants/app_themes.dart';
import 'package:complaint_raiser_corp/models/category_model.dart';
import 'package:complaint_raiser_corp/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/complaint_model.dart';
import '../../services/image_services.dart';
import '../../services/storage_database.dart';
import '../widgets/widgets.dart';

class ComplaintArguments {
  final ComplaintModel complaint;

  ComplaintArguments(this.complaint);
}

class ComplaintScreen extends StatefulWidget {
  final ComplaintModel complaint;

  const ComplaintScreen({Key? key, required this.complaint}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  late String date;

  @override
  void initState() {
    super.initState();
    date = DateFormat('dd/MM/yyyy').format(widget.complaint.date.toDate());
  }

  @override
  Widget build(BuildContext context) {
    FirestoreDatabase firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Complaint'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: AppThemes.lightPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: heading(
                          getComplaintStatusString(widget.complaint.status),
                          color: AppThemes.primaryColor)),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(widget.complaint.imageUrl)),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading(getCategoryName(widget.complaint.type),
                        color: AppThemes.primaryColor),
                    Flexible(
                      flex: 1,
                      child: heading(date, color: AppThemes.primaryColor),
                    )
                  ],
                ),
                const Divider(height: 50, color: AppThemes.primaryColor),
                heading('Description:'),
                const SizedBox(height: 10),
                subText(widget.complaint.desc),
                const Divider(height: 50, color: AppThemes.primaryColor),
                heading('Location Details'),
                const SizedBox(height: 10),
                dataText('Ward no:', widget.complaint.ward),
                const SizedBox(height: 6),
                dataText('District:', widget.complaint.district),
                const SizedBox(height: 6),
                subText(widget.complaint.address),
                const Divider(height: 50, color: AppThemes.primaryColor),
                subText('Attempt No: ${widget.complaint.attempt}'),
                if (widget.complaint.rejectedReason.trim().isNotEmpty)
                  const SizedBox(height: 10),
                if (widget.complaint.rejectedReason.trim().isNotEmpty)
                  subText(widget.complaint.rejectedReason),
                const Divider(height: 50, color: AppThemes.primaryColor),
                if (widget.complaint.status == ComplaintStatus.accepted)
                  primaryButton(
                      title: 'Complete',
                      onPressed: () async {
                        _displayTextInputDialog(
                            context, widget.complaint, firestoreDatabase,
                            complete: true);
                      }),
                if (widget.complaint.status == ComplaintStatus.requested)
                  primaryButton(
                    title: 'Accept',
                    onPressed: () async {
                      widget.complaint.status = ComplaintStatus.accepted;
                      await firestoreDatabase.setComplaint(widget.complaint);
                      setState(() {});
                    },
                  ),
                if (widget.complaint.status == ComplaintStatus.requested)
                  const SizedBox(height: 18),
                if (widget.complaint.status == ComplaintStatus.requested)
                  primaryButton(
                      title: 'Reject',
                      onPressed: () => _displayTextInputDialog(
                          context, widget.complaint, firestoreDatabase),
                      color: AppThemes.errorColor),
                if (widget.complaint.status == ComplaintStatus.completed)
                  heading('Proof of Completion'),
                if (widget.complaint.status == ComplaintStatus.completed)
                  const SizedBox(height: 18),
                if (widget.complaint.status == ComplaintStatus.completed)
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(widget.complaint.proofImageUrl),
                  )
              ],
            ),
          ),
        ));
  }

  String? codeDialog;
  String? valueText;

  Future<void> _displayTextInputDialog(BuildContext context,
      ComplaintModel complaint, FirestoreDatabase firestoreDatabase,
      {bool complete = false}) async {
    return showDialog(
        context: context,
        builder: (context) {
          File? imageFile;
          return StatefulBuilder(builder: (context, setState) {
            TextEditingController textFieldController = TextEditingController();
            Widget buildImage() {
              if (imageFile == null) {
                return const Center(
                  child: Text('Upload Proof photo',
                      style: TextStyle(fontSize: 16, color: AppThemes.dark)),
                );
              } else {
                return Image.file(imageFile!);
              }
            }

            return AlertDialog(
              title: Text(complete ? 'Attach Proof' : 'Reason for Rejecting'),
              content: complete
                  ? InkWell(
                      onTap: () async {
                        imageFile = await ImageServices.pickImage();
                        print(imageFile == null);
                        setState(() {});
                      },
                      child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppThemes.lightPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: buildImage()),
                    )
                  : TextField(
                      controller: textFieldController,
                      decoration: const InputDecoration(hintText: "Reason"),
                    ),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text(complete ? 'Submit' : 'Reject'),
                  onPressed: () async {
                    if (complete) {
                      if (imageFile != null) {
                        StorageDatabase storageDatabase =
                            Provider.of<StorageDatabase>(context,
                                listen: false);

                        String? imageUrl;
                        String imageId = const Uuid().v4();
                        imageUrl = await storageDatabase.uploadProofImage(
                            imageFile!, '$imageId.jpg');

                        if (imageUrl == null) return;

                        complaint.status = ComplaintStatus.completed;
                        complaint.proofImageUrl = imageUrl;
                        await firestoreDatabase.setComplaint(complaint);
                      }
                    } else {
                      if (textFieldController.text.trim().isNotEmpty) {
                        complaint.status = ComplaintStatus.rejected;
                        complaint.attempt = complaint.attempt + 1;
                        complaint.rejectedReason =
                            textFieldController.text.trim();
                        await firestoreDatabase.setComplaint(complaint);
                      }
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        }).then((value) => setState(() {}));
  }
}
