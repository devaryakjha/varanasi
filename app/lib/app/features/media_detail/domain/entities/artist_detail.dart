import 'package:equatable/equatable.dart';
import 'package:varanasi/app/features/media_detail/domain/entities/artist_bio.dart';
import 'package:varanasi/app/shared/domain/entities/page.dart';

class ArtistDetails extends Equatable {
  const ArtistDetails({
    required this.name,
    required this.id,
    required this.pages,
    required this.bio,
  });

  const ArtistDetails.empty()
      : name = '',
        id = '',
        pages = const [],
        bio = const [];

  final String name;
  final String id;
  final List<Page> pages;
  final List<Bio> bio;

  bool get isEmpty => name.isEmpty;

  @override
  List<Object?> get props => [name, id, pages, bio];
}
