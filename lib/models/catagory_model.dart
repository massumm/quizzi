class Catagory {
  final int id;
  final String name;

  Catagory({required this.id, required this.name});

  factory Catagory.fromJson(Map<String, dynamic> json) {
    return Catagory(
      id: json['id'],
      name: json['name'],
    );
  }
}
