class Movie {
  static const int REGULAR = 0;
  static const int NEW_RELEASE = 1;
  static const int CHILDREN = 2;
  final String title;
  final int priceCode;
  final bool isPopular;
  final bool isExpensive;
  const Movie({
    required this.title,
    required this.priceCode,
    this.isPopular = false,
    this.isExpensive = false,
  });
}
