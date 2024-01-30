class SignUpModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
  };
}