class UserModel {
  String uid;
  String email;
  String phone;
  String name;
  String img;

  UserModel({required this.uid, required this.email, required this.phone, required this.name, required this.img});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      name: map['name'],
      img: map['img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'name': name,
      'img': img
    };
  }
}
