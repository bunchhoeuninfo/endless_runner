import 'dart:io';

import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PlayerSignedupEdit extends StatefulWidget {


  final PlayerData playerData;
  const PlayerSignedupEdit({super.key, required this.playerData});
  
  @override
  State<PlayerSignedupEdit> createState() => _PlayerSignedupEditState();

}

class _PlayerSignedupEditState extends State<PlayerSignedupEdit> {
  final TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  String? gender;
  File? profileImage; // Variable to hold the selected image
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();
  

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }
  
  void _loadPlayerData() {
    final pd = widget.playerData;
    LogUtil.debug('_loadPlayerData player-> player name: ${pd.playerName}, level: ${pd.level}, topScore: ${pd.topScore}, gender: ${pd.gender} ,dob: ${pd.dateOfBirth}, img: ${pd.profileImgPath}');
    nameController.text = pd.playerName;
    selectedDate = pd.dateOfBirth;
    gender = pd.gender;    
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
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

  void _updateInfo() async {
    final name = nameController.text.trim();
    if (name.isEmpty || selectedDate == null || gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final updatedPlayer = PlayerData(
      playerName: name,
      level: 1,
      topScore: 0,
      dateOfBirth: selectedDate!,
      gender: gender ?? 'Other',
      profileImgPath: profileImage?.path ?? 'assets/images/player_1.png',
    );

    LogUtil.debug('Updated player-> player name: ${updatedPlayer.playerName}, level: ${updatedPlayer.level}, topScore: ${updatedPlayer.topScore}, dob: ${updatedPlayer.dateOfBirth}, img: ${updatedPlayer.profileImgPath}');

    await _playerAuthManager.updatePlayerData(updatedPlayer);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Player profile updated!')),
      );
    }
    if (mounted) {
      Navigator.of(context).pop(); // Close the dialog
    }
    
  }

  FutureBuilder _futureBuilderProfile() {
    LogUtil.debug('Inside future build method');
    try {
      return FutureBuilder(
        future: _playerAuthManager.getProfileImgPath(nameController.text), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading progress'),);
          } else {
            LogUtil.debug('Player Data-> profileImg: ${snapshot.hasData}');             
            return _buildDialog('/data/user/0/ch.chhoeun.endless.runner/app_flutter/profile_yyyyyy1.jpg');
          } /*else if (snapshot.hasData) {
            //final profileImg = snapshot.data as String;
            LogUtil.debug('Player Data-> profileImg: ${snapshot.hasData}');
            //return _buildRow(context, '/data/user/0/ch.chhoeun.endless.runner/app_flutter/profile_yyyyyy1.jpg');     
            return _buildDialog('/data/user/0/ch.chhoeun.endless.runner/app_flutter/profile_yyyyyy1.jpg');
          }  else {
            LogUtil.debug('Snapshot has data-> ${snapshot.data}');
            return const Center(child: Text('Unexpected data returned'),);
          }*/
        }
      );
    } catch (e) {
      LogUtil.error('Exception -> $e');
      return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return const Center(child: Text('Exception Block'),);
      });
    }
  }

  Dialog _buildDialog(String profileImg) {
    LogUtil.debug('Start building dialog for updating player data');
    return Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Player Name'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Date of Birth',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
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
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: ['Male', 'Female', 'Other']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (value) => setState(() => gender = value),
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                profileImg.isNotEmpty
                    ? CircleAvatar( 
                        backgroundImage: FileImage(File(profileImg)),
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
            _buildElevatedBtn(),
          ],
        ),
      ),
    );
  }

  Center _buildElevatedBtn() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          ElevatedButton(
            onPressed: _updateInfo,
            child: const Text('Update Info'),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Start trying to initiate future builder');
    return _futureBuilderProfile();
  }

}