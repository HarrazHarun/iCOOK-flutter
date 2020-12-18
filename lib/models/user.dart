class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String usernameToDb;
  final String emailToDb;
  final String genderToDb;
  final DateTime dateToDb;

  UserData(
      {this.uid,
      this.usernameToDb,
      this.emailToDb,
      this.genderToDb,
      this.dateToDb});
}
