import 'package:url_launcher/url_launcher.dart';

const String adminEmail = "admin@gmail.com";

const defaultImageConstant = "Select Image";

const baseUrl = "http://159.89.98.34:5545/";
const baseUrlImage = "http://159.89.98.34:5545";


class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

const String token = "";


class StatusTextConstants {
  static String websiteAdd = "website_add";
  static String gotAllWebsite = "got_all_website";
  static String gotWebsiteById = "got_website_by_id";
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}