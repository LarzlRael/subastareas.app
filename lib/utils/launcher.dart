part of 'utils.dart';

void launchURL(String url) async {
  final Uri toLaunch = Uri.parse(url);
  if (!await launchUrl(
    toLaunch,
    /* mode: LaunchMode.externalApplication, */
  )) {
    throw 'Could not launch $url';
  }
}
