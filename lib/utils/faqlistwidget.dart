import 'package:flick/provider/stngsVm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaqListWidget extends StatefulWidget {
  @override
  _FaqListWidgetState createState() => _FaqListWidgetState();
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

// Sample list of FAQ items
List<FaqItem> faqItems = [
  FaqItem(
      question: 'What is Flick?',
      answer:
          'Flick is new way of sharing your contacts with other. it\'s as combination of software and a hardware. \nFlick will help business to reduce their paper cards cost. \nFlick will help individuals to share as much Social Media handles and contacts as they want just by a tap.'),
  FaqItem(
      question: 'How can I download?',
      answer:
          'To download, you need to follow these steps \n 1- go to PlayStore/Appstore. \n search for Flick Application'),
  FaqItem(
      question: 'Is the Flick Application Free?',
      answer:
          'YES, Flick application is free. you can get it from Google Playstore or Apple Appstore.'),

  FaqItem(
      question: 'Can i add more than 1 instagram account?',
      answer:
          'YES, You can add as many accounts as you want, with same category or different, there is not limit'),
  FaqItem(
      question: 'What is Private Mode?',
      answer:
          'Private mode is when you want to keep your profile hidden. No need to disable your contact accounts one by one. Just enable the private mode and your profile will be hidden from tappers.'),
  FaqItem(
      question: 'what is Direct Mode?',
      answer:
          'Direct mode helps you to trigger a single social media directly when tapper taps on your flick device. In this way tapper will not see you other contact handles.'),
  FaqItem(
      question: 'How to enable Direct mode?',
      answer:
          'For enabling Direct Mode follow these steps: \n1- Navigate to your profile page. \n2- Tap on Direct switch. \n3- Select any 1 account handle. \n4- Tap on preview to test.'),
  FaqItem(
      question: 'Can i add more than 1 instagram account?',
      answer:
          'YES, You can add as many accounts as you wish with same category or different, there is not limit'),
  FaqItem(
      question: 'How can i activate my Flick card/tag?',
      answer:
          'For activating your Flick card/tag follow these steps: \n1- Open Flick Application. \n2- Navigate to settings page. \n3- Tap on Activate Flick. \n4- Enter your Flick Code (you can find your Flick Code in product package). \n5- Once verified an animation will appear, touch your Flick device to your device, system will automatically activate your Flick device. '),
  FaqItem(
      question: 'what is Share By Category?',
      answer:
          'Share by category is an advance feature provided by Flick. once it\'s enabled you will be completely in control of what profiles to share. '),
  FaqItem(
      question: 'Do i have to pay to purchase extra features?',
      answer:
          'No, we at Flick try to provide our customers all the premium features at no cost.'),
  FaqItem(
      question: 'Is my data secure?',
      answer:
          'YES, we at Flick invested highly in encrypted and secure servers to make sure keeping our customers data safe and secure.'),
  FaqItem(
      question: 'Does the application contain Ads?',
      answer:
          'No, our application comes with zero ads, so you can have easy operations throughout the application.'), // Add more FAQ items as needed
];

class _FaqListWidgetState extends State<FaqListWidget> {
  var borderRadius = const BorderRadius.all(Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(8.0), // Adjust the radius as desired
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: context.watch<StngsVmC>().isDarkMode
                      ? const LinearGradient(
                          colors: [
                            Color.fromRGBO(16, 145, 185, 1),
                            Color.fromRGBO(0, 89, 117, 1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )
                      : const LinearGradient(
                          colors: [
                              Color.fromRGBO(56, 199, 243, 1),
                              Color.fromRGBO(4, 157, 204, 1)
                            ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  title: Text(
                    faqItems[index].question,
                    style: TextStyle(
                        color: context.watch<StngsVmC>().isDarkMode
                            ? Colors.white
                            : Colors.white,
                        fontFamily: 'CarosMedium'), // Set the text color
                  ),
                  trailing: Icon(Icons.arrow_forward,
                      color: context.watch<StngsVmC>().isDarkMode
                          ? Colors.white
                          : Colors.white // Set the icon color
                      ),
                  onTap: () {
                    _showFAQBottomModal(
                      faqItems[index].question,
                      faqItems[index].answer,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFAQBottomModal(String question, String answer) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.watch<StngsVmC>().isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontFamily: 'CarosLight',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                Text(
                  answer,
                  style: TextStyle(
                    fontFamily: 'CarosLight',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
