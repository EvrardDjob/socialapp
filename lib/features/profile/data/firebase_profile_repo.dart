import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_app/features/profile/domain/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo{

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async{
    try{
       // get user document from 
        final userDoc = await firebaseFirestore.collection('users').doc(uid).get();

        if(userDoc.exists){
          final userData = userDoc.data();

          if(userData != null){
            // get profileUser
            return ProfileUser(
              uid: uid, 
              email: userData['email'], 
              name: userData['name'] ?? '', 
              bio: userData['bio'] ?? '', 
              profileImageUrl: userData['profileImageUrl'].toString(),
            );
          }
       }
      print('Aucun profil trouvé!');
      return null;
    }
    catch(e){
      print('Erreur fetchUserProfile: $e');
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfile) async{
    try{
      
      // convert updated profile to json to store in firebase
      await firebaseFirestore
        .collection('users')
        .doc(updatedProfile.uid)
        .update({
          'name': updatedProfile.name,
          'bio': updatedProfile.bio, 'profileImageUrl':updatedProfile.profileImageUrl
        });
    }
    
    catch(e){
      throw Exception(e);
    }
  }
   
}

