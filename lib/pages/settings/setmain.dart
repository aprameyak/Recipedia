import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:chef_social/pages/profile_edit_page.dart';
import 'package:chef_social/services/profile_service.dart';
import 'package:chef_social/models/user_profile.dart';

class Setmain extends StatefulWidget {
  const Setmain({super.key});
  @override
  State<Setmain> createState() => _Setmain();
}

class _Setmain extends State<Setmain> {
  final ProfileService _profileService = ProfileService();
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await _profileService.getCurrentUserProfile();
      if (mounted) {
        setState(() {
          _userProfile = profile;
        });
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditPage(initialProfile: _userProfile),
      ),
    );
    
    if (result != null) {
      setState(() {
        _userProfile = result as UserProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text("Profile"),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: const Text('Edit Profile'),
                value: Text(_userProfile?.displayName ?? 'Set up your profile'),
                onPressed: (context) => _navigateToEditProfile(),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Profile Picture'),
                value: const Text('Change your profile photo'),
                onPressed: (context) => _navigateToEditProfile(),
              ),
            ],
          ),
          SettingsSection(
            title: const Text("Account"),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.format_align_center),
                title: const Text("Theme"),
                value: const Text('Light'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                value: const Text('Manage your notifications'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text("Privacy & Security"),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.lock),
                title: const Text('Private Profile'),
                value: Text(_userProfile?.isPrivate == true ? 'Enabled' : 'Disabled'),
                onPressed: (context) async {
                  final newValue = !(_userProfile?.isPrivate ?? false);
                  await _profileService.updateProfile(isPrivate: newValue);
                  _loadUserProfile();
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.security),
                title: const Text('Security'),
                value: const Text('Password, 2FA, and more'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text("Support"),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.help),
                title: const Text('Help & Support'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.info),
                title: const Text('About'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
