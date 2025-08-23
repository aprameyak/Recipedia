# Profile Management System Setup

This document provides instructions for setting up the comprehensive profile management system for the Cooking App.

## Features Implemented

### ✅ Profile Management
- **Display Name**: Users can set and update their display name
- **Profile Image Upload**: Image upload from camera or gallery with cropping
- **Bio & About**: Optional bio and detailed about sections
- **Privacy Settings**: Toggle for private/public profiles
- **Profile Statistics**: Posts, followers, and following counts

### ✅ Image Upload System
- **Camera Integration**: Take photos directly from the app
- **Gallery Selection**: Choose images from device gallery
- **Image Cropping**: Square aspect ratio cropping for profile pictures
- **File Validation**: Size and format validation
- **Cloud Storage**: Images stored in Supabase Storage

### ✅ Database Management
- **User Profiles Table**: Complete profile data storage
- **Row Level Security**: Secure access control
- **Automatic Triggers**: Profile creation on user registration
- **Storage Buckets**: Organized image storage

## Setup Instructions

### 1. Install Dependencies

The following dependencies have been added to `pubspec.yaml`:

```yaml
# Image handling dependencies
image_picker: ^1.0.7
image_cropper: ^5.0.1
file_picker: ^8.0.0+1
path_provider: ^2.1.2
permission_handler: ^11.3.1
```

Run the following command to install dependencies:
```bash
flutter pub get
```

### 2. Database Setup

1. **Open your Supabase Dashboard**
2. **Go to SQL Editor**
3. **Copy and paste the contents of `database_setup.sql`**
4. **Run the script**

This will create:
- `profiles` table with all necessary fields
- Row Level Security policies
- Storage bucket for profile images
- Automatic triggers for user registration
- Performance indexes

### 3. Platform-Specific Configuration

#### Android Configuration

Add the following permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

#### iOS Configuration

Add the following keys to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take profile pictures</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select profile pictures</string>
```

### 4. Files Created/Modified

#### New Files:
- `lib/models/user_profile.dart` - User profile data model
- `lib/services/profile_service.dart` - Database operations service
- `lib/utils/image_picker_utils.dart` - Image picking and processing utilities
- `lib/pages/profile_edit_page.dart` - Profile editing interface
- `database_setup.sql` - Database schema and policies
- `PROFILE_SETUP.md` - This setup guide

#### Modified Files:
- `lib/pages/prof.dart` - Enhanced profile page with new features
- `lib/pages/settings/setmain.dart` - Updated settings with profile options
- `pubspec.yaml` - Added new dependencies

## Usage

### For Users:

1. **Profile Page**: Navigate to the Profile tab to view your profile
2. **Edit Profile**: Tap "Edit Profile" to modify your information
3. **Change Photo**: Tap the camera icon or "Change Photo" button
4. **Settings**: Access profile settings from the Settings page

### For Developers:

#### Creating a Profile:
```dart
final profileService = ProfileService();
final profile = await profileService.getCurrentUserProfile();
```

#### Updating Profile:
```dart
final updatedProfile = await profileService.updateProfile(
  displayName: 'New Name',
  bio: 'New bio',
  isPrivate: false,
);
```

#### Uploading Image:
```dart
final imageUrl = await profileService.uploadProfileImage(imageFile);
```

## Database Schema

### Profiles Table:
```sql
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id),
    email TEXT NOT NULL,
    display_name TEXT NOT NULL,
    profile_image_url TEXT,
    bio TEXT,
    about TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_private BOOLEAN DEFAULT FALSE,
    follower_count INTEGER DEFAULT 0,
    following_count INTEGER DEFAULT 0,
    post_count INTEGER DEFAULT 0
);
```

## Security Features

- **Row Level Security**: Users can only access their own profiles
- **Public Profiles**: Non-private profiles are viewable by all users
- **Image Storage**: Secure storage with user-specific access
- **Input Validation**: Client-side validation for all inputs
- **File Size Limits**: 5MB maximum file size for images

## Troubleshooting

### Common Issues:

1. **Image Upload Fails**:
   - Check Supabase Storage bucket permissions
   - Verify file size is under 5MB
   - Ensure proper file format (JPG, PNG, GIF, WebP)

2. **Profile Not Loading**:
   - Verify database setup script was run
   - Check RLS policies are active
   - Ensure user is authenticated

3. **Camera/Gallery Not Working**:
   - Verify platform permissions are configured
   - Check device permissions are granted
   - Test on physical device (not simulator for camera)

### Support:

If you encounter issues, check:
1. Supabase dashboard for database errors
2. Flutter console for app errors
3. Device logs for permission issues

## Future Enhancements

Potential improvements for the profile system:
- Profile verification badges
- Social media links
- Profile themes/customization
- Advanced privacy controls
- Profile analytics
- Bulk image upload
- Image filters and effects
