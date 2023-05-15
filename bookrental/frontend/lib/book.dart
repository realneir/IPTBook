class Book {
  final int? id; // made id nullable
  final String title;
  final String author;
  final int availableCopies;

  Book(
      {this.id, // removed required
      required this.title,
      required this.author,
      required this.availableCopies});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'], // will be null if 'id' is not in the json
      title: json['title'],
      author: json['author'],
      availableCopies: json['available_copies'],
    );
  }
}
