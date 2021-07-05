mixin Validator {

  String? validateEmail(String? input) {
    if (input == null) {
      return null;
    }
    // This regex is the same as the one from HTML5 validation forms
    // source: https://html.spec.whatwg.org/multipage/input.html#e-mail-state-%28type=email%29
    final emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!emailRegex.hasMatch(input)) {
      return 'Email inválido';
    }
  }
}