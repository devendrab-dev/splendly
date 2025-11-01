import 'dart:convert';

class UserModel {
  final String token;
  final User user;
  UserModel({
    required this.token,
    required this.user,
  });

  UserModel copyWith({
    String? token,
    User? user,
  }) {
    return UserModel(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'user': user.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] as String,
      user: User.fromMap(map['user'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(Map<String,dynamic> source) => UserModel.fromMap(source);

  @override
  String toString() => 'UserModel(token: $token, user: $user)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.user == user;
  }

  @override
  int get hashCode => token.hashCode ^ user.hashCode;
}

class User {
  final String name;
  final String email;
  final String profileUrl;
  User({
    required this.name,
    required this.email,
    required this.profileUrl,
  });

  User copyWith({
    String? name,
    String? email,
    String? profileUrl,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profile_url': profileUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      profileUrl: map['profile_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);

  @override
  String toString() => 'User(name: $name, email: $email, profile_url: $profileUrl)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.profileUrl == profileUrl;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ profileUrl.hashCode;
}
