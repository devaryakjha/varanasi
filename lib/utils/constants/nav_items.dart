import 'package:varanasi_mobile_app/gen/assets.gen.dart';

typedef NavItem = ({SvgGenImage icon, SvgGenImage activeIcon, String label});

typedef NavItems = List<NavItem>;

NavItems navItems = [
  (
    icon: Assets.icon.nav.home,
    activeIcon: Assets.icon.nav.homeSelected,
    label: 'Home'
  ),
  (
    icon: Assets.icon.nav.search,
    activeIcon: Assets.icon.nav.searchSelected,
    label: 'Search'
  ),
  (
    icon: Assets.icon.nav.library,
    activeIcon: Assets.icon.nav.librarySelected,
    label: 'Library'
  ),
];
