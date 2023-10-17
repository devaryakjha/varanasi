class AppStrings {
  static const String appName = 'Project Varanasi';
  static const String configBoxName = 'config';
  static const String commonCacheBoxName = 'project_varanasi_cache_box';
  static const String downloadBoxName = 'download_box';
  static const String downloadRecordsBoxName = 'download_records_box';
  static const String currentPlaylistCacheKey = 'current_playlist';
  static const String currentPlaylistIndexCacheKey = 'current_playlist_index';
  static const String currentPlaylistPositionKey = 'current_playlist_position';

  static const String topSearchesCacheKey = 'top_searches';

  static String searchResultsCacheKey(String query) =>
      'search_results_${Uri.encodeQueryComponent(query)}';
}
