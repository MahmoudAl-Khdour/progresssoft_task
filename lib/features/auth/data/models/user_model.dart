class UserModel {
  final String fullName;
  final String phoneNumber;
  final String password;
  final int gender;
  final int age;

  UserModel({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      gender: map['gender'],
      age: map['age'],
    );
  }
}
