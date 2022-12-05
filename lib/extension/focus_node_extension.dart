import 'package:flutter/material.dart';

extension FocusNodeExtension on FocusNode {
  VoidCallback addAndRemoveListener(VoidCallback listener) {
    addListener(listener);
    return () => removeListener(listener);
  }
}
