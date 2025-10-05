/// Universal IO interface that works across all platforms.
/// 
/// On platforms that support dart:io (mobile, desktop, server), this exports
/// the real File, Directory, and Platform classes.
/// 
/// On web platforms, this provides stub implementations that throw helpful
/// errors directing users to use object-based credentials instead of file paths.
export 'io_stub.dart'
    if (dart.library.io) 'io_io.dart';
