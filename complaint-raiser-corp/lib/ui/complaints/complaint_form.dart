import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_raiser_corp/providers/auth_provider.dart';
import 'package:complaint_raiser_corp/ui/widgets/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/category_model.dart';
import '../../models/complaint_model.dart';
import '../../services/firestore_database.dart';
import '../../services/image_services.dart';
import '../../services/storage_database.dart';

class ComplaintFormArguments {
  final CategoryType categoryType;
  final ComplaintModel? complaint;

  ComplaintFormArguments({required this.categoryType, this.complaint});
}

class ComplaintFormScreen extends StatefulWidget {
  final CategoryType categoryType;
  final ComplaintModel? complaint;

  const ComplaintFormScreen(
      {Key? key, required this.categoryType, this.complaint})
      : super(key: key);

  @override
  State<ComplaintFormScreen> createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? imageFile;

  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text(getCategoryName(widget.categoryType)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(labelText: 'District'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _wardController,
                  decoration: const InputDecoration(labelText: 'Ward Number'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                // gps
                const SizedBox(height: 24),
                InkWell(
                  onTap: () async {
                    imageFile = await ImageServices.pickImage();
                    setState(() {});
                  },
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: _buildImage()),
                ),
                const SizedBox(height: 24),

                const SizedBox(height: 24),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                primaryButton(
                    title: 'Submit',
                    onPressed: () async {
                      if ((imageFile != null || widget.complaint != null) &&
                          _formKey.currentState!.validate()) {
                        StorageDatabase storageDatabase =
                            Provider.of<StorageDatabase>(context,
                                listen: false);

                        String? imageUrl;
                        if (imageFile != null) {
                          String imageId = const Uuid().v4();
                          imageUrl = await storageDatabase.uploadCategoryImage(
                              imageFile!, '$imageId.jpg');
                          if (widget.complaint != null) {
                            await storageDatabase
                                .deleteImageFromUrl(widget.complaint!.imageUrl);
                          }
                        } else {
                          imageUrl = widget.complaint!.imageUrl;
                        }
                        if (imageUrl == null) return;

                        FirestoreDatabase firestoreDatabase =
                            Provider.of<FirestoreDatabase>(context,
                                listen: false);

                        String categoryId = const Uuid().v4();

                        AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);

                        ComplaintModel complaint = ComplaintModel(
                            id: widget.complaint == null
                                ? categoryId
                                : widget.complaint!.id,
                            imageUrl: imageUrl,
                            type: widget.categoryType,
                            district: _districtController.text.trim(),
                            ward: _wardController.text.trim(),
                            address: _addressController.text.trim(),
                            status: widget.complaint == null ? ComplaintStatus.requested : widget.complaint!.status,
                            date: Timestamp.now(),
                            attempt: widget.complaint == null ? 1 : widget.complaint!.attempt, desc: _descController.text.trim(), uid: authProvider.currentUser!.uid, rejectedReason: '', proofImageUrl: '');

                        firestoreDatabase.setComplaint(complaint);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageFile == null) {
      return const Center(
        child: Text('Upload product photo',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      );
    } else {
      return Image.file(imageFile!);
    }
  }
}
