import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/emergencycontact.dart';
import '../screens/contacts/contact_screen.dart';
import 'package:path_provider/path_provider.dart';
 // Import your EmergencyContact model

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE contacts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  number TEXT NOT NULL
)
''');
  }

  Future<void> insertContact(EmergencyContact contact) async {
    final db = await instance.database;
    await db.insert('contacts', contact.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<EmergencyContact>> getContacts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return EmergencyContact.fromMap(maps[i]);
    });
  }

  Future<void> deleteContact(int id) async {
    final db = await instance.database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
