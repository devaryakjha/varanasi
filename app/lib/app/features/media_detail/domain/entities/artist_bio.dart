import 'package:common/common.dart';

class Bio extends Equatable {
  const Bio({required this.sequence, required this.text, required this.title});

  final int sequence;
  final String text;
  final String title;

  @override
  List<Object?> get props => [sequence, text, title];
}
