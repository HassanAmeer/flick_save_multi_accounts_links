class UserModel {
  String? name;
  String? email;
  String? phone;
  String? profession;
  String? organization;
  bool isActive;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.profession,
    this.organization,
    required this.isActive,
  });
}
