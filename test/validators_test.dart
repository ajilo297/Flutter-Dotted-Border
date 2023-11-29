import 'package:dotted_border/src/enums.dart';
import 'package:dotted_border/src/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dash pattern validator', () {
    test(
      'returns nullDashPattern if dash pattern is null',
      () {
        final pattern = null;
        final result = Validators.validateDashPattern(pattern);
        expect(result, InvalidDashPatternResult.nullDashPattern);
      },
    );

    test(
      'returns emptyDashPattern if dash pattern is empty',
      () {
        final pattern = <double>[];
        final result = Validators.validateDashPattern(pattern);
        expect(result, InvalidDashPatternResult.emptyDashPattern);
      },
    );

    test(
      'returns negativeDashPattern if dash pattern has negative values',
      () {
        final pattern = <double>[-1.0, 0.0, 1.0];
        final result = Validators.validateDashPattern(pattern);
        expect(result, InvalidDashPatternResult.negativeDashPattern);
      },
    );

    test(
      'returns zeroDashPattern if dash pattern has all zeros',
      () {
        final pattern = <double>[0.0, 0.0, 0.0];
        final result = Validators.validateDashPattern(pattern);
        expect(result, InvalidDashPatternResult.zeroDashPattern);
      },
    );

    test(
      'returns null if dash pattern is valid',
      () {
        final pattern = <double>[1.0, 2.0, 3.0];
        final result = Validators.validateDashPattern(pattern);
        expect(result, null);
      },
    );
  });
}
