import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/utils.dart';

// There is no data exposed.
// when an account has been created,
//view model just shows loading screen and triggers the process of account creation
class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> emailSignUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(
      () async => await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(
        context: context,
        error: state.error,
      );
    } else {
      context.go("/home");
    }
  }
}

//틱톡클론앱은 화면별로 username, email, password, birthday를 선택하게 되어 있다.
//StateOrivuder애서는 map을 노출시키고 email과 password 화면에서 signUpForm을 완성시키기게 한다.
final signUpForm = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
