import 'package:BSApp/providers/emails.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:BSApp/widgets/common/form_field_title.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  static const routeName = '/contact';

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final Map<String, String> _contactData = {'email': '', 'topic': '', 'content': ''};

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _emailController = TextEditingController();

  final _topicController = TextEditingController();

  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.white),
        title: 'Kontakt',
      ),
      backgroundColor: Colors.white,
      body: false
          ? const Center(
              child: LoadingIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormFieldDivider(),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Wypełnij poniższy formularz, aby wysłać do nas wiadomość. Odpowiemy na wskazany przez Ciebie adres email. Postaramy się zrobić to jak najszybciej.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const FormFieldDivider(),
                      const FormFieldDivider(),
                      const FormFieldTitle('Temat wiadomości'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextFormField(
                          controller: _topicController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Temat wiadomości'),
                          validator: (value) {
                            if (value.length < 5) {
                              return 'Za krótki temat wiadomości!';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            // _contactData['topic'] = value;
                          },
                        ),
                      ),
                      const FormFieldDivider(),
                      const FormFieldTitle('Twój email'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Twój email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Nieprawidłowy e-mail!';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            // _contactData['email'] = value;
                          },
                        ),
                      ),
                      const FormFieldDivider(),
                      const FormFieldTitle('Treść wiadomości'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: TextFormField(
                          controller: _contentController,
                          cursorColor: Colors.black,
                          minLines: 6,
                          maxLines: 6,
                          decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Treść wiadomości'),
                          validator: (value) {
                            if (value.length < 10) {
                              return 'Wiadomość musi mieć przynajmniej 10 znaków';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            // _contactData['content'] = value;
                          },
                        ),
                      ),
                      const FormFieldDivider(),
                      if (!_isLoading)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 2.0),
                          child: PrimaryButton('Wyślij wiadomość', _submit),
                        ),
                      if (_isLoading)
                        Container(
                          height: 60.0,
                          child: LoadingIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    final wasSent = await Provider.of<Emails>(context, listen: false).sendEmail(_topicController.text, _contentController.text, _emailController.text);

    setState(() {
      _isLoading = false;
    });
    if (wasSent) {
      _resetForm();
    }
    _showSnackBar(wasSent);
    // Navigator.of(context).pop();
  }

  void _resetForm() {
    _contactData['topic'] = '';
    _contactData['email'] = '';
    _contactData['content'] = '';
    _contentController.clear();
    _topicController.clear();
    _emailController.clear();
  }

  void _showSnackBar(final bool wasSent) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: wasSent ? MyColorsProvider.BLUE : MyColorsProvider.RED_SHADY,
        content: SizedBox(
          height: 22.0,
          child: Stack(
            children: [
              const Icon(Icons.check, color: Colors.white),
              Center(child: Text(wasSent ? 'Wiadomość została wysłana' : 'Bład podczas wysyłania wiadomości!')),
            ],
          ),
        ),
      ),
    );
  }
}
