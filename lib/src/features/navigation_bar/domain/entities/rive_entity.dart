import 'package:rive/rive.dart';

class RiveEntity {
  final String src;
  final String artboard;
  final String stateMachineName;
  late SMIBool? status;

  RiveEntity(
      {required this.src,
      required this.artboard,
      required this.stateMachineName,
      this.status});

  set setStatus(SMIBool state) {
    status = state;
  }
}
