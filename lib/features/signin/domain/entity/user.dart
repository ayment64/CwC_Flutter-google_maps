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
    sId = json['newUser']['_id'];
    email = json['newUser']['email'];
    username = json['newUser']['username'];
    password = json['newUser']['password'];
    firstname = json['newUser']['firstname'];
    lastname = json['newUser']['lastname'];
    cin = json['newUser']['cin'];
    imageurl = json['newUser']['imageurl'];
    iV = json['newUser']['__v'];
  }
  User.fromJsonLogin(Map<String, dynamic> json) {
    sId = json['user']['_id'];
    email = json['user']['email'];
    username = json['user']['username'];
    password = json['user']['password'];
    firstname = json['user']['firstname'];
    lastname = json['user']['lastname'];
    cin = json['user']['cin'];
    imageurl = json['user']['imageurl'];
    iV = json['user']['__v'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['cin'] = this.cin;
    data['imageurl'] = this.imageurl;
    data['lastLogin'] = this.lastLogin.toString();
    data['dateOfCreation'] = this.dateOfCreation.toString();
    return data;
  }
}
