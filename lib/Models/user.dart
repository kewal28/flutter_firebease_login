class UserModel {
  String uid;
  String email;
  String phone;
  String name;

  UserModel({this.uid, this.email, this.phone, this.name});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'phone': phone, 'name': name};
  }
}
