import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String displayName;
  String email;
  Roles roles;
  bool emailVerified;
  String status;
  User({this.displayName, this.email, this.roles, this.emailVerified, this.status});

  User.fromJson(Map<String, dynamic> json)
      : displayName = json['disaplayName'],
        email = json['email'],
        roles = Roles.fromJson(json['roles']),
        emailVerified = json['emailVerified'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    'email': email,
    'emailVerified': emailVerified,
    'roles': roles.toJson(),
    'status': status
  };

  factory User.fromDocument(DocumentSnapshot document) {
    return new User(
        displayName : document != null ? document['disaplayName'] : "",
        email : document != null ? document['email'] : "",
        roles : Roles.fromJson(document != null ? document['roles'] : null) ,
        emailVerified : document != null ? document['emailVerified'] : false,
        status : document != null ? document['status'] : "active"
    );
  }
}

class Roles {
  bool admin;
  bool user;
  bool designer;

  Roles(this.admin, this.user, this.designer);

  Roles.fromJson(Map<dynamic, dynamic> json)
      : admin = json != null ? json['admin'] : false,
        user = json != null ? json['user'] : true,
        designer = json != null ? json['designer'] : false;

  Map<dynamic, dynamic> toJson() =>
      {
        'admin': admin,
        'user': user,
        'designer': designer
      };
}
