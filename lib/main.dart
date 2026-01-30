import 'package:auto_swift/features/admin/admin_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bztelcxkrnlujynwuwlu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6dGVsY3hrcm5sdWp5bnd1d2x1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk3NTY0MDQsImV4cCI6MjA4NTMzMjQwNH0.pFZjuUJxphYcToQWN-3WuTEMT9SID_gCkuXodqzjz5A',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AdminView());
  }
}
