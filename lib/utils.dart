import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<DropdownMenuItem<String>> countryDropdownItems() {
  List<DropdownMenuItem<String>> list = [];
  for (final i in lCountry) {
    list.add(DropdownMenuItem(
      value: i,
      child: Text(i),
    ));
  }
  return list;
}

List<DropdownMenuItem<String>> categoryDropdownItems() {
  List<DropdownMenuItem<String>> list = [];
  for (final i in lCategory) {
    list.add(DropdownMenuItem(
      value: i,
      child: Text(i),
    ));
  }
  return list;
}

Future<void> viewUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception("Could not launch $url");
  }
}

// Map<String, String> categoryMap = {
//   'business': 'Business',
//   'entertainment': 'Entertainment',
//   'general': 'General',
//   'health': 'Health',
//   'science': 'Science',
//   'sports': 'Sports',
//   'technology': 'Technology'
// };

List<String> lCategory = [
  'Business',
  'Entertainment',
  'General',
  'Health',
  'Science',
  'Sports',
  'Technology'
];
List<String> lCountry = [
  'UAE',
  'Argentina',
  'Austria',
  'Australia',
  'Belgium',
  'Bulgaria',
  'Brazil',
  'Canada',
  'Switzerland',
  'China',
  'Colombia',
  'Cuba',
  'Czech Republic',
  'Germany',
  'Egypt',
  'France',
  'United Kingdom',
  'Greece',
  'Hong Kong',
  'Hungary',
  'Indonesia',
  'Ireland',
  'Israel',
  'India',
  'Italy',
  'Japan',
  'South Korea',
  'Lithuania',
  'Latvia',
  'Morocco',
  'Mexico',
  'Malaysia',
  'Nigeria',
  'Netherlands',
  'Norway',
  'New Zealand',
  'Philippines',
  'Poland',
  'Portugal',
  'Romania',
  'Serbia',
  'Russia',
  'Saudi Arabia',
  'Sweden',
  'Singapore',
  'Slovenia',
  'Slovakia',
  'Thailand',
  'Turkey',
  'Taiwan',
  'Ukraine',
  'USA',
  'Venezuela',
  'South Africa',
];
Map<String, String> countryMap = {
  'UAE': 'ae',
  'Argentina': 'ar',
  'Austria': 'at',
  'Australia': 'au',
  'Belgium': 'be',
  'Bulgaria': 'bg',
  'Brazil': 'br',
  'Canada': 'ca',
  'Switzerland': 'ch',
  'China': 'cn',
  'Colombia': 'co',
  'Cuba': 'cu',
  'Czech Republic': 'cz',
  'Germany': 'de',
  'Egypt': 'eg',
  'France': 'fr',
  'United Kingdom': 'gb',
  'Greece': 'gr',
  'Hong Kong': 'hk',
  'Hungary': 'hu',
  'Indonesia': 'id',
  'Ireland': 'ie',
  'Israel': 'il',
  'India': 'in',
  'Italy': 'it',
  'Japan': 'jp',
  'South Korea': 'kr',
  'Lithuania': 'lt',
  'Latvia': 'lv',
  'Morocco': 'ma',
  'Mexico': 'mx',
  'Malaysia': 'my',
  'Nigeria': 'ng',
  'Netherlands': 'nl',
  'Norway': 'no',
  'New Zealand': 'nz',
  'Philippines': 'ph',
  'Poland': 'pl',
  'Portugal': 'pt',
  'Romania': 'ro',
  'Serbia': 'rs',
  'Russia': 'ru',
  'Saudi Arabia': 'sa',
  'Sweden': 'se',
  'Singapore': 'sg',
  'Slovenia': 'si',
  'Slovakia': 'sk',
  'Thailand': 'th',
  'Turkey': 'tr',
  'Taiwan': 'tw',
  'Ukraine': 'ua',
  'USA': 'us',
  'Venezuela': 've',
  'South Africa': 'za',
};
