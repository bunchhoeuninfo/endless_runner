import 'dart:io';

import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:endless_runner/auth/services/player_auth_service.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/settings/widgets/player_signedup_edit.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key, required this.playerData});
  final PlayerData playerData;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();

}

class _ProfileSectionState extends State<ProfileSection> {
  
  late PlayerData playerData;
  final PlayerAuthManager _playerAuthManager = PlayerAuthService();
  
  @override
  void initState() {
    super.initState();
    playerData = widget.playerData;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Loaded player-> player name: ${playerData.playerName}, level: ${playerData.level}, topScore: ${playerData.topScore}, dob: ${playerData.dateOfBirth}, img: ${playerData.profileImgPath}');
    //return _futureBuildProfile();
    return _buildRow(context, playerData.profileImgPath!);
  }

  FutureBuilder _futureBuildProfile() {
    LogUtil.debug('Inside future build method');
    try {
      return FutureBuilder(
        future: _playerAuthManager.getProfileImgPath(playerData.playerName), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading progress'),);
          /*} else {
            LogUtil.debug('Player Data-> player name: ${playerData.playerName}, profileImg: ${snapshot.data}');
            return _buildRow(context, '/data/user/0/ch.chhoeun.endless.runner/app_flutter/profile_yyyyyy1.jpg'); */
          } else if (snapshot.hasData) {
            //final profileImg = snapshot.data as String;
            LogUtil.debug('Player Data-> player name: ${playerData.playerName}, profileImg: ${snapshot.data}');
            return _buildRow(context, '/data/user/0/ch.chhoeun.endless.runner/app_flutter/profile_yyyy11s1uf1fe1aqq.jpg');     
          } else {
            LogUtil.debug('Received data -> ${snapshot.data}');
            return const Center(child: Text('Invalid data received'),);
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
  }

  Row _buildRow(BuildContext context, String profileImg) {
    LogUtil.debug('Start building Setting - Profile Section, profileImg -> $profileImg');
    return Row(
      children: [
        profileImg.isNotEmpty 
          ? CircleAvatar( 
                        backgroundImage: FileImage(File(profileImg)),
                        radius: 40,
                      )
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
            TextButton(
              onPressed: () {
                // Open dialog to edit player name/image
                showPlayerEditDialog(context, playerData);
              },
              child: const Text('Edit Profile', selectionColor: Colors.blue,),
            ),
          ],
        ),
      ],
    );
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
        //await _playerAuthManager.updatePlayerData(upd);
        // Trigger a rebuild
        (context as Element).markNeedsBuild();
      }
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }    
  }
  
}