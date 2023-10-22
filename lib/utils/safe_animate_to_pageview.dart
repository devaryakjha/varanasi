import 'package:carousel_slider/carousel_controller.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

Future<void> animateToPage(int index, CarouselController? controller) async {
  try {
    if (controller == null || !controller.ready) return;
    await controller.animateToPage(index);
  } catch (e, stackTrace) {
    Logger.instance
        .e("Error while animating to page", error: e, stackTrace: stackTrace);
  }
}
