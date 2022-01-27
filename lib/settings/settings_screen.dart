import 'dart:io';

import 'package:avdan/home/home_screen.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/raxys_logo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donate_button.dart';
import 'language_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.watch<Store>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(store.localize('settings')),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const HomeScreen(),
          ),
        ),
        icon: const Icon(Icons.home_rounded),
        label: Text(store.localize('home')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              const RaxysLogo(
                opacity: .1,
                scale: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      store.localize('honor', false),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (!kIsWeb &&
                            (Platform.isAndroid /* || Platform.isIOS*/)) ...[
                          Expanded(
                            child: DonateButton(
                              label: Text(store.localize('support')),
                              iosProductId: 'com.alkaitagi.avdanapp.support',
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                launch('https://t.me/raxysstudios'),
                            icon: const Icon(Icons.send_rounded),
                            label: Text(store.localize('contact')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              store.localize('interface'),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            child: Column(
              children: [
                for (final l in store.languages.where((l) => l.interface))
                  LanguageTile(
                    l,
                    mode: store.interface == l
                        ? LanguageMode.main
                        : LanguageMode.none,
                    onTap: (alt) => store.interface = l,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              store.localize('learning'),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            child: Column(
              children: [
                for (final l in store.languages.where((l) => !l.interface))
                  LanguageTile(
                    l,
                    mode: store.learning == l
                        ? store.alt
                            ? LanguageMode.alt
                            : LanguageMode.main
                        : LanguageMode.none,
                    onTap: (mode) {
                      store.learning = l;
                      store.alt = mode == LanguageMode.alt;
                    },
                  ),
              ],
            ),
          ),
          Center(
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () => launch(
                  'https://github.com/raxysstudios/avdan',
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      var info = 'Loading...';
                      final package = snapshot.data;
                      if (package != null) {
                        info = [
                          'v' + package.version,
                          'b' + package.buildNumber
                        ].join(' • ');
                      }
                      return Text(
                        info,
                        style: Theme.of(context).textTheme.caption,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
