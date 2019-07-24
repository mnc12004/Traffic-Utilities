class User {
  final String _full_name;
  final String _regimental;
  final String _location;
  final String _email;

  User(this._location, this._regimental, this._full_name, this._email);

  String get full_name => _full_name;
  String get email => _email;
  String get regimental => _regimental;
  String get location => _location;

  
}
