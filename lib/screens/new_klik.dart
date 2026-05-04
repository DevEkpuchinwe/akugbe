import 'dart:io';

import 'package:akugbe/config/colors.dart';
import 'package:akugbe/config/text_styles.dart';
import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/screens/new_image_edit.dart';
import 'package:akugbe/screens/new_post_video_editor.dart';
import 'package:akugbe/utils/app_utils.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../custom_widgets/filled_stateless_button.dart';

class NewKlik extends ConsumerStatefulWidget {
  const NewKlik({super.key});

  @override
  ConsumerState createState() => _NewKlikState();
}

class _NewKlikState extends ConsumerState<NewKlik> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _maxPeopleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _minAmountController = TextEditingController();

  // Fields
  String _privacy = "Public";
  String _gender = "Any";
  DateTime? _startDate;
  DateTime? _endDate;
  File? _image;

  // Pick image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Select date
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  // Submit form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data
      print("Klik Created: ${_nameController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Klik")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Klik Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Klik Name"),
                  validator: (value) => value!.isEmpty ? "Enter Klik name" : null,
                ),

                // Location
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: "Location"),
                  validator: (value) => value!.isEmpty ? "Enter location" : null,
                ),

                // Max People (Optional)
                TextFormField(
                  controller: _maxPeopleController,
                  decoration: InputDecoration(labelText: "Max Number of People (Optional)"),
                  keyboardType: TextInputType.number,
                ),

                // Privacy Dropdown
                DropdownButtonFormField<String>(
                  value: _privacy,
                  items: ["Public", "Private"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _privacy = val!),
                  decoration: InputDecoration(labelText: "Privacy"),
                ),

                // Description (Optional)
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description (Optional)"),
                  maxLines: 3,
                ),

                // Total Amount to be Contributed
                TextFormField(
                  controller: _totalAmountController,
                  decoration: InputDecoration(labelText: "Total Amount to be Contributed"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter total amount" : null,
                ),

                // Minimum Amount to Enter Klik
                TextFormField(
                  controller: _minAmountController,
                  decoration: InputDecoration(labelText: "Minimum Amount to Enter"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter minimum amount" : null,
                ),

                // Gender Selection
                DropdownButtonFormField<String>(
                  value: _gender,
                  items: ["Male", "Female", "Any"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _gender = val!),
                  decoration: InputDecoration(labelText: "Gender"),
                ),

                // Start Date Picker
                ListTile(
                  title: Text("Start Date: ${_startDate != null ? _startDate!.toLocal().toString().split(' ')[0] : 'Select'}"),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context, true),
                ),

                // End Date Picker
                ListTile(
                  title: Text("End Date: ${_endDate != null ? _endDate!.toLocal().toString().split(' ')[0] : 'Select'}"),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context, false),
                ),

                // Image Picker
                Row(
                  children: [
                    _image != null
                        ? CircleAvatar(backgroundImage: FileImage(_image!), radius: 30)
                        : CircleAvatar(radius: 30, child: Icon(Icons.camera_alt)),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: _pickImage,
                      child: Text("Pick Klik Profile Picture"),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text("Create Klik"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

