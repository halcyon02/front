import 'package:flutter/material.dart';
import 'drawer_item_screen.dart';

class _Item {
  final String title;
  final IconData icon;
  const _Item(this.title, this.icon);
}

const _items = [
  _Item('Braille Guide', Icons.menu_book),
  _Item('학습 기록', Icons.history),
  _Item('오늘의 도전', Icons.emoji_events_outlined),
  _Item('앱 정보', Icons.info_outline),
];

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFECF4FF), Color(0xFFFFFFFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                'PuzzleDot',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                itemCount: _items.length,
                itemBuilder: (context, i) {
                  final item = _items[i];
                  final sel = _selected == i;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: sel
                          ? const Color(0xFF1D4ED8)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: Icon(
                        item.icon,
                        color: sel
                            ? Colors.white
                            : const Color(0xFF64748B),
                        size: 22,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              sel ? FontWeight.w700 : FontWeight.w500,
                          color: sel
                              ? Colors.white
                              : const Color(0xFF0F172A),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      onTap: () {
                        setState(() => _selected = i);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DrawerItemScreen(title: item.title),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}