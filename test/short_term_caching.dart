import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:short_term_caching/short_term_caching.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TempCache', () {
    late TempCache tempCache;

    setUp(() async {
      await Hive.initFlutter();
      tempCache = TempCache();
      await tempCache.init();
    });

    tearDown(() async {
      await tempCache.clearAll();
      await Hive.deleteBoxFromDisk('TempCache');
      Hive.close();
    });

    test('saveData and readData', () async {
      const key = 'test_key';
      const value = 'test_value';

      await tempCache.saveData(key, value);
      final result = tempCache.readData<String>(key);

      expect(result, equals(value));
    });

    test('removeData', () async {
      const key = 'test_key';
      const value = 'test_value';

      await tempCache.saveData(key, value);
      await tempCache.removeData(key);
      final result = tempCache.readData<String>(key);

      expect(result, isNull);
    });

    test('clearAll', () async {
      const key1 = 'test_key1';
      const value1 = 'test_value1';
      const key2 = 'test_key2';
      const value2 = 'test_value2';

      await tempCache.saveData(key1, value1);
      await tempCache.saveData(key2, value2);
      await tempCache.clearAll();
      final result1 = tempCache.readData<String>(key1);
      final result2 = tempCache.readData<String>(key2);

      expect(result1, isNull);
      expect(result2, isNull);
    });
  });
}
