part of 'test_bloc.dart';


abstract class TestEvent {
  const TestEvent();
}

class OnACUsageChanged extends TestEvent {
  final num acUsage;
  OnACUsageChanged(this.acUsage);
}

class OnRoomUsageChanged extends TestEvent {
  final num roomUsage;
  OnRoomUsageChanged(this.roomUsage);
}

class OnOtherUsageChanged extends TestEvent {
  final num otherUsage;
  OnOtherUsageChanged(this.otherUsage);
}

class OnAnnualUsageChanged extends TestEvent {
  final num annualUsage;
  OnAnnualUsageChanged(this.annualUsage);
}