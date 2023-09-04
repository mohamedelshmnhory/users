mixin BaseApi {
  String get users;

  String get settings;
}

class GENERIC implements BaseApi {
  @override
  String get users => 'users';

  @override
  String get settings => 'settings';
}
