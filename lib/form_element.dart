import 'form.dart';

abstract class FormElement {
  Form? form;
  bool validate();
}

class CheckBox extends FormElement {
  bool checked = false;
  @override
  bool validate() => checked;

  void toggleState() {
    checked = !checked;

    form?.notify(this, Event.checkToggle);
  }
}

class TextFormField extends FormElement {
  String text = '';
  @override
  bool validate() => text.isNotEmpty;
}

class CustomTextFormField extends TextFormField {
  bool _visible = false;

  bool get isVisible => _visible;

  void toggleVisibility() {
    _visible = !_visible;
  }
}
