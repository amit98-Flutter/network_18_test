part of 'test_bloc.dart';

class TestState {
  final num acUsage;
  final num roomUsage;
  final num otherUsage;
  final num annualUsage;

  TestState({
    this.acUsage = 0,
    this.roomUsage = 0,
    this.otherUsage = 0,
    this.annualUsage = 0,
  });

  TestState copyWith({
    num? acUsage,
    num? roomUsage,
    num? otherUsage,
    num? annualUsage,
  }) {
    return TestState(
      acUsage: acUsage ?? this.acUsage,
      roomUsage: roomUsage ?? this.roomUsage,
      otherUsage: otherUsage ?? this.otherUsage,
      annualUsage: annualUsage ?? this.annualUsage,
    );
  }
}