class User {
  int id;
  String email;
  String password;
  String? name;
  String? mobile;
  User({
    required this.id,
    required this.email,
    required this.password,
    this.name,
    this.mobile,
  });
}
