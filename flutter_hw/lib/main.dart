import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'article.dart';
import 'article_card.dart';
import 'article_detail_page.dart';
import 'favorites_model.dart';
import 'favorites_screen.dart';
import 'news_api_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: ThemeMode.system,
      home: const NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final NewsApiService _newsApiService = NewsApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FavoritesScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _newsApiService.fetchTopHeadlines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final articleData = snapshot.data![index];
                final Article article = Article(
                  id: articleData['url'],
                  title: articleData['title'] ?? 'No title',
                  description: articleData['description'] ?? 'No description',
                  imageUrl: articleData['urlToImage'] ?? 'https://via.placeholder.com/150',
                  articleUrl: articleData['url'] ?? 'No URL',
                );

                // Использование Provider для определения, понравилась ли статья
                bool isLiked = Provider.of<FavoritesModel>(context).isFavorited(article.id);

                return ArticleCard(
                  article: article,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ArticleDetailPage(article: article),
                    ));
                  },
                  isLiked: isLiked,
                );
              },
            );
          }
        },
      ),
    );
  }
}
