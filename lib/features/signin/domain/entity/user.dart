class User {
  String sId;
  String email;
  String username;
  String password;
  String firstname;
  String lastname;
  String cin;
  String imageurl;
  DateTime lastLogin;
  DateTime dateOfCreation;
  int iV;

  User(
      {this.sId,
      this.email,
      this.username,
      this.password,
      this.firstname,
      this.lastname,
      this.cin,
      this.imageurl,
      this.lastLogin,
      this.dateOfCreation,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    cin = json['cin'];
    imageurl = json['imageurl'];
    lastLogin = json['lastLogin'];
    dateOfCreation = json['dateOfCreation'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['cin'] = this.cin;
    data['imageurl'] = this.imageurl;
    data['lastLogin'] = this.lastLogin;
    data['dateOfCreation'] = this.dateOfCreation;
    data['__v'] = this.iV;
    return data;
  }
}
