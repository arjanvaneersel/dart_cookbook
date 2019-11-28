import 'dart:async';

class Validators  {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (val, sink) {
      if (!val.contains('@') || !val.contains('.')) {
        sink.addError('Enter a valid email');
        return;
      }
      sink.add(val);
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (val, sink) {
      if (val.length < 4) {
        sink.addError('Password should have more than 4 characters');
        return;
      }
      sink.add(val);
    },
  );
}