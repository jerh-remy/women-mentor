import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/widgets/shared/empty_content.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key? key,
    required this.signedInBuilder,
    required this.nonSignedInBuilder,
  }) : super(key: key);
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateChangesProvider);
    print(authStateChanges.data);
    return authStateChanges.when(
      data: (user) => _data(context, user),
      loading: () => const Scaffold(),
      error: (_, __) => const Scaffold(
        body: EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load data right now.',
        ),
      ),
    );
  }

  Widget _data(BuildContext context, User? user) {
    print(user);
    if (user != null) {
      return signedInBuilder(context);
    }
    return nonSignedInBuilder(context);
  }
}
