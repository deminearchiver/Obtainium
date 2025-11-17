import 'package:materium/flutter.dart' show WidgetsFlutterBinding;
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:materium/providers/logs_provider.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Logs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get level => textEnum<LogLevels>()();

  TextColumn get message => text()();

  // TODO: consider replacing with clientDefault(() => DateTime.now())
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Logs])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: "materium",
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`:
        databaseDirectory: getApplicationDocumentsDirectory,

        // getApplicationSupportDirectory may also be used:
        // databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  static AppDatabase? _instance;

  static AppDatabase get instance {
    assert(_instance != null);
    return _instance!;
  }

  static Future<void> ensureInitialized() async {
    if (_instance != null) return;
    WidgetsFlutterBinding.ensureInitialized();
    _instance = AppDatabase();
  }
}
