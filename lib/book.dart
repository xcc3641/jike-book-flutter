class Book {
  Book({
    required this.title,
    required this.image,
    required this.doubanUrl,
    required this.count,
    required this.rating,
    required this.abstract,
    required this.ranking,
    required this.colors,
  });
  late final String title;
  late final String image;
  late final String doubanUrl;
  late final int count;
  late final double rating;
  late final String abstract;
  late final int ranking;
  late final List<String> colors;

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    doubanUrl = json['doubanUrl'];
    count = json['count'];
    rating = json['rating'];
    abstract = json['abstract'];
    ranking = json['ranking'];
    colors = List.castFrom<dynamic, String>(json['colors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['image'] = image;
    _data['doubanUrl'] = doubanUrl;
    _data['count'] = count;
    _data['rating'] = rating;
    _data['abstract'] = abstract;
    _data['ranking'] = ranking;
    _data['colors'] = colors;
    return _data;
  }
}
