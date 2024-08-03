class Urls {
  Urls._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndPoint = 'posts';

  static get allPosts => '$baseUrl/$postsEndPoint';
}
