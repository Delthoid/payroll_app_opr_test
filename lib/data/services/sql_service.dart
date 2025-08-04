import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:sqflite/sqflite.dart';

class SqlService {
  Database? _database;

  Database? get instance => _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<void> insertSession({required UserSession session}) async {
    try {
      final db = await database;
      await db.insert('sessions', {
        'token': session.token,
        'user_logged': session.userLogged,
        'company_name': session.companyName,
        'company_id': session.companyId,
        'employee_id_digits': session.employeeIdDigits,
        'employee_id': session.employeeId,
        'rate_settings': session.rateSettings,
        'holidays': session.holidays.join(','),
        'workdays': session.workDays.join(','),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting session: $e');
      rethrow;
    }
  }

  Future<List<UserSession>> getSessions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sessions');

    final sessions = List.generate(maps.length, (i) {
      return UserSession(
        token: maps[i]['token'],
        userLogged: maps[i]['user_logged'],
        companyName: maps[i]['company_name'],
        companyId: maps[i]['company_id'],
        employeeIdDigits: maps[i]['employee_id_digits'],
        employeeId: maps[i]['employee_id'],
        rateSettings: maps[i]['rate_settings'],
        holidays: maps[i]['holidays'].split(','),
        workDays: (maps[i]['workdays'] as String)
            .split(',')
            .map(int.parse)
            .toList(),
      );
    });

    return sessions;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      'payroll_app.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE sessions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            token TEXT NOT NULL,
            user_logged TEXT NOT NULL,
            company_name TEXT NOT NULL,
            company_id INTEGER NOT NULL,
            employee_id_digits INTEGER NOT NULL,
            employee_id INTEGER NOT NULL,
            rate_settings TEXT NOT NULL,
            holidays TEXT NOT NULL,
            workdays TEXT NOT NULL
            )
        ''');

        await db.execute('''
          CREATE TABLE employees (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            email TEXT NOT NULL,
            position TEXT NOT NULL,
            hourly_rate REAL NOT NULL
          )
        ''');
      },
    );
  }
}
