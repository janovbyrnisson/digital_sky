import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'master_service.g.dart';

@Riverpod(keepAlive: true)
MasterService masterService(MasterServiceRef ref) {
  return MasterService();
}

class MasterService {
  void doSomething() {
    print('Doing something');
  }
}
