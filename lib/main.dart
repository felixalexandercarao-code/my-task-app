import 'package:flutter/material.dart';
import 'package:my_task_app/shared/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_task_app/shared/routing/router_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      routerConfig: router,
    );
  }
}