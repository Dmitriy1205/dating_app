class Status {
  final bool isInitial;
  final bool isLoading;
  final bool isError;
  final bool isLoaded;
  final String? errorMessage;
  final String? attribute;

  Status._({
    this.isInitial = false,
    this.isLoading = false,
    this.isError = false,
    this.isLoaded = false,
    this.errorMessage,
    this.attribute,
  });

  factory Status.initial() {
    return Status._(isInitial: true);
  }

  factory Status.loading() {
    return Status._(isLoading: true);
  }

  factory Status.loaded() {
    return Status._(isLoaded: true, isLoading: false);
  }

  factory Status.error([String? message, String? attribute]) {
    return Status._(
      isError: true,
      isLoading: false,
      errorMessage: message,
      attribute: attribute,
    );
  }
}
