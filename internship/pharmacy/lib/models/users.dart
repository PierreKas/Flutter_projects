class User {
  String fullName;
  String phoneNumber;
  String? role;
  String? sellingPoint;
  String? password;
  String? userState;

  User({
    required this.fullName,
    required this.phoneNumber,
    this.role,
    this.sellingPoint,
    this.password,
    this.userState,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['Full_name'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      sellingPoint: json['selling_point'],
      password: json['pwd'],
      userState: json['user_state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Full_name': fullName,
      'phone_number': phoneNumber,
      'role': role,
      'selling_point': sellingPoint,
      'pwd': password,
      'user_state': userState,
    };
  }
}
