import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
          child: Text(
            "هذا التطبيق مازال تحت الانشاء لذلك اذا واجهتك اى مشكله يرجى التوصل معنا",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Marhey",
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            iconButtom(
              context,
              "https://wa.me/message/V5I4VRHT5N7JH1?src=qr",
              FontAwesomeIcons.whatsapp,
            ),
            iconButtom(
              context,
              "https://m.me/momen.salah.503",
              FontAwesomeIcons.facebookMessenger,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            iconButtom(
              context,
              "https://t.me/+201114613845",
              FontAwesomeIcons.telegram,
            ),
            iconButtom(
              context,
              "https://discord.com/channels/880077984273412136/880077984860618855",
              FontAwesomeIcons.discord,
              iconSize: 40,
            ),
          ]),
        ]),
        const SizedBox(),
      ]),
    );
  }

  Padding iconButtom(BuildContext context, String web, IconData icon,
      {double iconSize = 50}) {
    return Padding(
      padding: const EdgeInsets.all(12.5),
      child: IconButton(
        onPressed: () async {
          Uri url = Uri(path: web);
          var urllaunchable = await canLaunchUrl(url);
          if (urllaunchable) {
            await launchUrl(url);
          } else {
            null;
          }
        },
        iconSize: iconSize,
        icon: Icon(icon),
        color: Colors.white,
      ),
    );
  }
}
