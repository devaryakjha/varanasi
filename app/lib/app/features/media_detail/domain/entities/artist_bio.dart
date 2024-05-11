// type Bio struct {
// 	Sequence int    `json:"sequence"`
// 	Text     string `json:"text"`
// 	Title    string `json:"title"`
// }

import 'package:equatable/equatable.dart';

class Bio extends Equatable {
  const Bio({required this.sequence, required this.text, required this.title});

  final int sequence;
  final String text;
  final String title;

  @override
  List<Object?> get props => [sequence, text, title];
}
