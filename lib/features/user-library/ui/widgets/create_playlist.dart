import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/input_field.dart';

class CreatePlaylistPage extends StatefulWidget {
  const CreatePlaylistPage({super.key});

  @override
  State<CreatePlaylistPage> createState() => _CreatePlaylistPageState();
}

class _CreatePlaylistPageState extends State<CreatePlaylistPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final state = context.read<SessionCubit>().state;
    final index =
        state is Authenticated ? state.userData.customPlaylistIndex : 1;
    final text = 'My playlist #${index + 1}';

    _controller = TextEditingController()
      ..text = text
      ..selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade700,
              Colors.grey.shade800,
              Colors.grey.shade900,
            ],
          ),
        ),
        child: SizedBox(
          width: context.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              children: [
                const Spacer(flex: 4),
                Text(
                  'Give your playlist a name',
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                InputFormField(
                  controller: _controller,
                  decoration: const InputDecoration(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    context.pop(value);
                  },
                ),
                const Spacer(),
                FilledButton.tonal(
                  onPressed: () => context.pop(_controller.text),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 36,
                    ),
                  ),
                  child: Text(
                    'Create',
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
