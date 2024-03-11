import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'article.dart';
import 'favorites_model.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap, required bool isLiked,
  });


  @override
  Widget build(BuildContext context) {
    final favoritesModel = Provider.of<FavoritesModel>(context, listen: false);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Image.network(
              article.imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200.0,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const Text(
                    'No Image',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(article.title),
              subtitle: Text(article.description),
              trailing: IconButton(
                icon: Icon(
                  favoritesModel.isFavorited(article.id) ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  if (favoritesModel.isFavorited(article.id)) {
                    favoritesModel.remove(article.id);
                  } else {
                    favoritesModel.add(article);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
