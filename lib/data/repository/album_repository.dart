import 'package:inventory/DI/service_locator.dart';
import 'package:inventory/data/datasource/album_datasource.dart';
import 'package:inventory/data/model/album.dart';

abstract class AlbumRepository {
  Future<Album> albumList(String singer);
}

class AlbumLocalRepository extends AlbumRepository {
  final AlbumDatasource _albumLocalDatasource = locator.get();
  @override
  Future<Album> albumList(String singer) async {
    return await _albumLocalDatasource.albumList(singer);
  }
}
