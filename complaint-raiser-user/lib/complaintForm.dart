import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _aadharController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _complaintController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  String? _currentLocation;

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation =
      '${position.latitude}, ${position.longitude}';
      _locationController.text = _currentLocation!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _aadharController,
                  decoration: const InputDecoration(labelText: 'Aadhar Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Aadhar number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _complaintController,
                  decoration: const InputDecoration(labelText: 'Complaint'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your complaint';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                  onTap: () {
                    _getCurrentLocation();
                  },
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something with the form data
                      String name = _nameController.text;
                      String aadhar = _aadharController.text;
                      String complaint = _complaintController.text;
                      String location = _locationController.text;

                      print('Name: $name');
                      print('Aadhar Number: $aadhar');
                      print('Complaint: $complaint');
                      print('Location: $location');
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
