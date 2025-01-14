import 'dart:io';

import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/components/players/player.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final playerData = widget.playerData;
    initSavedPlayer(playerData);
    //_loadPlayerData();
  }
  
  /*
  Future<void> _loadPlayerData() async {
    try {
      final pd = widget.playerData;
      LogUtil.debug('_loadPlayerData player-> player name: ${pd.playerName}, level: ${pd.level}, topScore: ${pd.topScore}, gender: ${pd.gender} ,dob: ${pd.dateOfBirth}, img: ${pd.profileImgPath}');
      nameController.text = pd.playerName;
      selectedDate = pd.dateOfBirth;
      gender = pd.gender;
      
      // Fetch the profile image path asynchronously
      final String? profileImgPath = await _playerAuthManager.getProfileImgPath(pd.playerName);

      if (profileImgPath != null && profileImgPath.isNotEmpty) {
        setState(() {
          profileImage = File(profileImgPath);
        });
      } else {
        // If no profile image path is found, use a default image
        final defaultImage = await _getDefaultProfileImage();
        setState(() {
          profileImage = defaultImage;
        });
      }

    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }*/

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

  /*

  Future<File> _getDefaultProfileImage() async {
      // Load the asset image
    final byteData = await rootBundle.load('assets/images/player_1.png');

    // Save the asset image as a temporary file
    final directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/default_profile_image.png';
    final File file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file;   

  }*/

  Future<void> _pickImage() async {
    try {    

      LogUtil.debug('Try to pick profile image');
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final String fileName = 'profile_${nameController.text}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final String filePath = '${directory.path}/$fileName';

        // Save the image locally
        File savedFile = await File(pickedFile.path).copy(filePath);
        setState(() {
          profileImage = savedFile;
          LogUtil.debug('Profile img->$profileImage');
        });
        
        /*
        setState(() {
          profileImage = savedFile;// Update the profile image
          LogUtil.debug('Pick image: -> $profileImage');
        });*/
      }
    
    } catch(e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void _updateInfo() async {
    try {
      LogUtil.debug('Try to update player information');
      final name = nameController.text.trim();
      if (name.isEmpty || selectedDate == null || gender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields.')),
        );
        return;
      }

      final updatedPlayer = PlayerData(playerName: name, level: 1, topScore: 0, dateOfBirth: selectedDate!, gender: gender!, profileImgPath: profileImage!.path,);

      LogUtil.debug('Updated player-> player name: ${updatedPlayer.playerName}, level: ${updatedPlayer.level}, topScore: ${updatedPlayer.topScore}, dob: ${updatedPlayer.dateOfBirth}, img: ${updatedPlayer.profileImgPath}');

      await _playerAuthManager.updatePlayerData(updatedPlayer);      

      if (mounted) {
        LogUtil.debug('Succesfully updated the player data');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Player profile updated!')),
        );
        Navigator.of(context).pop(updatedPlayer); // Close the dialog
      }      
    } catch (e) {
      LogUtil.debug('Exception -> $e');
    }      
  }

/*
  FutureBuilder _futureBuilderProfile() {
    LogUtil.debug('Inside future build method');
    try {
      return FutureBuilder(
        //future: _playerAuthManager.getProfileImgPath(nameController.text), 
        future: _playerAuthManager.loadPlayerData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading progress'),);
          } else if (snapshot.hasData && snapshot.data is PlayerData) {
            final pd = snapshot.hasData as PlayerData;
            LogUtil.debug('Future builder profile loaded -> name: ${pd.playerName}, dob: ${pd.dateOfBirth}, level: ${pd.level}, score: ${pd.topScore}, gender: ${pd.gender}, img: ${pd.profileImgPath}');
            //return _buildRow(context, '/data/user/0/ch.chhoeun.endless.runner/app_flutter/profile_yyyyyy1.jpg');
            initSavedPlayer(pd);
            return _buildDialog(pd);
          }  else {
            LogUtil.debug('Snapshot has data-> ${snapshot.data}');
            return const Center(child: Text('Unexpected data returned'),);
          }
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
  }*/

  void initSavedPlayer(PlayerData pd) {
    LogUtil.debug('Try to load saved player information');
    nameController.text = pd.playerName;
    profileImage = File(pd.profileImgPath!);
    gender = pd.gender;
    selectedDate = pd.dateOfBirth;
  }

  Dialog _buildDialog() {
    LogUtil.debug('Start building dialog for updating player data');
    LogUtil.debug('After set state profile image ->$profileImage');    
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
                  DateFormat('yyyy-MM-dd').format(selectedDate!),
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
                
                profileImage != null
                ?      
                    CircleAvatar( 
                        backgroundImage: FileImage(profileImage!),
                        radius: 40,
                        key: ValueKey(DateTime.now().millisecondsSinceEpoch), // Force refresh with a unique key
                      )
                :
                  const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40,),),
                /*    : const CircleAvatar(radius: 40, 
                      child: Icon(Icons.person, size: 40),),*/
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

    
    
    return _buildDialog();

    //return _futureBuilderProfile();
  }

}