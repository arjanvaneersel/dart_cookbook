import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Change data
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  
  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid => 
    Observable.combineLatest2(email, password, (e, p) => true);

  submit() {
    final email = _email.value;
    final password = _password.value;

    print('API call with {$email, $password}');
  }

  dispose() {
    _email.sink.close();
    _password.sink.close();
  }

}