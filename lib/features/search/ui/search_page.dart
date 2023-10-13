import 'package:flutter/cupertino.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/slivers/custom_sliver_delegate.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderDelegate(padding: padding),
          ),
          SliverList.builder(
            itemBuilder: (ctx, idx) => CupertinoListTile.notched(
              leading: Text(
                "${idx + 1}",
                style: context.textTheme.titleLarge,
              ),
              title: Text(
                "Placeholder",
                style: context.textTheme.titleLarge,
              ),
              subtitle: Text(
                "Placeholder",
                style: context.textTheme.bodyMedium,
              ),
            ),
            itemCount: 1000,
          )
        ],
      ),
    );
  }
}
