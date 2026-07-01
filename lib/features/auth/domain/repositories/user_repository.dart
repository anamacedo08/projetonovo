import '../../../../core/database/base_repository.dart';

class UserRepository extends BaseRepository {
  UserRepository() : super('users');

  Future<Map<String, dynamic>?> findByEmail(String email) async {
    final results = await query(where: 'email = ?', whereArgs: [email]);
    return results.isNotEmpty ? results.first : null;
  }
}
