import 'package:demo_traffic_light/h2o_lifecycle/model/events/h2o_events.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state/h2o_state.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state_machine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fsm2/fsm2.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockStateMachine extends Mock implements StateMachine {}

void main() {
  late H2OStateMachine stateMachine;

  setUp(() {
    stateMachine = H2OStateMachine();
  });

  group('H2OStateMachine initialization', () {
    test('should initialize with Solid state', () {
      // Assert
      expect(stateMachine.currentState, isA<Solid>());
    });

    test('should initialize state machine when init is called', () async {
      // Act
      await stateMachine.init();

      // Assert
      expect(stateMachine.currentState, isA<Solid>());
    });
  });

  group('H2OStateMachine state transitions', () {
    setUp(() async {
      // Initialize the state machine before each test
      await stateMachine.init();
    });

    test('should transition from Solid to Liquid when MeltEvent with valid temperature is applied', () async {
      // Arrange
      final event = MeltEvent(temperature: 10); // Temperature above 0°C

      // Act
      stateMachine.applyEvent(event);
      
      // Wait for async operations to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(stateMachine.currentState, isA<Liquid>());
    });

    test('should not transition from Solid to Liquid when MeltEvent with invalid temperature is applied', () async {
      // Arrange
      final event = MeltEvent(temperature: -10); // Temperature below 0°C

      // Act
      // This should throw an exception, but it's caught internally
      stateMachine.applyEvent(event);
      
      // Wait for async operations to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - state should remain Solid
      expect(stateMachine.currentState, isA<Solid>());
    });

    test('should transition from Liquid to Gas when VaporizeEvent with valid temperature is applied', () async {
      // Arrange - first transition to Liquid
      stateMachine.applyEvent(MeltEvent(temperature: 10));
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Act - then try to transition to Gas
      stateMachine.applyEvent(VaporizeEvent(temperature: 110)); // Temperature above 100°C
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(stateMachine.currentState, isA<Gas>());
    });

    test('should transition from Gas to Liquid when CondenseEvent with valid temperature is applied', () async {
      // Arrange - first transition to Liquid then to Gas
      stateMachine.applyEvent(MeltEvent(temperature: 10));
      await Future.delayed(const Duration(milliseconds: 100));
      stateMachine.applyEvent(VaporizeEvent(temperature: 110));
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Act - then try to transition back to Liquid
      stateMachine.applyEvent(CondenseEvent(temperature: 90)); // Temperature below 100°C
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(stateMachine.currentState, isA<Liquid>());
    });

    test('should transition from Liquid to Solid when FreezeEvent with valid temperature is applied', () async {
      // Arrange - first transition to Liquid
      stateMachine.applyEvent(MeltEvent(temperature: 10));
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Act - then try to transition back to Solid
      stateMachine.applyEvent(FreezeEvent(temperature: -5)); // Temperature below 0°C
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(stateMachine.currentState, isA<Solid>());
    });
  });

  group('H2OStateMachine state change notifications', () {
    setUp(() async {
      await stateMachine.init();
    });

    test('should emit state change when transitioning states', () async {
      // Arrange
      final states = <H2OState>[];
      final subscription = stateMachine.stateChanges.listen(states.add);
      
      // Act
      stateMachine.applyEvent(MeltEvent(temperature: 10));
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Clean up
      await subscription.cancel();
      
      // Assert
      expect(states.length, 1);
      expect(states.first, isA<Liquid>());
    });
  });
}
