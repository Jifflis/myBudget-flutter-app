import 'package:flutter/cupertino.dart';
@immutable
class Version implements Comparable<Version> {
  const Version(this.major,this.minor,this.patch);

  final int major;
  final int minor;
  final int patch;

  bool operator <(dynamic o) => o is Version && _compare(this, o) < 0;

  bool operator <=(dynamic o) => o is Version && _compare(this, o) <= 0;

  @override
  bool operator ==(dynamic other) => other is Version && _compare(this, other) == 0;

  bool operator >(dynamic o) => o is Version && _compare(this, o) > 0;

  bool operator >=(dynamic o) => o is Version && _compare(this, o) >= 0;

  static Version factory(String version){
    try{
      final List<String> versions = version.split('.');
      final int major = int.parse(versions[0]);
      final int minor = int.parse(versions[1]);
      final int patch = int.parse(versions[2]);
      return Version(major, minor, patch);
    }catch(e){
      throw ArgumentError('Invalid version format');
    }
  }

  @override
  int compareTo(Version other) {
    return _compare(this, other);
  }

  static int _compare(Version a, Version b) {
    if (a == null) {
      throw ArgumentError.notNull('a');
    }

    if (b == null) {
      throw ArgumentError.notNull('b');
    }

    if (a.major > b.major) return 1;
    if (a.major < b.major) return -1;

    if (a.minor > b.minor) return 1;
    if (a.minor < b.minor) return -1;

    if (a.patch > b.patch) return 1;
    if (a.patch < b.patch) return -1;

    return 0;
  }

  @override
  int get hashCode => super.hashCode;

}
