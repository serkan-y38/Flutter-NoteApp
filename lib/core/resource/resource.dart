class Resource<T> {
  final T? data;
  final Exception? e;

  Resource({this.data, this.e});
}

class Success<T> extends Resource<T> {
  Success(T data) : super(data: data);
}

class Error<T> extends Resource<T> {
  Error(Exception e, {super.data}) : super(e: e);
}

class Loading<T> extends Resource<T> {
  Loading({super.data});
}
