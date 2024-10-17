class SignUpModel {
  String email;
  String password;
  String name;
  String phone;

  SignUpModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
    };
    return data;
  }
}
