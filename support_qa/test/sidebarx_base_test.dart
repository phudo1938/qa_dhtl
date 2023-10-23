import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:support_qa/sidebarx.dart';

import 'test_sidebarx_widget.dart';

void main() {
  group('SidebarX', () {
    testWidgets('Default build test', (tester) async {
      await _pumpDedaultTextWidget(tester);
      final homeFinder = find.text('TRANG CHỦ');
      final searchFinder = find.text('Chat Q&A');

      expect(homeFinder, findsOneWidget);
      expect(searchFinder, findsOneWidget);
    });

    testWidgets('Select item', (tester) async {
      final controller = await _pumpDedaultTextWidget(tester);

      final searchFinder = find.text('Chat Q&A');
      final homeFinder = find.text('TRANG CHỦ');

      expect(homeFinder, findsOneWidget);
      expect(searchFinder, findsOneWidget);

      await tester.tap(searchFinder);
      await tester.pump();
      expect(controller.selectedIndex, 1);

      await tester.tap(homeFinder);
      await tester.pump();
      expect(controller.selectedIndex, 0);
    });

    testWidgets('Toggle button tap', (tester) async {
      final controller = SidebarXController(selectedIndex: 0, extended: false);
      await tester.pumpWidget(
        TestSidebarX(
          animationDuration: Duration.zero,
          controller: controller,
          items: const [
            SidebarXItem(icon: Icons.home, label: 'TRANG CHỦ'),
            SidebarXItem(icon: Icons.message, label: 'CHAT Q&A'),
          ],
        ),
      );

      final toggleButtonFinder =
          find.byKey(const Key('sidebarx_toggle_button'));
      expect(toggleButtonFinder, findsOneWidget);

      await tester.tap(toggleButtonFinder);
      await tester.pump();
      expect(controller.extended, true);

      await tester.tap(toggleButtonFinder);
      await tester.pump();
      expect(controller.extended, false);
    });
  });
}

Future<SidebarXController> _pumpDedaultTextWidget(WidgetTester tester) async {
  final controller = SidebarXController(selectedIndex: 0);
  await tester.pumpWidget(
    TestSidebarX(
      controller: controller,
      items: const [
        SidebarXItem(icon: Icons.home, label: 'TRANG CHỦ'),
        SidebarXItem(icon: Icons.message, label: 'CHAT Q&A'),
      ],
    ),
  );
  return controller;
}
