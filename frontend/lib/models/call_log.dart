import 'package:frontend/constants/enums.dart';

class CallLog {
  CallLog({
    required this.callID,
    required this.participantId,
    required this.callType,
    required this.direction,
    required this.timestamp,
    required this.duration,
  });
  final String callID;
  final String participantId;
  final CallType callType;
  final CallDirection direction;
  final DateTime timestamp;
  final Duration duration;
}
