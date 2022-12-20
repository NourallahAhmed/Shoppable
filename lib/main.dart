import 'package:flutter/material.dart';

import 'application_layer/app.dart';
import 'application_layer/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp());
}

