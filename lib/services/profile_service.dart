import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import '../models/user_profile.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get current user's profile
  Future<UserProfile?> getCurrentUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return UserProfile.fromJson(response);
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Create or update user profile
  Future<UserProfile?> createOrUpdateProfile(UserProfile profile) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final response = await _supabase
          .from('profiles')
          .upsert(profile.toJson())
          .select()
          .single();

      return UserProfile.fromJson(response);
    } catch (e) {
      print('Error creating/updating profile: $e');
      return null;
    }
  }

  // Update profile fields
  Future<UserProfile?> updateProfile({
    String? displayName,
    String? bio,
    String? about,
    bool? isPrivate,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (displayName != null) updates['display_name'] = displayName;
      if (bio != null) updates['bio'] = bio;
      if (about != null) updates['about'] = about;
      if (isPrivate != null) updates['is_private'] = isPrivate;

      final response = await _supabase
          .from('profiles')
          .update(updates)
          .eq('id', user.id)
          .select()
          .single();

      return UserProfile.fromJson(response);
    } catch (e) {
      print('Error updating profile: $e');
      return null;
    }
  }

  // Upload profile image
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final fileExt = path.extension(imageFile.path);
      final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}$fileExt';
      final filePath = 'profile_images/$fileName';

      // Upload file to Supabase Storage
      await _supabase.storage
          .from('avatars')
          .upload(filePath, imageFile);

      // Get public URL
      final imageUrl = _supabase.storage
          .from('avatars')
          .getPublicUrl(filePath);

      // Update profile with new image URL
      await _supabase
          .from('profiles')
          .update({
            'profile_image_url': imageUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id);

      return imageUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  // Delete profile image
  Future<bool> deleteProfileImage() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return false;

      // Get current profile to find image path
      final profile = await getCurrentUserProfile();
      if (profile?.profileImageUrl != null) {
        // Extract file path from URL and delete from storage
        final urlParts = profile!.profileImageUrl!.split('/');
        final fileName = urlParts.last;
        final filePath = 'profile_images/$fileName';

        await _supabase.storage
            .from('avatars')
            .remove([filePath]);
      }

      // Update profile to remove image URL
      await _supabase
          .from('profiles')
          .update({
            'profile_image_url': null,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id);

      return true;
    } catch (e) {
      print('Error deleting profile image: $e');
      return false;
    }
  }

  // Get user profile by ID
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return UserProfile.fromJson(response);
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Search users by display name
  Future<List<UserProfile>> searchUsers(String query) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .ilike('display_name', '%$query%')
          .limit(20);

      return response.map((json) => UserProfile.fromJson(json)).toList();
    } catch (e) {
      print('Error searching users: $e');
      return [];
    }
  }
}
