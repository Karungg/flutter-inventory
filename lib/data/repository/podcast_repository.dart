import 'package:inventory/DI/service_locator.dart';
import 'package:inventory/data/datasource/podcast_datasource.dart';
import 'package:inventory/data/model/podcast.dart';

abstract class PodcastRepository {
  Future<List<Podcast>> getPodcastList();
}

class PodcastLocalRepository extends PodcastRepository {
  final PodcastDatasource _datasource = locator.get();
  @override
  Future<List<Podcast>> getPodcastList() async {
    return await _datasource.getPodcastList();
  }
}
