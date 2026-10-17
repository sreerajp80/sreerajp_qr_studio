import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';

class _Line {
  _Line(this.level, this.message, this.error, this.stackTrace);
  final LogLevel level;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
}

void main() {
  late List<_Line> lines;

  void capture({required bool verbose}) {
    lines = [];
    AppLogger.overrideForTesting(
      verbose: verbose,
      sink: (level, message, {error, stackTrace}) =>
          lines.add(_Line(level, message, error, stackTrace)),
    );
  }

  tearDown(AppLogger.resetForTesting);

  group('AppLogger outside verbose mode (prod)', () {
    test('drops trace and debug', () {
      capture(verbose: false);
      AppLogger.trace('t');
      AppLogger.debug('d');
      expect(lines, isEmpty);
    });

    test('keeps info, warning, error and fatal', () {
      capture(verbose: false);
      AppLogger.info('i');
      AppLogger.warning('w');
      AppLogger.error('e');
      AppLogger.fatal('f');
      expect(lines.map((l) => l.level), [
        LogLevel.info,
        LogLevel.warning,
        LogLevel.error,
        LogLevel.fatal,
      ]);
    });

    test('reduces the error to its type and drops the stack trace', () {
      capture(verbose: false);
      AppLogger.error(
        'Saving failed',
        error: const FormatException('secret scanned text'),
        stackTrace: StackTrace.current,
      );
      expect(lines.single.message, 'Saving failed');
      expect(lines.single.error, 'FormatException');
      expect(lines.single.stackTrace, isNull);
    });
  });

  group('AppLogger in verbose mode (dev)', () {
    test('prints every level with the full error and stack trace', () {
      capture(verbose: true);
      const error = FormatException('detail');
      final stack = StackTrace.current;
      AppLogger.trace('t');
      AppLogger.debug('d');
      AppLogger.error('e', error: error, stackTrace: stack);
      expect(lines, hasLength(3));
      expect(lines.last.error, same(error));
      expect(lines.last.stackTrace, same(stack));
    });
  });

  test('a failing sink never throws to the caller', () {
    AppLogger.overrideForTesting(
      verbose: true,
      sink: (level, message, {error, stackTrace}) => throw StateError('x'),
    );
    expect(() => AppLogger.error('e'), returnsNormally);
  });
}
