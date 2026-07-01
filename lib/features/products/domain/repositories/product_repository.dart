import '../../../../core/database/base_repository.dart';

class ProductRepository extends BaseRepository {
  ProductRepository() : super('products');

  static List<Map<String, dynamic>>? _cachedVitrine;

  Future<List<Map<String, dynamic>>> getVitrine() async {
    if (_cachedVitrine != null) return _cachedVitrine!;
    
    final results = await query(where: 'excluido = 0', limit: 3);
    _cachedVitrine = results;
    return results;
  }

  void clearCache() {
    _cachedVitrine = null;
  }

  @override
  Future<int> insert(Map<String, dynamic> data) async {
    final id = await super.insert(data);
    clearCache();
    return id;
  }

  @override
  Future<int> update(Map<String, dynamic> data, {String? where, List<Object?>? whereArgs}) async {
    final count = await super.update(data, where: where, whereArgs: whereArgs);
    clearCache();
    return count;
  }
}
