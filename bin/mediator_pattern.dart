void main() {
  CheckBox checkBox = CheckBox();
  CustomTextFormField textField = CustomTextFormField();

  Form myForm = MyForm(checkBox: checkBox, textField: textField);

  print(textField.isVisible);
  checkBox.toggleState();
  print(textField.isVisible);

  // print(myForm.validate());
  // textField.text = 'Hello, world!';
  // print(myForm.validate());
}

enum Event {
  checkToggle,
}

abstract class Form {
  bool validate();

  void notify(FormElement sender, Event event);
}

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

class MyForm implements Form {
  final CheckBox checkBox;
  final CustomTextFormField textField;

  MyForm({required this.checkBox, required this.textField}) {
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
