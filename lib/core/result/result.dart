sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => switch (this) {
        final Success<T> s => s.value,
        final Failure<T> _ => null,
      };

  String? get errorOrNull => switch (this) {
        final Success<T> _ => null,
        final Failure<T> f => f.error,
      };

  Result<U> map<U>(U Function(T) transform) => switch (this) {
        final Success<T> s => Success(transform(s.value)),
        final Failure<T> f => Failure(f.error),
      };

  R fold<R>(R Function(T) onSuccess, R Function(String) onFailure) =>
      switch (this) {
        final Success<T> s => onSuccess(s.value),
        final Failure<T> f => onFailure(f.error),
      };
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final String error;
}
