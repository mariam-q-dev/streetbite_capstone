class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? profilePhotoUrl;

  UserModel._builder(UserModelBuilder builder)
      : uid = builder.uid,
        fullName = builder.fullName,
        email = builder.email,
        profilePhotoUrl = builder.profilePhotoUrl;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModelBuilder()
        .setUid(map['uid'] ?? '')
        .setFullName(map['fullName'] ?? '')
        .setEmail(map['email'] ?? '')
        .setProfilePhotoUrl(map['profilePhotoUrl'])
        .build();
  }
}

/// Builder Pattern for UserModel
class UserModelBuilder {
  String uid = '';
  String fullName = '';
  String email = '';
  String? profilePhotoUrl;

  UserModelBuilder setUid(String uid) {
    this.uid = uid;
    return this;
  }

  UserModelBuilder setFullName(String name) {
  
    if (name.isNotEmpty) {
      this.fullName = name[0].toUpperCase() + name.substring(1);
    } else {
      this.fullName = name;
    }
    return this;
  }

  UserModelBuilder setEmail(String email) {
    this.email = email;
    return this;
  }

  UserModelBuilder setProfilePhotoUrl(String? url) {
    this.profilePhotoUrl = url;
    return this;
  }

  UserModel build() {
    return UserModel._builder(this);
  }
}