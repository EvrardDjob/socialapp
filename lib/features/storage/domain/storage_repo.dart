import 'dart:typed_data';

abstract class StorageRepo {
  // upload profile images on mobile platforms
  Future<String?> uploadProfileImageMobile(String path, String fileName);


  // upload profile images on web plaforms
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);

}