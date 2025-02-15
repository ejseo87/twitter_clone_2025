import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/authentication/password_screen.dart';
import 'package:twitter_clone_2025/widgets/form_button.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  final Map<String, dynamic> userAccountInfo;
  const ConfirmationCodeScreen({
    super.key,
    required this.userAccountInfo,
  });

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _confirmationCode = ["1", "2", "3", "4", "5", "6"];
  final List<String> _inputCode = ["0", "0", "0", "0", "0", "0"];

  bool _validCode = false;

  void _onPreviousTap() {
    Navigator.pop(context);
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          "assets/images/twitter-color-svgrepo-com.svg",
          width: 30,
          height: 30,
        ),
        leading: GestureDetector(
          onTap: _onPreviousTap,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v48,
            Text(
              textAlign: TextAlign.start,
              "We sent you a code",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gaps.v20,
            const Text("Enter it below to verify"),
            Text(widget.userAccountInfo['email']),
            Gaps.v36,
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                  _confirmationCode.length,
                  (index) => SizedBox(
                    width: Sizes.size40,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        setState(() {
                          _inputCode[index] = value;
                          _validCode =
                              listEquals(_confirmationCode, _inputCode);
                        });
                        if (_validCode) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        print('_inputCode=$_inputCode,_validCode=$_validCode');
                      },
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v20,
            AnimatedOpacity(
              opacity: _validCode ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: Sizes.size36,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size40,
        ),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Didn't receive email?",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Gaps.v10,
              GestureDetector(
                onTap: _onNextTap,
                child: Hero(
                  tag: "signUpBtn",
                  child: FormButton(
                    disabled: !_validCode,
                    text: "Next",
                    buttonType: ButtonType.big,
                  ),
                ),
              ),
              /* AnimatedContainer(
                duration: const Duration(microseconds: 500),
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  color:
                      _validCode ? Colors.black : Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(microseconds: 500),
                  style: TextStyle(
                    color: _validCode ? Colors.white : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  child: const Text(
                    "Next",
                    textAlign: TextAlign.center,
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
