# FSM2 Library Best Practices

This document outlines best practices for using the FSM2 library in Flutter applications.

## 1. Architecture

### 1.1 Separation of Concerns

Follow a clear separation of concerns:

- **States**: Define what the system looks like at a given moment
- **Events**: Trigger transitions between states
- **State Machine**: Manages the transitions between states
- **Controller**: Handles UI interactions and business logic

### 1.2 Directory Structure

```
lib/
  ├── core/
  │   └── fsm/
  │       ├── base_state_machine.dart
  │       └── README.md
  └── feature/
      ├── model/
      │   ├── feature_events.dart
      │   ├── feature_state.dart
      │   └── feature_state_machine.dart
      ├── controller/
      │   └── feature_controller.dart
      └── view/
          └── feature_screen.dart
```

## 2. State Definition

### 2.1 State Base Class

- Create a base abstract class for all states
- Include all common properties and methods
- Implement equality and toString methods

```dart
abstract class AppState extends State {
  String get name;
  
  AppState copyWith();
  
  @override
  bool operator ==(Object other);
  
  @override
  int get hashCode;
  
  @override
  String toString() => name;
}
```

### 2.2 State Properties

- Make states immutable
- Use getters for all properties
- Include UI-related properties in the state

## 3. Event Definition

### 3.1 Event Base Class

- Create a base abstract class for all events
- Include a description property for logging

```dart
abstract class AppEvent extends Event {
  String get description;
}
```

### 3.2 Event Organization

- Create a separate file for all events
- Group related events together
- Use descriptive names for events

## 4. State Machine Implementation

### 4.1 Base State Machine

- Create a base class for all state machines
- Use generics to ensure type safety
- Include common functionality like logging and error handling

### 4.2 State Change Notification

- Use a Stream to notify listeners of state changes
- Avoid direct callbacks to controllers
- Handle errors in state transitions

### 4.3 Transition Handlers

- Create separate methods for each transition
- Include logging in transition handlers
- Validate state transitions

## 5. Controller Implementation

### 5.1 Controller Responsibilities

- Handle UI interactions
- Manage timers and animations
- Apply events to the state machine
- Update the UI based on state changes

### 5.2 State Subscription

- Subscribe to state changes from the state machine
- Clean up subscriptions in dispose method
- Handle errors in state changes

## 6. Testing

### 6.1 Unit Testing

- Test each state transition independently
- Mock dependencies when necessary
- Verify state properties after transitions

### 6.2 Widget Testing

- Test UI updates based on state changes
- Test user interactions
- Verify correct events are applied

## 7. Logging

### 7.1 Transition Logging

- Log all state transitions
- Include event information in logs
- Use a consistent format for logs

### 7.2 Error Handling

- Handle and log errors in state transitions
- Provide meaningful error messages
- Recover from errors when possible

## 8. Performance Considerations

### 8.1 State Equality

- Implement proper equality for states
- Use value equality for states
- Consider using equatable package

### 8.2 Memory Management

- Dispose resources when no longer needed
- Close streams in dispose methods
- Avoid memory leaks in subscriptions
