String? validaCampoVazio(String? value) {
  if (value == null || value.isEmpty) {
    return "Campo vazio";
  }
  return null;
}

String? validaSelect(
    {required String? value, required String primeiroValorSelect}) {
  if (value == null || value == primeiroValorSelect) {
    return "Valor inválido";
  }
  return null;
}
