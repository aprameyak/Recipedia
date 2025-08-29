import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chef_social/models/user_profile.dart';
import 'package:chef_social/services/profile_service.dart';
import 'package:chef_social/utils/image_picker_utils.dart';
import 'package:chef_social/theme/app_theme.dart';

class ProfileEditPage extends StatefulWidget {
  final UserProfile? initialProfile;
  
  const ProfileEditPage({super.key, this.initialProfile});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _aboutController = TextEditingController();
  
  final ProfileService _profileService = ProfileService();
  
  UserProfile? _currentProfile;
  File? _selectedImageFile;
  bool _isLoading = false;
  bool _isPrivate = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    
    try {
      final profile = widget.initialProfile ?? await _profileService.getCurrentUserProfile();
      if (profile != null) {
        setState(() {
          _currentProfile = profile;
          _displayNameController.text = profile.displayName;
          _bioController.text = profile.bio ?? '';
          _aboutController.text = profile.about ?? '';
          _isPrivate = profile.isPrivate;
        });
      }
    } catch (e) {
      _showSnackBar('Error loading profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    try {
      final imageFile = await ImagePickerUtils.showImageSourceDialog(context);
      if (imageFile != null) {
        if (!ImagePickerUtils.isValidImageFile(imageFile)) {
          _showSnackBar('Please select a valid image file (JPG, PNG, GIF, WebP)');
          return;
        }
        
        if (!ImagePickerUtils.isFileSizeValid(imageFile, maxSizeMB: 5.0)) {
          _showSnackBar('Image file size must be less than 5MB');
          return;
        }
        
        setState(() {
          _selectedImageFile = imageFile;
        });
      }
    } catch (e) {
      _showSnackBar('Error picking image: $e');
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Upload image first if selected
      String? imageUrl;
      if (_selectedImageFile != null) {
        imageUrl = await _profileService.uploadProfileImage(_selectedImageFile!);
        if (imageUrl == null) {
          _showSnackBar('Failed to upload image');
          return;
        }
      }

      // Update profile
      final updatedProfile = await _profileService.updateProfile(
        displayName: _displayNameController.text.trim(),
        bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
        about: _aboutController.text.trim().isEmpty ? null : _aboutController.text.trim(),
        isPrivate: _isPrivate,
      );

      if (updatedProfile != null) {
        _showSnackBar('Profile updated successfully!');
        Navigator.pop(context, updatedProfile);
      } else {
        _showSnackBar('Failed to update profile');
      }
    } catch (e) {
      _showSnackBar('Error saving profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: AppTheme.surfaceColor,
        foregroundColor: AppTheme.textPrimary,
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveProfile,
              child: const Text('Save'),
            ),
        ],
      ),
      body: _isLoading && _currentProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image Section
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: _selectedImageFile != null
                                      ? FileImage(_selectedImageFile!)
                                      : (_currentProfile?.profileImageUrl != null
                                          ? NetworkImage(_currentProfile!.profileImageUrl!)
                                          : null) as ImageProvider?,
                                  child: (_selectedImageFile == null && 
                                          _currentProfile?.profileImageUrl == null)
                                      ? const Icon(Icons.person, size: 60, color: Colors.grey)
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: _pickImage,
                            child: const Text('Change Photo'),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Display Name Field
                    TextFormField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        hintText: 'Enter your display name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Display name is required';
                        }
                        if (value.trim().length < 2) {
                          return 'Display name must be at least 2 characters';
                        }
                        if (value.trim().length > 50) {
                          return 'Display name must be less than 50 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Bio Field
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        hintText: 'Tell us about yourself (optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      maxLength: 150,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // About Field
                    TextFormField(
                      controller: _aboutController,
                      decoration: const InputDecoration(
                        labelText: 'About',
                        hintText: 'More details about yourself (optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      maxLength: 500,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Privacy Toggle
                    SwitchListTile(
                      title: const Text('Private Profile'),
                      subtitle: const Text('Only approved followers can see your posts'),
                      value: _isPrivate,
                      onChanged: (value) {
                        setState(() {
                          _isPrivate = value;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
