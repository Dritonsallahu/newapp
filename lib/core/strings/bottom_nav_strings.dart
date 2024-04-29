import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<String> navStrings(context) => [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.discover,
      AppLocalizations.of(context)!.saved,
      AppLocalizations.of(context)!.profile,
    ];

const navIconsNames = [
  'home-simple.svg',
  'discover-1.svg',
  'book-saved.svg',
  'profile.svg'
];
