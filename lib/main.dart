
import 'package:anime_verse/config/routes.dart';
import 'package:anime_verse/providers/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Router dibuat satu kali agar stack navigasi tidak ter-reset saat MyApp di-build ulang.
final GoRouter _router = createRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: MaterialApp.router(
        title: 'AnimeVerse',
        theme: ThemeData(
          fontFamily: 'Urbanist',
        ),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
