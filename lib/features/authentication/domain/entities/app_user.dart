class AppUser 
{
  final String uid;
  final String email;
  final String name;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
  });

  //convert app user to json
  Map<String, dynamic> toJson(){
    return{
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  //convert json to app user
  // factory : indique qu'il (le constructeur nommé AppUser.fromJson) ne crée pas nécessairement une nouvelle instance à chaque appel(bien qu'il le fasse ici)
  factory AppUser.fromJson(Map<String, dynamic> jsonUser){
    return AppUser(
      uid: jsonUser['uid'], 
      email: jsonUser['email'], 
      name: jsonUser['name'],
    );
  }
}