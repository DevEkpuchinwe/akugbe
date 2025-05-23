class Klik {
  final String name;
  final String location;
  final int? maxPeople;
  final String privacy;
  final String? description;
  final double totalAmount;
  final double minAmount;
  final String gender;
  final String startDate;
  final String endDate;
  final String imageUrl;

  Klik({
    required this.name,
    required this.location,
    this.maxPeople,
    required this.privacy,
    this.description,
    required this.totalAmount,
    required this.minAmount,
    required this.gender,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
  });
}
