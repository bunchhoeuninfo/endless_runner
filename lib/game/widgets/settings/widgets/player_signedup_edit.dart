import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/auth/managers/player_auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerSignedupEdit extends StatefulWidget {
  final PlayerAuthManager playerAuthManager;

  const PlayerSignedupEdit({super.key, required this.playerAuthManager});
  
  @override
  State<PlayerSignedupEdit> createState() => _PlayerSignedupEditState();

  
}

class _PlayerSignedupEditState extends State<PlayerSignedupEdit> {
  final TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  String? gender;

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
    final player = await widget.playerAuthManager.loadPlayerData();
    if (player != null) {
      setState(() {
        nameController.text = player.playerName;
        selectedDate = player.dateOfBirth;
        gender = player.gender;
      });
    }
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
      level: 1, // Assuming level and topScore remain unchanged
      topScore: 0,
      dateOfBirth: selectedDate!,
      gender: gender!,
      profileImgPath: 'assets'
    );

    await widget.playerAuthManager.updatePlayerData(updatedPlayer);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
       const  SnackBar(content: Text('Player profile updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text('Edit Profile')),
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _updateInfo,
                child: const Text('Update Info'),
              ),
            ),
          ],
        ),
    );
  }

}