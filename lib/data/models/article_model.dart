class ArticleModel {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? content;
  final String? author;

  ArticleModel(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.content,
      required this.author});
}
