import 'package:logger/logger.dart' hide Logger;
import 'package:logger/logger.dart' as logger;

final printer = SimplePrinter(colors: false);

class Logger extends logger.Logger {
  Logger._() : super(printer: printer);

  static Logger get instance => Logger._();
}
