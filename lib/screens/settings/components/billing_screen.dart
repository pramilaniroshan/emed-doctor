import 'package:emedassistantmobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:emedassistantmobile/config/app_colors.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /// free plan box
            freePlanBox(width),

            const SizedBox(height: 40.0),

            const Text('Subscribe a new plan',
              style: TextStyle(
                fontSize: 24.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),

            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: AppColors.lightBlue.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  /// basic plan box
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text('Basic',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: 10.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.redColor,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 34.0,
                            width: 26.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 28.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 30.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  basicPlanBox(width),
                  const SizedBox(height: 16.0),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '\$ 0',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '/month',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// plus plan Box
                  const SizedBox(height: 36.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text('Plus',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: 10.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 34.0,
                            width: 26.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: AppColors.redColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 28.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 30.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  plusPlanBox(width),
                  const SizedBox(height: 16.0),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Fixed \$',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' 10',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '/month*',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CustomButton(
                    onTap: (){},
                    btnText: 'UPGRADE',
                  ),

                  /// premium plan Box
                  const SizedBox(height: 36.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text('Premium',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: 10.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 34.0,
                            width: 26.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 28.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.redColor,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 30.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  premiumPlanBox(width),
                  const SizedBox(height: 16.0),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '\$',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' 0.25',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' per patient',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '/month',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CustomButton(
                    onTap: (){},
                    btnText: 'UPGRADE',
                  ),

                  /// custom plan Box
                  const SizedBox(height: 36.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text('Custom',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: 10.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 34.0,
                            width: 26.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 28.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Container(
                        height: 30.0,
                        width: 26.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.redColor,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  customPlanBox(width),
                  const SizedBox(height: 16.0),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Quotation based',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CustomButton(
                    onTap: (){},
                    btnText: 'CONTACT US',
                  ),

                ],
              ),
            ),

            /// frequently asked questions
            const SizedBox(height: 48.0),
            const Text('Frequently asked questions about eMed plans',
              style: TextStyle(
                fontSize: 26.0,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24.0),

            /// Questions start

            questionText('When payment method do you accept?'),
            const SizedBox(height: 8.0),
            answerText('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type '
                'specimen book.'
            ),
            const SizedBox(height: 24.0),

            questionText('When payment method do you accept?'),
            const SizedBox(height: 8.0),
            answerText('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type '
                'specimen book.'
            ),
            const SizedBox(height: 24.0),

            questionText('When payment method do you accept?'),
            const SizedBox(height: 8.0),
            answerText('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type '
                'specimen book.'
            ),
            const SizedBox(height: 24.0),

            questionText('When payment method do you accept?'),
            const SizedBox(height: 8.0),
            answerText('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type '
                'specimen book.'
            ),
            const SizedBox(height: 24.0),

            questionText('When payment method do you accept?'),
            const SizedBox(height: 8.0),
            answerText('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type '
                'specimen book.'
            ),
            const SizedBox(height: 24.0),
            questionText('When payment method do you accept?'),
            const SizedBox(height: 8.0),
            answerText('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
                'when an unknown printer took a galley of type and scrambled it to make a type '
                'specimen book.'
            ),
            const SizedBox(height: 24.0),

          ],
        ),
      ),
    );
  }

  Widget freePlanBox(width) => Container(
    width: width,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: AppColors.lightBlue.withOpacity(0.1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('My actual plan:',
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text('Free',
            style: TextStyle(
              fontSize: 32.0,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text('Your plan expires in 2 weeks on:',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.0),
        Text('01 April 2022',
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );

  Widget basicPlanBox(width) => Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: AppColors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('1-10 Patients',
          style: TextStyle(
            fontSize: 22.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
        Text('For doctors who see up to 10 patients per month',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('Doctors can add one assistant.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('Doctors can add only one location.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('Can use this free with all features.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );

  Widget plusPlanBox(width) => Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: AppColors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('Unlimited Patients',
          style: TextStyle(
            fontSize: 22.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
        Text('*1-100 patients: 0.1 \$ per patient.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('*>101 patients: 0.1 \$ per patient.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('All the features are included.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('Invoices send at the end of the each month',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );

  Widget premiumPlanBox(width) => Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: AppColors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('1-500 Patients',
          style: TextStyle(
            fontSize: 22.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
        Text('All the features are included.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.0),
        Text('Invoices send at the end of the each month',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 48.0),
      ],
    ),
  );

  Widget customPlanBox(width) => Container(
    width: width,
    padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0, right: 40.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: AppColors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('>500 Patients',
          style: TextStyle(
            fontSize: 22.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
        Text('For customers and organizations with complex needs who want to have a talented solution.',
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 48.0),
      ],
    ),
  );

  Widget questionText(text) =>  Text(
    text,
    style: const TextStyle(
      fontSize: 15.0,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
  );

  Widget answerText(text) => Text(
    text,
    style: const TextStyle(
      fontSize: 14.0,
      color: AppColors.lightBlack,
      fontWeight: FontWeight.w400,
    ),
  );
}
