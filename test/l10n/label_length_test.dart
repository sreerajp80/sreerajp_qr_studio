import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart' show StringCharacters;
import 'package:flutter_test/flutter_test.dart';

/// Keys with these prefixes are UI chrome and must stay short
/// (engineering standard §8.6).
const List<String> shortPrefixes = [
  'action',
  'label',
  'title',
  'tab',
  'nav',
  'tooltip',
];

/// Visible-character limit per language: 20 for Latin script (§8.6),
/// 22 for Malayalam and Sanskrit (language pack §5).
const Map<String, int> limits = {'en': 20, 'ml': 22, 'sa': 22};

void main() {
  for (final entry in limits.entries) {
    final locale = entry.key;
    final limit = entry.value;

    test('short labels in app_$locale.arb fit within $limit characters', () {
      final arb = jsonDecode(
        File('lib/l10n/app_$locale.arb').readAsStringSync(),
      ) as Map<String, dynamic>;
      final problems = <String>[];
      for (final MapEntry(:key, :value) in arb.entries) {
        if (key.startsWith('@')) continue;
        if (!shortPrefixes.any(key.startsWith)) continue;
        for (final text in visibleForms(value.toString())) {
          final length = text.characters.length;
          if (length > limit) {
            problems.add('$key ($length): $text');
          }
        }
      }
      expect(problems, isEmpty, reason: problems.join('\n'));
    });
  }
}

/// The texts a user can see for one ARB value: the value itself, or, for an
/// ICU `plural` / `select` message, each branch on its own (a branch like
/// `other{Show {count} passed}` is checked as `Show {count} passed`).
List<String> visibleForms(String value) {
  final icu = RegExp(r'^\{\w+,\s*(plural|select),');
  if (!icu.hasMatch(value)) return [value];
  final forms = <String>[];
  final branch = RegExp(r'(?:=\d+|[a-zA-Z]+)\{((?:[^{}]|\{[^{}]*\})*)\}');
  for (final match in branch.allMatches(value)) {
    forms.add(match.group(1)!);
  }
  return forms.isEmpty ? [value] : forms;
}
