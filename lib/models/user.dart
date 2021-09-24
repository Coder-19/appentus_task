// the code below is used to create a model class   to help us manage the data of the user
class User {
  // the code below is used to create a property for getting the id of the user
  int? id;
  // the property below is used to get the name of the user
  String? _userName;
  // the property below is used to get the email of the user
  String? _userEmail;
  // the property below is used to get the password of the user
  String? _userPassword;
  // the property below is used to get the phoneNumber of the user
  String? _userPhoneNumber;
  // the property below is used to get the image of the user
  String? _userImage;

  // using the dart constructor to initialize the above properties
  User(
    this._userEmail,
    this._userImage,
    this._userName,
    this._userPassword,
    this._userPhoneNumber,
  );

  // the code below is used to create the getter for getting the name of the user
  String get userName => _userName.toString();

  // the getter below is used to get the email of the user
  String get userEmail => _userEmail.toString();

  // the getter below is used to get the password of the user
  String get userPassword => _userPassword.toString();

  // the getter below is used to get the phoneNumber of the user
  String get userPhoneNumber => _userPhoneNumber.toString();

  // the getter below is used to get the image of the user
  String get userImage => _userImage.toString();

  // the code below is used to create a method to convert the map to the dart object
  User.fromMap(dynamic obj) {
    _userName = obj['userName'];
    _userEmail = obj['userEmail'];
    _userPassword = obj['userPassword'];
    _userPhoneNumber = obj['userPhoneNumber'];
    _userImage = obj['userImage'];
  }

  // the code below is used to create a method to convert the dart objects to map
  Map<String, dynamic> toMap() {
    // the code below is used to create an instance of the map
    // ignore: prefer_collection_literals
    var map = Map<String, dynamic>();
    map['userName'] = _userName;
    map['userEmail'] = _userEmail;
    map['userPassword'] = _userPassword;
    map['userPhoneNumber'] = _userPhoneNumber;
    map['userImage'] = _userImage;
    // the code below is used to return the map
    return map;
  }
}
