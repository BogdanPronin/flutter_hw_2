// Файл favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'article_card.dart';
import 'article.dart';
import 'article_detail_page.dart';
import 'favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Article> favorites = Provider.of<FavoritesModel>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked News'),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text('No favorites yet'),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final article = favorites[index];
          return ArticleCard(
            article: article,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ArticleDetailPage(article: article),
              ));
              // Навигация к детальной странице статьи, если требуется
            }, isLiked: article.isLiked,
          );
        },
      ),
    );
  }
}
