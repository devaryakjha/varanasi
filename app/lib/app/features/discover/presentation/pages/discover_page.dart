import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi/app/features/discover/domain/entities/discovery_data.dart';
import 'package:varanasi/app/features/features.dart';
import 'package:varanasi/app/shared/shared.dart';
import 'package:varanasi/app/shared/widgets/block_view.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const DashboardAppbar(),
        BlocSelector<DiscoverCubit, DiscoverState, DiscoveryData>(
          selector: (state) => state.discoveryData,
          builder: (context, state) {
            return SliverList.builder(
              itemCount: state.blocks.length,
              itemBuilder: (context, index) {
                final block = state.blocks[index];
                return BlockView(block: block);
              },
            );
          },
        ),
      ],
    );
  }
}
