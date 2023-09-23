import 'package:carousel_slider/carousel_controller.dart';

void animateToPage(int index, CarouselController? controller) {
  if (controller == null || !controller.ready) return;
  controller.animateToPage(index);
}
