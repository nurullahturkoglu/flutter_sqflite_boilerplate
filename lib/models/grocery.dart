// create grocery model

class Grocery {
  int? id;
  String name;

  Grocery({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Grocery.fromMap(Map<String, dynamic> map) {
    return Grocery(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  String toString() => 'Grocery(id: $id, name: $name)';
}
