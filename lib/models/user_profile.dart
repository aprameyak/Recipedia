class UserProfile {
  final String id;
  final String email;
  String displayName;
  String? profileImageUrl;
  String? bio;
  String? about;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPrivate;
  int followerCount;
  int followingCount;
  int postCount;

  UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    this.profileImageUrl,
    this.bio,
    this.about,
    required this.createdAt,
    required this.updatedAt,
    this.isPrivate = false,
    this.followerCount = 0,
    this.followingCount = 0,
    this.postCount = 0,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      displayName: json['display_name'] ?? '',
      profileImageUrl: json['profile_image_url'],
      bio: json['bio'],
      about: json['about'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      isPrivate: json['is_private'] ?? false,
      followerCount: json['follower_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      postCount: json['post_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'profile_image_url': profileImageUrl,
      'bio': bio,
      'about': about,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_private': isPrivate,
      'follower_count': followerCount,
      'following_count': followingCount,
      'post_count': postCount,
    };
  }

  UserProfile copyWith({
    String? displayName,
    String? profileImageUrl,
    String? bio,
    String? about,
    bool? isPrivate,
    int? followerCount,
    int? followingCount,
    int? postCount,
  }) {
    return UserProfile(
      id: id,
      email: email,
      displayName: displayName ?? this.displayName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      about: about ?? this.about,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isPrivate: isPrivate ?? this.isPrivate,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      postCount: postCount ?? this.postCount,
    );
  }
}
