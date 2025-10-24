import 'dart:io';
import 'dart:typed_data';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/features/storage/domain/storage_repo.dart';

class CloudinaryStorageRepo implements StorageRepo{

    final cloudinary = CloudinaryPublic(
    'dv4xgbxi6', 
    'social_app_uploads', 
    cache: false,
    );

    @override
    Future<String?> uploadProfileImageMobile(String path, String fileName) {
      return _uploadFile(path, fileName, "profile_images");
    }

    @override
    Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
      return _uploadFileBytes(fileBytes, fileName, "profile_images");
    }

  /* 
  helper methods - to upload files to storage
  */

  // mobile platforms (file)
    Future<String?> _uploadFile(String path, String fileName, String folder) async {
    try {
      print('📤 Upload mobile vers Cloudinary...');
      
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          path,
          folder: folder,
          publicId: fileName, // Utilise fileName comme ID
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      print('Image uploadée (mobile): ${response.secureUrl}');
      return response.secureUrl;
      
    } catch (e) {
      print('Erreur upload mobile: $e');
      return null;
    }
  }

  // web platforms (bytes)
    Future<String?> _uploadFileBytes(
    Uint8List fileBytes,
    String fileName,
    String folder,
  ) async {
    try {
      print('Upload web vers Cloudinary...');

      // Convertir les bytes en fichier temporaire pour Cloudinary
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(fileBytes);

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          tempFile.path,
          folder: folder,
          publicId: fileName,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      // Supprimer le fichier temporaire
      await tempFile.delete();

      print('Image uploadée (web): ${response.secureUrl}');
      return response.secureUrl;
    } catch (e) {
      print('Erreur upload web: $e');
      return null;
    }
  }
}