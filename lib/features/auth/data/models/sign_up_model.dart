class SignUpModel {
  final String username;
  final String email;
  final String password;

  const SignUpModel({
    required this.username,
    required this.email,
    required this.password
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
        username: json['username'],
        email: json['email'],
        password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
  };
}