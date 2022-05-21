class User {
  String? nama;
  String? phone;
  String? email;
  User({this.nama, this.phone, this.email});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        nama: object['nama'],
        email: object['email'].toString(),
        phone: object['mobile_phone'].toString());
  }

  // factory User.getUser(Map<String, dynamic> object) {
  //   return User(
  //       nama: object['nama'],
  //       phone: object['address'].toString(),
  //       email: object['email'].toString());
  // }
  // factory User.updateUser(Map<String, dynamic> object) {
  //   return User(
  //       nama: object['nama'],
  //       phone: object['address'].toString(),
  //       email: object['email'].toString());
  // }

  // factory User.loginUser(Map<String, dynamic> object) {
  //   return User();
  // }
  // factory User.logoutUser(Map<String, dynamic> object) {
  //   return User(
  //       nama: object['nama'],
  //       phone: object['address'].toString(),
  //       email: object['email'].toString());
  // }
}

class UninitializedUser extends User {}
