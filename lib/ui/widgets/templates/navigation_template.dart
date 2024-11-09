import 'package:flutter/material.dart';

import '../../pages/chat/chat_page.dart';
import '../../pages/fee_calculator/fee_caluculator_page.dart';

class NavigationTemplate extends StatefulWidget {
  const NavigationTemplate({
    super.key,
  });

  @override
  State<NavigationTemplate> createState() => _NavigationTemplateState();
}

class _NavigationTemplateState extends State<NavigationTemplate> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.family_restroom),
            label: '入場',
          ),
          NavigationDestination(
            icon: Icon(Icons.face),
            label: 'チャット',
          ),
        ],
      ),
      body: _selectedIndex == 0 ? const FeeCalculatorPage() : const ChatPage(),
    );
  }
}
