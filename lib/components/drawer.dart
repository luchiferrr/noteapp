import 'package:flutter/material.dart';
import 'package:noteapp/components/drawer_tile.dart';
import 'package:noteapp/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: Icon(Icons.edit),
          ),
          const SizedBox(
            height: 25,
          ),
          //notes tile
          DrawerTile(
              title: "Заметки",
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
              ),
          //setting tile
          DrawerTile(
              title: "Настройки",
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                ),
                );
              },
          ),
        ],
      ),
    );
  }
}