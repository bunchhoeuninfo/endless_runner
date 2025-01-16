import 'package:endless_runner/auth/data/developer_profile.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/theme/endless_runner_theme.dart';
import 'package:flutter/material.dart';


class DeveloperProfileCard extends StatelessWidget {

  const DeveloperProfileCard({super.key, required this.devProfile});
  final String _className = 'DeveloperProfileCard';
  final DeveloperProfile devProfile;

  @override
  Widget build(BuildContext context) {
    LogUtil.debug(' Start $_className.build ...');
    return _buildDevProfileCard(context);
  }

  Card _buildDevProfileCard(BuildContext context) {
    LogUtil.debug(' Start $_className._buildDevProfileCard , constructing developer profile name: ${devProfile.name}');
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading Back Icon
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(), // Optional to align icon left
                ],
              ),
              const SizedBox(height: 8),
              // Profile Image
              GestureDetector(
                onTap: () => _showPicDialog(context, devProfile.imageUrl),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(devProfile.imageUrl),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              // Name
              Text(
                devProfile.name,
                style: EndlessRunnerTheme.of(context).titleH4KhTextStyle,
              ),
              const SizedBox(height: 8),
              // Title
              Text(
                devProfile.title,
                style: EndlessRunnerTheme.of(context).subTitleKhTextStyle,
              ),
              const SizedBox(height: 12),
              // Expertise
              Row(
                children: [
                  const Icon(Icons.code, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      devProfile.expertise,
                      style: EndlessRunnerTheme.of(context).titleH4KhTextStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Bio
              Text(
                devProfile.bio,
                style: EndlessRunnerTheme.of(context).titleH3KhTextStyle,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.email, size: 20, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Launch email application
                        _launchEmail(devProfile.email);
                      },
                      child: Text(
                        devProfile.email,
                        style: EndlessRunnerTheme.of(context)
                            .titleH4KhTextStyle
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ],          
          ),
        ),        
      ),
    );
  }

  void _launchEmail(String email) async {
    LogUtil.debug('Start $_className._launchEmail ...');
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: email,
      );
      
      //await launchUrl(uri);
      
    } catch (e, stackTrace) {
      LogUtil.error('Could not launch', error: e, stackTrace: stackTrace);
    }
  }

  void _showPicDialog(BuildContext context, String imagePath) {
    LogUtil.debug('Start $_className._showPicDialog ...');
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
                  image: AssetImage(imagePath),
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