import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/l10n/fallback_localizations.dart';

import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Framework fallback delegates', () {
    test('cover exactly the fallback languages', () {
      expect(kFrameworkFallbackLanguages, {'sa'});
      expect(kFrameworkFallbackLocale, const Locale('en'));
    });

    test('FallbackMaterialLocalizationsDelegate supports sa only', () {
      const delegate = FallbackMaterialLocalizationsDelegate();
      expect(delegate.isSupported(const Locale('sa')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isFalse);
      expect(delegate.isSupported(const Locale('ml')), isFalse);
    });

    test('FallbackCupertinoLocalizationsDelegate supports sa only', () {
      const delegate = FallbackCupertinoLocalizationsDelegate();
      expect(delegate.isSupported(const Locale('sa')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isFalse);
    });

    test('FallbackWidgetsLocalizationsDelegate supports sa only', () {
      const delegate = FallbackWidgetsLocalizationsDelegate();
      expect(delegate.isSupported(const Locale('sa')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isFalse);
    });

    test('Material strings load for sa', () async {
      const delegate = FallbackMaterialLocalizationsDelegate();
      final localizations = await delegate.load(const Locale('sa'));

      expect(localizations.okButtonLabel, isNotEmpty);
      expect(localizations.cancelButtonLabel, isNotEmpty);
      expect(localizations.closeButtonLabel, isNotEmpty);
      expect(localizations.copyButtonLabel, isNotEmpty);
    });

    test('Cupertino strings load for sa', () async {
      const delegate = FallbackCupertinoLocalizationsDelegate();
      final localizations = await delegate.load(const Locale('sa'));

      expect(localizations.copyButtonLabel, isNotEmpty);
      expect(localizations.selectAllButtonLabel, isNotEmpty);
    });
  });

  testWidgets('a date picker and a dialog open under sa without errors', (
    tester,
  ) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      buildTestApp(
        locale: const Locale('sa'),
        home: Builder(
          builder: (context) {
            ctx = context;
            return const Scaffold();
          },
        ),
      ),
    );

    final picked = showDatePicker(
      context: ctx,
      initialDate: DateTime(2026, 10, 12),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(DatePickerDialog), findsOneWidget);
    Navigator.of(ctx).pop();
    await tester.pumpAndSettle();
    expect(await picked, isNull);

    final dialog = showDialog<void>(
      context: ctx,
      builder: (context) => AlertDialog(
        content: const SizedBox.shrink(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
    await dialog;
    expect(tester.takeException(), isNull);
  });
}
