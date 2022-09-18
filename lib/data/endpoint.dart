class Endpoint {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  // list restaurant (GET)
  static const String list = '${_baseUrl}list';

  // detail restaurant (GET)
  static const String detail = '${_baseUrl}detail/';

  // search restaurant (GET)
  static const String search = '${_baseUrl}search?q=';

  // add review (POST)
  static const String addReview = '${_baseUrl}review';

  // image restaurant (GET)
  static const String imageSmall = '${_baseUrl}images/small/';
  static const String imageMedium = '${_baseUrl}images/medium/';
  static const String imageLarge = '${_baseUrl}images/large/';
}
