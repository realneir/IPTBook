class Rental {
  final int id;
  final String startDate;
  final String endDate;
  final int rentalDays;
  final int book;
  final int userProfile;

  Rental({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.rentalDays,
    required this.book,
    required this.userProfile,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      rentalDays: json['rental_days'],
      book: json['book'],
      userProfile: json['user_profile'],
    );
  }
}
