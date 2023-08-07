import 'package:logger/logger.dart' as logger;

class Logger extends logger.Logger {
  Logger._()
      : super(
          printer: logger.PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 8,
            printTime: true,
            colors: true,
          ),
        );

  static Logger get instance => Logger._();
}
