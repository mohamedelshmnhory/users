mixin BaseApi {
  String get jobs;

  String get levels;

  String get users;

  String get settings;

  String get profile;

  String get updateProfile;

  String get homeApi;

  String get loginApi;

  String get socialLoginApi;

  String get forgetPasswordRequest;

  String get contactUS;

  String get forgetPasswordUpdate;

  String get notificationList;

  String get registerApi;

  String get pointsApi;

  String get messages;

  String get favourite;
}

class GENERIC implements BaseApi {
  @override
  String get jobs => 'jobs';

  @override
  String get levels => 'levels';

  @override
  String get users => 'users';

  @override
  String get homeApi => '';

  String get governorateApi => 'governorate?allowPagination=false';

  @override
  String get loginApi => 'login';

  @override
  String get socialLoginApi => 'login/social';

  @override
  String get registerApi => 'register';

  @override
  String get forgetPasswordRequest => 'auth/forget-password/request';

  @override
  String get forgetPasswordUpdate => 'auth/forget-password/update';

  @override
  String get profile => "profile";

  @override
  String get updateProfile => "profile/update";

  String get professionApi => '';

  @override
  String get messages => 'messages';

  String get districtsApi => 'district?&allowPagination=false';

  @override
  String get notificationList => 'fetch-all-notifications';

  @override
  String get pointsApi => '';

  @override
  String get favourite => 'favourites';

  @override
  String get contactUS => 'contacts';

  @override
  String get settings => 'settings';
}
