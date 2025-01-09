import 'dart:io';

import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PlayerSignup extends StatefulWidget {
  const PlayerSignup({super.key, required this.playerAuthManager});

  final PlayerAuthManager playerAuthManager;

  @override
  State<PlayerSignup> createState() => _PlayerSignupState();

}

class _PlayerSignupState extends State<PlayerSignup> {
  final TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  String? gender;
  File? profileImage; // Variable to hold the selected image

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = 'profile_${nameController.text}.jpg';
      final String filePath = '${directory.path}/$fileName';

      // Save the image locally
      final File savedFile = await File(pickedFile.path).copy(filePath);

      setState(() {
        profileImage = savedFile; // Update the profile image
      });
    }
  }

  void _submit() async {
    final name = nameController.text.trim();
    if (name.isEmpty || selectedDate == null || gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const  SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final player = PlayerData(
      playerName: name,
      level: 1,
      topScore: 0,
      dateOfBirth: selectedDate ?? DateTime.now(),
      gender: gender ?? 'Other',
      profileImgPath: profileImage?.path ?? 'assets/images/player_1.png'
    );

    await widget.playerAuthManager.savePlayerData(player);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Player profile saved!')),
    );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      resizeToAvoidBottomInset: true,  // Adjust layout when keyboard appears
      body: _buildBodyView(),
    );
  }

  SingleChildScrollView _buildBodyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Player Name'),
          ),
          const SizedBox(height: 16,),
          const Text(
            'Date of Birth',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedDate == null
                    ? 'Select Date of Birth'
                    : DateFormat('yyyy-MM-dd').format(selectedDate!),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: gender,
            decoration: const InputDecoration(labelText: 'Player Gender'),
            items: ['Male', 'Female', 'Other']
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: (value) => setState(() => gender = value),
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              profileImage != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(profileImage!),
                      radius: 40,
                    )
                  : const CircleAvatar(radius: 40, 
                    child: Icon(Icons.person, size: 40),),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload),
                label: const Text('Select Image'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

}