import 'form_element.dart';

enum Event {
  checkToggle,
}

abstract class Form {
  bool validate();

  void notify(FormElement sender, Event event);
}

class SomeUsecaseForm implements Form {
  final CheckBox checkBox;
  final CustomTextFormField textField;

  SomeUsecaseForm({required this.checkBox, required this.textField}) {
    checkBox.form = this;
    textField.form = this;
  }

  @override
  void notify(FormElement sender, Event event) {
    switch (event) {
      case Event.checkToggle:
        textField.toggleVisibility();
        break;
    }
  }

  @override
  bool validate() {
    return (checkBox.validate() && textField.validate());
  }
}
