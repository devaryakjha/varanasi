import 'package:flex_color_scheme/flex_color_scheme.dart';

extension ExtendedFlexScheme on FlexScheme {
  String get describeScheme {
    return switch (this) {
      FlexScheme.material => 'Material',
      FlexScheme.materialHc => 'Material HC',
      FlexScheme.blue => 'Blue',
      FlexScheme.indigo => 'Indigo',
      FlexScheme.hippieBlue => 'Hippie Blue',
      FlexScheme.aquaBlue => 'Aqua Blue',
      FlexScheme.brandBlue => 'Brand Blue',
      FlexScheme.deepBlue => 'Deep Blue',
      FlexScheme.sakura => 'Sakura',
      FlexScheme.mandyRed => 'Mandy Red',
      FlexScheme.red => 'Red',
      FlexScheme.redWine => 'Red Wine',
      FlexScheme.purpleBrown => 'Purple Brown',
      FlexScheme.green => 'Green',
      FlexScheme.money => 'Money',
      FlexScheme.jungle => 'Jungle',
      FlexScheme.greyLaw => 'Grey Law',
      FlexScheme.wasabi => 'Wasabi',
      FlexScheme.gold => 'Gold',
      FlexScheme.mango => 'Mango',
      FlexScheme.amber => 'Amber',
      FlexScheme.vesuviusBurn => 'Vesuvius Burn',
      FlexScheme.deepPurple => 'Deep Purple',
      FlexScheme.ebonyClay => 'Ebony Clay',
      FlexScheme.barossa => 'Barossa',
      FlexScheme.shark => 'Shark',
      FlexScheme.bigStone => 'Big Stone',
      FlexScheme.damask => 'Damask',
      FlexScheme.bahamaBlue => 'Bahama Blue',
      FlexScheme.mallardGreen => 'Mallard Green',
      FlexScheme.espresso => 'Espresso',
      FlexScheme.outerSpace => 'Outer Space',
      FlexScheme.blueWhale => 'Blue Whale',
      FlexScheme.sanJuanBlue => 'San Juan Blue',
      FlexScheme.rosewood => 'Rosewood',
      FlexScheme.blumineBlue => 'Blumine Blue',
      FlexScheme.flutterDash => 'Flutter Dash',
      FlexScheme.materialBaseline => 'Material Baseline',
      FlexScheme.verdunHemlock => 'Verdun Hemlock',
      FlexScheme.dellGenoa => 'Dell Genoa',
      FlexScheme.redM3 => 'Red M3',
      FlexScheme.pinkM3 => 'Pink M3',
      FlexScheme.purpleM3 => 'Purple M3',
      FlexScheme.indigoM3 => 'Indigo M3',
      FlexScheme.blueM3 => 'Blue M3',
      FlexScheme.cyanM3 => 'Cyan M3',
      FlexScheme.tealM3 => 'Teal M3',
      FlexScheme.greenM3 => 'Green M3',
      FlexScheme.limeM3 => 'Lime M3',
      FlexScheme.yellowM3 => 'Yellow M3',
      FlexScheme.orangeM3 => 'Orange M3',
      FlexScheme.deepOrangeM3 => 'Deep Orange M3',
      FlexScheme.custom => 'Custom',
    };
  }

  String get description {
    return switch (this) {
      FlexScheme.material =>
        "The example theme used in the Material Design guide.",
      FlexScheme.materialHc => "Material high contrast theme.",
      FlexScheme.blue => "Material blue and Material light blue based theme.",
      FlexScheme.indigo =>
        "Material indigo and Material deep purple based theme.",
      FlexScheme.hippieBlue => "Hippie blue with surfie green and chock pink.",
      FlexScheme.aquaBlue => "Aqua tropical blue ocean theme.",
      FlexScheme.brandBlue =>
        "Blue theme composed of well known blue brand colors.",
      FlexScheme.deepBlue => "Deep blue dark abyss theme.",
      FlexScheme.sakura => "Pink sakura cherry blossom inspired theme.",
      FlexScheme.mandyRed => "Mandy red color and viking blue inspired theme.",
      FlexScheme.red => "Material red and Material pink theme.",
      FlexScheme.redWine => "Red wine inspired theme.",
      FlexScheme.purpleBrown =>
        "Purple brown, aubergine and eggplant inspired theme.",
      FlexScheme.green =>
        "Material green forest and Material teal based theme.",
      FlexScheme.money =>
        "Green money theme, as in \"show me the money theme\".",
      FlexScheme.jungle => "Lush green jungle inspired theme.",
      FlexScheme.greyLaw =>
        "Somber Material blue-grey and legal purple and grey theme.",
      FlexScheme.wasabi =>
        "Wild willow and wasabi green with orchid purple inspired theme.",
      FlexScheme.gold => "Gold sunset inspired theme.",
      FlexScheme.mango => "Playful mango mojito theme.",
      FlexScheme.amber => "Material amber and blue accent based theme.",
      FlexScheme.vesuviusBurn =>
        "Vesuvius burned orange and eden green based theme.",
      FlexScheme.deepPurple => "Deep purple, daisy bush theme.",
      FlexScheme.ebonyClay =>
        "Ebony clay deep blue grey and watercourse green theme.",
      FlexScheme.barossa => "Barossa red and cardin green theme.",
      FlexScheme.shark => "Shark grey and orange ecstasy theme.",
      FlexScheme.bigStone => "Big stone blue and tulip tree yellow theme.",
      FlexScheme.damask => "Damask red and lunar green theme.",
      FlexScheme.bahamaBlue => "Bahama blue and trinidad orange.",
      FlexScheme.mallardGreen => "Mallard green and valencia pink.",
      FlexScheme.espresso => "Espresso and crema theme.",
      FlexScheme.outerSpace => "Outer space and red stage theme.",
      FlexScheme.blueWhale =>
        "Blue whale, jungle green and outrageous tango orange theme.",
      FlexScheme.sanJuanBlue => "San Juan blue and salmon pink theme.",
      FlexScheme.rosewood =>
        "Rosewood red, with horses neck and driftwood theme.",
      FlexScheme.blumineBlue =>
        "Blumine blumine blue green color, eastern blue, with saffron mango and mulled wine theme.",
      FlexScheme.flutterDash =>
        "A color scheme based on the Flutter Dash mascot 4k wallpaper shared by Google before the launch of Flutter 2.10.",
      FlexScheme.materialBaseline =>
        "The Material 3 color scheme baseline for primary, secondary and tertiary colors, used as an example in in the Material 3 design guide.",
      FlexScheme.verdunHemlock =>
        "A verdun and mineral green with hemlock grey-greens color scheme set found in an image in the Material 3 design guide here.",
      FlexScheme.dellGenoa =>
        "A dell, axolotl and genoa greens color scheme set found in an image in the Material 3 design guide here.",
      FlexScheme.redM3 => "A red based Material-3 colorscheme.",
      FlexScheme.pinkM3 => "A pink based Material-3 colorscheme.",
      FlexScheme.purpleM3 => "A purple based Material-3 colorscheme.",
      FlexScheme.indigoM3 =>
        "An indigo based Material-3 colorscheme, with old lavender tertiary.",
      FlexScheme.blueM3 => "A blue based Material-3 colorscheme.",
      FlexScheme.cyanM3 => "A cyan based Material-3 colorscheme.",
      FlexScheme.tealM3 =>
        "A teal based Material-3 colorscheme, with azure blue tertiary.",
      FlexScheme.greenM3 =>
        "A green based Material-3 colorscheme, with william blue-grey tertiary.",
      FlexScheme.limeM3 => "A lime based Material-3 colorscheme.",
      FlexScheme.yellowM3 =>
        "A Yukon Gold based Material-3 colorscheme, with mineral green tertiary.",
      FlexScheme.orangeM3 =>
        "An orange based Material-3 colorscheme, with verdigris green tertiary.",
      FlexScheme.deepOrangeM3 => "A deep orange based Material-3 colorscheme.",
      FlexScheme.custom =>
        "Placeholder for adding a custom scheme. When this scheme is selected you should provide a [FlexColorScheme] based on a custom [FlexSchemeData] object. If not provided, it defaults to the [FlexScheme.material] theme.",
    };
  }
}
