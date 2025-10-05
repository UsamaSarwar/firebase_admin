/// Stub implementation for IO operations.
/// This file is used when the platform doesn't support dart:io
class File {
  final String path;
  
  File(this.path);
  
  bool existsSync() {
    throw UnsupportedError(
      'File operations are not supported on this platform. '
      'Please provide credentials as a Map object instead of a file path.'
    );
  }
  
  String readAsStringSync() {
    throw UnsupportedError(
      'File operations are not supported on this platform. '
      'Please provide credentials as a Map object instead of a file path.'
    );
  }
  
  void writeAsStringSync(String contents) {
    throw UnsupportedError(
      'File operations are not supported on this platform. '
      'Please provide credentials as a Map object instead of a file path.'
    );
  }
  
  Future<void> delete() {
    throw UnsupportedError(
      'File operations are not supported on this platform. '
      'Please provide credentials as a Map object instead of a file path.'
    );
  }
  
  Directory get parent => Directory(path);
}

class Directory {
  final String path;
  
  Directory(this.path);
  
  void createSync({bool recursive = false}) {
    throw UnsupportedError(
      'Directory operations are not supported on this platform.'
    );
  }
}

class Platform {
  static bool get isWindows => false;
  
  static Map<String, String> get environment => {};
}
