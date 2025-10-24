import 'package:social_app/features/authentication/domain/entities/app_user.dart';

class ProfileUser extends AppUser
{
  late final String bio;
  late final String profileImageUrl;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
  });

  // method to update profile user
  ProfileUser copyWith({String? newBio, String? newProfileImageUrl}){
    return ProfileUser(
      uid: uid, 
      email: email, 
      name: name, 
      bio: newBio ?? bio, 
      profileImageUrl: newProfileImageUrl ?? profileImageUrl
    );
  }

  //convert profile to user -> json

  Map<String, dynamic> toJson(){
    return{
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImage': profileImageUrl,
    };
  }

  // convert json -> profile user
  factory ProfileUser.fromJson(Map<String, dynamic>json){
    return ProfileUser(
      uid: json['uid'], 
      email: json['email'], 
      name: json['name'], 
      bio: json['bio'] ?? '', 
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }
}