import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/domain/entities/page.dart';

class MediaAppBar extends StatefulWidget {
  const MediaAppBar({
    required this.title,
    required this.id,
    required this.image,
    required this.pages,
    super.key,
  });

  final String title;
  final String id;
  final String image;
  final List<Page> pages;

  @override
  State<MediaAppBar> createState() => _MediaAppBarState();
}

class _MediaAppBarState extends State<MediaAppBar> {
  late final ImageProvider _imageProvider;
  PaletteGenerator? _palette;
  Color? _bg;
  Color? _fg;
  SystemUiOverlayStyle? _systemOverlayStyle;

  void _loadImage() {
    _imageProvider = CachedNetworkImageProvider(widget.image);
    setState(() {});
    _loadPalette();
  }

  Future<void> _loadPalette() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _palette = await PaletteGenerator.fromImageProvider(_imageProvider);
      final paletteColor = _palette?.darkMutedColor ??
          _palette?.mutedColor ??
          _palette?.dominantColor;
      _bg = paletteColor?.color;
      _fg = paletteColor?.titleTextColor.withOpacity(1);
      final isLight = (_fg?.computeLuminance() ?? 0.0) > 0.5;
      _systemOverlayStyle =
          !isLight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverStack(
          insetOnOverlap: true,
          children: [
            SliverAppBar(
              systemOverlayStyle: _systemOverlayStyle,
              stretch: true,
              expandedHeight: 300,
              pinned: true,
              scrolledUnderElevation: 10,
              backgroundColor: _bg,
              foregroundColor: _fg,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.title,
                  style: TextStyle(color: _fg),
                ),
                centerTitle: false,
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Hero(
                  tag: widget.id,
                  transitionOnUserGestures: true,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                    child: Image(
                      image: _imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverPositioned(
              right: 16,
              bottom: -24,
              child: FloatingActionButton(
                backgroundColor: _bg,
                foregroundColor: _fg,
                onPressed: () {},
                child: const Icon(Icons.play_arrow),
              ),
            ),
          ],
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            TabBar(
              tabs: widget.pages.map((e) => Tab(text: e.title)).toList(),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelColor: _fg,
              unselectedLabelColor: _fg?.withOpacity(0.5),
              indicatorColor: _fg,
            ),
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate._tabBar.labelColor != _tabBar.labelColor;
  }
}
