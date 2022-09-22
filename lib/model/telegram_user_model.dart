class TelegramUser {
  String telegramId;
  String firstName;
  String? lastName;
  String? userName;
  bool? isPremium;
  String? photoUrl;
  TelegramUser({
    required this.telegramId,
    required this.firstName,
    this.lastName,
    this.userName,
    this.isPremium,
    this.photoUrl,
  });

  factory TelegramUser.fromJS(Map<String, dynamic> model) {
    return TelegramUser(
      telegramId: model['id'],
      firstName: model['first_name'],
      lastName: model['last_name'],
      userName: model['username'],
      isPremium: model['is_premium'],
      photoUrl: model['photo_url'],
    );
  }

  get toJson {
    return {
      'id': telegramId,
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'is_premium': isPremium,
      'photo_url': photoUrl,
    };
  }
}
