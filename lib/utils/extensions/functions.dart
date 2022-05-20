import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

launchInBrowser(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

void permissionHandler() async {
  final status = await Permission.storage.status;
  const statusManageStorage = Permission.manageExternalStorage;
  if (status.isDenied ||
      !status.isGranted ||
      !await statusManageStorage.isGranted) {
    await [
      Permission.storage,
      Permission.mediaLibrary,
      Permission.requestInstallPackages,
      Permission.manageExternalStorage,
    ].request();
  }
}
