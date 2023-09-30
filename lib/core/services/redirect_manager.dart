import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class RedirectManager {
  BuildContext context;

  RedirectManager(this.context);

  void redirectAndPopStack(String path, {extra}) => context.go(path, extra: extra);

  Future<Object?> redirect(String path, {extra}) => context.push(path, extra: extra);

  void replace(String path, {extra}) => context.replace(path, extra: extra);

  void back({extra}) => context.pop(extra);
}
