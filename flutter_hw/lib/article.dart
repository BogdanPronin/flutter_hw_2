class Article {
  final String id; // Используйте уникальный идентификатор статьи
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;
  bool isLiked;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
    this.isLiked = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Article && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
