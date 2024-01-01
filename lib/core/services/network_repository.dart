
abstract class BaseRepository {
  Future<dynamic> get(String endpoint);
  Future<dynamic> post(String endpoint, dynamic body);
  Future<dynamic> put(String endpoint, dynamic body);
  Future<dynamic> delete(String endpoint);
}

