import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_raiser/constants/app_themes.dart';
import 'package:complaint_raiser/providers/auth_provider.dart';
import 'package:complaint_raiser/ui/widgets/components/primary_button.dart';
import 'package:complaint_raiser/ui/widgets/typo/heading.dart';
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

  String? imageUrl;

  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.complaint != null) {
      _districtController.text = widget.complaint!.district;
      _wardController.text = widget.complaint!.ward;
      _addressController.text = widget.complaint!.address;
      _descController.text = widget.complaint!.desc;
      imageUrl = widget.complaint!.imageUrl;
    }
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading(getCategoryName(widget.categoryType)),
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
                          color: AppThemes.lightPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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

                        AuthProvider authProvider =
                            Provider.of<AuthProvider>(context, listen: false);

                        ComplaintModel complaint = ComplaintModel(
                            id: widget.complaint == null
                                ? categoryId
                                : widget.complaint!.id,
                            imageUrl: imageUrl,
                            type: widget.categoryType,
                            district: _districtController.text.trim(),
                            ward: _wardController.text.trim(),
                            address: _addressController.text.trim(),
                            status: ComplaintStatus.requested,
                            date: Timestamp.now(),
                            attempt: widget.complaint == null
                                ? 1
                                : widget.complaint!.attempt + 1,
                            desc: _descController.text.trim(),
                            uid: authProvider.currentUser!.uid,
                            rejectedReason:
                                widget.complaint?.rejectedReason ?? '',
                            proofImageUrl: '');

                        firestoreDatabase.setComplaint(complaint);
                        if (widget.complaint != null) {
                          setState(() {
                            widget.complaint!.copy(complaint);
                          });
                        }
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
    if (imageFile == null && widget.complaint == null) {
      return const Center(
        child: Text('Upload complaint photo',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      );
    } else if (imageFile == null && widget.complaint != null) {
      return Image.network(widget.complaint?.imageUrl ??
          'https://joy1.videvo.net/videvo_files/video/free/video0469/thumbnails/_import_61764c17553da7.81511599_small.jpg');
    } else {
      return Image.file(imageFile!);
    }
  }
  // Widget _buildImage() {
  //   if (imageFile == null) {
  //     return const Center(
  //       child: Text('Upload complaint photo',
  //           style: TextStyle(fontSize: 16, color: AppThemes.dark)),
  //     );
  //   } else {
  //     return Image.file(imageFile!);
  //   }
  // }
}
