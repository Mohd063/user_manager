import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:manage_me/data/model/post_model.dart';

/// Singleton class to manage SQLite database.
class DatabaseHelper {
  // 1. Private constructor
  DatabaseHelper._internal();

  // 2. Single instance
  static final DatabaseHelper instance = DatabaseHelper._internal();

  // 3. Database reference
  static Database? _database;

  /// Getter for the database. Initializes it if necessary.
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, open the database
    _database = await _initDatabase();
    return _database!;
  }

  /// Opens (and creates, if necessary) the database file.
  Future<Database> _initDatabase() async {
    // Get the default database path for this platform
    final dbPath = await getDatabasesPath();
    // Set the full path to the file
    final path = join(dbPath, 'manage_me.db');

    // Open the database, create tables if they don't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Called automatically when the database is first created
  FutureOr<void> _onCreate(Database db, int version) async {
    // Create 'posts' table
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        title TEXT NOT NULL,
        body TEXT NOT NULL
      )
    ''');
  }

  /// Inserts a new [post] into the 'posts' table.
  /// Returns the auto-generated id.
Future<int> insertPost(PostModel post) async {
  final db = await database;
  final id = await db.insert('posts', post.toJson());
  return id;
}

  /// Fetches all posts for a given [userId], ordered by descending id.
  Future<List<PostModel>> fetchPostsByUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'posts',
      where: 'userId = ?',
      whereArgs: [userId],
      
    );
    
    return maps.map((json) => PostModel.fromJson(json)).toList();
  }

  /// Deletes a post by its [id].
  Future<int> deletePost(int id) async {
    final db = await database;
    return await db.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Updates an existing [post]. Requires that [post.id] is non-null.
  Future<int> updatePost(PostModel post) async {
    final db = await database;
    return await db.update(
      'posts',
      post.toJson(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  /// Closes the database (optional, usually not needed unless you explicitly want to).
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
