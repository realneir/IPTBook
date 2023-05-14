class Book {
  final String title;
  final String author;
  final int availableCopies;

  Book(
      {required this.title,
      required this.author,
      required this.availableCopies});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      availableCopies: json['available_copies'],
    );
  }
}
