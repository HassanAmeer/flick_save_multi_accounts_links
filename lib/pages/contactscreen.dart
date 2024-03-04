import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _senderEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
              ),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            TextField(
              controller: _senderEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendEmail,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmail() async {
    final name = _nameController.text;
    final contact = _contactController.text;
    final subject = _subjectController.text;
    final senderEmail = _senderEmailController
        .text; // Assuming you have an input field for the sender's email

    final smtpServer = SmtpServer(
      'smtp.hostinger.com',
      username: 'info@flicktags.com',
      password: 'F71ck@Wa1LB0x',
      port: 465,
      ssl: true,
    );

    final message = Message()
      ..from = Address(senderEmail, 'Sender')
      ..recipients.add('test@flicktags.com')
      ..subject = subject
      ..text = 'Name: $name\nContact: $contact';

    try {
      await send(message, smtpServer);
      print('Email sent successfully');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
