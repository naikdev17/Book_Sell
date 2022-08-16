class Usermodel {
  String? uid;
  String? email;
  String? displayName;
  Usermodel({this.uid, this.email, this.displayName});

  //data from server
  factory Usermodel.fromMap(Map) {
    return Usermodel(
      uid: Map['uid'],
      email: Map['email'],
      displayName: Map['displayName'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'displayName': displayName};
  }
}
