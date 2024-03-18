class EmergencyContact {
  final int?
      id; // Auto increment ID, nullable because new contacts won't have an ID initially
  final String name;
  final String number;

  EmergencyContact({this.id, required this.name, required this.number});

  // Convert a Contact object into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }

  // Implement a method to create an EmergencyContact from a Map
  static EmergencyContact fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'],
      name: map['name'],
      number: map['number'],
    );
  }
}
