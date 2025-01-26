import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/features/agreement_screen.dart';
import 'package:twitter_clone_2025/features/confirmation_code_screen.dart';
import 'package:twitter_clone_2025/witgets/form_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthdayController = TextEditingController();
  final DateTime _currentDate = DateTime.now();

  final Map<String, dynamic> _formData = {};

  late DateTime _initialDate;

  bool _onTapBirthday = false;
  bool _onTapEmail = false;
  bool _agreed = false;

  @override
  void initState() {
    super.initState();
    _initialDate = _currentDate.subtract(const Duration(days: 365 * 12));
    _setTextFieldDate(_initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _formData['birthday'] = textDate;

    _birthdayController.value = TextEditingValue(
      text: textDate,
    );

    setState(() {});
  }

  String? _isNameValid(String? value) {
    if (value == null || value.length < 8) {
      return 'Name should be more than 8 characters';
    }
    return null;
  }

  String? _isEmailValid(String? value) {
    if (value == null) {
      return "Please input your email.";
    }
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  bool _isFormValid() => _formKey.currentState?.validate() ?? false;

  Future<void> _onNextTap() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final bool agreed = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AgreementScreen(),
          ),
        );

        _agreed = agreed;
        setState(() {});
      }
    }
  }

  void _onSignUpTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationCodeScreen(
            userAccountInfo: _formData,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(
            "assets/images/twitter-color-svgrepo-com.svg",
            width: 30,
            height: 30,
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Align(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          leadingWidth: 80,
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
                "Create your account",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v36,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      //autofocus: false,
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        suffixIcon: _isNameValid(_formData['name']) == null
                            ? drawCheckbox()
                            : null,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter(
                            RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                            allow: true),
                      ],
                      validator: (value) => _isNameValid(value),
                      onChanged: (value) {
                        setState(() {
                          _formData['name'] = value;
                        });
                      },
                    ),
                    Gaps.v20,
                    TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      decoration: InputDecoration(
                        hintText: "Email or Phone number",
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        suffixIcon: _formData['email'] != null &&
                                _isEmailValid(_formData['email']) == null
                            ? drawCheckbox()
                            : null,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      validator: (value) => _isEmailValid(value),
                      onChanged: (value) {
                        setState(() {
                          _formData['email'] = value;
                        });
                      },
                      onTap: () {
                        _onTapEmail = true;
                        setState(() {});
                      },
                    ),
                    Gaps.v20,
                    TextFormField(
                      autofocus: false,
                      autocorrect: false,
                      keyboardType: TextInputType.datetime,
                      controller: _birthdayController,
                      enabled: true,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      decoration: InputDecoration(
                        labelText: "Date of birth",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        suffixIcon:
                            _agreed && _birthdayController.text.isNotEmpty
                                ? drawCheckbox()
                                : null,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _onTapBirthday = true;
                        _onTapEmail = false;
                        setState(() {});
                        showCupertinoModalPopup(
                          useRootNavigator: false,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200.0,
                              child: CupertinoDatePicker(
                                maximumDate: _initialDate,
                                initialDateTime: _initialDate,
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: _setTextFieldDate,
                                backgroundColor: Colors.white,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Gaps.v5,
                    if (_onTapBirthday && !_agreed)
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Text(
                            "This will not be shown publicly. Confirm your own age, even if this accounts is for a business, a pet, or somthing else.",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: Sizes.size14,
                            )),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: _agreed
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "By signing up, you agree to the ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: Sizes.size16,
                          height: 1.2,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(text: "and"),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(
                            text:
                                ", including Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. ",
                          ),
                          TextSpan(
                            text: "Learn more",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  ". Others will be able to find you by email or phone number, when provided, unless you choose otherwise "),
                          TextSpan(
                            text: "here",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    Gaps.v20,
                    GestureDetector(
                      onTap: _onSignUpTap,
                      child: FormButton(
                        disabled: false,
                        text: "Sign up",
                        buttonType: ButtonType.big,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                    vertical: Sizes.size10,
                  ),
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _onTapEmail
                          ? const Text("Use phone instead")
                          : Container(),
                      GestureDetector(
                        onTap: _onNextTap,
                        child: FormButton(
                          disabled: !_isFormValid(),
                          text: "Next",
                          buttonType: ButtonType.small,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  SizedBox drawCheckbox() {
    return const SizedBox(
      width: 20,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FaIcon(
          FontAwesomeIcons.solidCircleCheck,
          color: Colors.green,
        ),
      ),
    );
  }
}
