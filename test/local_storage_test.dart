import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_storage_tanjim/local_storage.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TempCache', () {
    late TempCache TempCache;

    setUp(() async {
      await Hive.initFlutter();
      TempCache = TempCache();
      await TempCache.init();
    });

    tearDown(() async {
      await TempCache.clearAll();
      await Hive.deleteBoxFromDisk('TempCache');
      Hive.close();
    });

    test('saveData and readData', () async {
      const key = 'test_key';
      const value = 'test_value';

      await TempCache.saveData(key, value);
      final result = TempCache.readData<String>(key);

      expect(result, equals(value));
    });

    test('removeData', () async {
      const key = 'test_key';
      const value = 'test_value';

      await TempCache.saveData(key, value);
      await TempCache.removeData(key);
      final result = TempCache.readData<String>(key);

      expect(result, isNull);
    });

    test('clearAll', () async {
      const key1 = 'test_key1';
      const value1 = 'test_value1';
      const key2 = 'test_key2';
      const value2 = 'test_value2';

      await TempCache.saveData(key1, value1);
      await TempCache.saveData(key2, value2);
      await TempCache.clearAll();
      final result1 = TempCache.readData<String>(key1);
      final result2 = TempCache.readData<String>(key2);

      expect(result1, isNull);
      expect(result2, isNull);
    });
  });
}
