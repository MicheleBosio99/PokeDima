

String extractFirebaseErrorMessage(String errorMessage) {
  int closingBracketIndex = errorMessage.indexOf(']');
  if (closingBracketIndex != -1 && closingBracketIndex + 1 < errorMessage.length) {
    return errorMessage.substring(closingBracketIndex + 1).trim();
  } else { return errorMessage; }
}