abstract class ValidatableObject<T> {
  const ValidatableObject(this.value);
  final T value;

  String? validate();
}
