import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/noticia/news_provider.dart';
import 'news_detail.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: const Color(0xFF0F539C),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/register.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            if (newsProvider.newsList.isEmpty) {
              newsProvider.fetchNews();
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: newsProvider.newsList.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                final news = newsProvider.newsList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: news.imageUrl.isNotEmpty
                        ? Image.network(news.imageUrl,
                            width: 100, fit: BoxFit.cover)
                        : null,
                    title: Text(news.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(news.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(news: news),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
