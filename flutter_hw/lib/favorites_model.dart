import 'package:flutter/foundation.dart';
import 'article.dart';

class FavoritesModel extends ChangeNotifier {
  final List<Article> _favorites = [];

  List<Article> get favorites => List.unmodifiable(_favorites);

  void add(Article article) {
    if (!_favorites.any((a) => a.id == article.id)) {
      _favorites.add(article);
      notifyListeners();
    }
  }

  void remove(String articleId) {
    _favorites.removeWhere((a) => a.id == articleId);
    notifyListeners();
  }

  bool isFavorited(String articleId) {
    return _favorites.any((article) => article.id == articleId);
  }
}
