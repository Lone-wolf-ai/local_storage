import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TempCache {
  static final TempCache _instance = TempCache._internal();

  factory TempCache() {
    return _instance;
  }

  TempCache._internal();

  late Box _storage;

  // initialize hive
  Future<void> init() async {
    await Hive.initFlutter();
    _storage = await Hive.openBox('TempCache');
  }

  // generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.put(key, value);
  }

  // generic method to read data
  T? readData<T>(String key) {
    return _storage.get(key);
  }

  // generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.delete(key);
  }

  // clear all data in storage
  Future<void> clearAll() async {
    await _storage.clear();
  }
}
