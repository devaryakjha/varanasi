import 'package:common/common.dart';
import 'package:flutter/widgets.dart';

typedef StorageListenerBuilder<T> = Widget Function(
  BuildContext context,
  T? value,
  Future<void> Function(T value) updateValue,
);

class StorageListener<T> extends StatelessWidget {
  StorageListener({
    required this.builder,
    required this.listenableKey,
    super.key,
    Storage? storage,
    this.initialData,
    this.serializer,
  }) : storage = storage ?? Storage.instance;

  final StorageListenerBuilder<T> builder;
  final String listenableKey;
  final Storage storage;
  final T? initialData;
  final StorageSerializer<T>? serializer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: storage.watch<T>(
        listenableKey,
        initialData: initialData,
        serializer: serializer,
      ),
      builder: (context, snapshot) {
        return builder(
          context,
          snapshot.data,
          (value) {
            return storage.write(
              listenableKey,
              value,
              serializer: serializer,
            );
          },
        );
      },
      initialData: initialData,
    );
  }
}
