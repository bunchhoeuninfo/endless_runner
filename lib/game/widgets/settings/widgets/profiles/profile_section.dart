import 'dart:io';

import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/signup/player_signedup_edit.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key, required this.playerData});
  final PlayerData playerData;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();

}

class _ProfileSectionState extends State<ProfileSection> {
  
  late PlayerData playerData;  
  
  @override
  void initState() {
    super.initState();
    playerData = widget.playerData;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Loaded player-> player name: ${playerData.playerName}, level: ${playerData.level}, topScore: ${playerData.topScore}, dob: ${playerData.dateOfBirth}, img: ${playerData.profileImgPath}');    
    return _buildRow(context, playerData.profileImgPath!);
  }

  Row _buildRow(BuildContext context, String profileImg) {
    LogUtil.debug('Start building Setting - Profile Section, profileImg -> $profileImg');
    return Row(
      children: [
        
          profileImg.isNotEmpty 
            ? GestureDetector(
                onTap: () => _showPicDialog(context, profileImg),
                child: CircleAvatar( 
                          backgroundImage: FileImage(File(profileImg)),
                          radius: 40,
                        ))
                : const CircleAvatar(radius: 40, 
                        child: Icon(Icons.person, size: 40),),
                
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playerData.playerName,              
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [                
                TextButton(
                  onPressed: () {
                    // Open dialog to edit player name/image
                    showPlayerEditDialog(context, playerData);
                  },
                  child: const Text('Edit Profile', selectionColor: Colors.blue,),
                ),
                const SizedBox(width: 10), // Spacing between buttons
                TextButton(
                  onPressed: () {
                    // Sign-out logic
                    LogUtil.debug('Sign-out button tapped');
                    _signOut(context);
                  },
                  child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                ),                
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _signOut(BuildContext context) {
    // Implement your sign-out logic here
    LogUtil.debug('Executing sign-out logic');
    Navigator.pop(context); // Example: Close the current screen
  }

  Future<void> showPlayerEditDialog(BuildContext context, PlayerData playerData) async {
    try {
      final upd = await showDialog<PlayerData>(
        context: context,
        builder: (BuildContext context) {
          return PlayerSignedupEdit(playerData: playerData);
        }
      );      

      if (upd != null) {
        LogUtil.debug('Updated player after player clicked Update Info-> player name: ${upd.playerName}, level: ${upd.level}, topScore: ${upd.topScore}, dob: ${upd.dateOfBirth}, img: ${upd.profileImgPath}');
        playerData.playerName = upd.playerName;
        playerData.profileImgPath = upd.profileImgPath;
        playerData.dateOfBirth = upd.dateOfBirth;
        playerData.gender = upd.gender;
        playerData.profileImgPath = upd.profileImgPath;
        (context as Element).markNeedsBuild();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }

  void _showPicDialog(BuildContext context, String imagePath) {
    LogUtil.debug('Try to initiate player profile dialog');
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300, // Adjust the size of the enlarged image
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
  
}