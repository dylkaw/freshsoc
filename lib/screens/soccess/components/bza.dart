import 'package:flutter/material.dart';
import 'package:freshsoc/screens/soccess/components/semester.dart';

class BusinessAnalytics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semester(
          title: 'Year 1 Semester 1',
          moduleData: [
            ['CS1010S', 'Programming Methodology', '4'],
            ['BT1101', 'Introduction to Business Analytics', '4'],
            ['IS1108', 'Digital Ethics and Data Privacy', '4'],
            ['MA1522', 'Linear Algebra for Computing', '4'],
            ['GES1028', 'Singapore Society', '4'],
            ['CFG1002', 'Career Catalyst', '2'],
          ],
        ),
        Semester(
          title: 'Year 1 Semester 2',
          moduleData: [
            ['CS2030', 'Programming Methodology II', '4'],
            ['MA1521', 'Calculus for Computing', '4'],
            ['IS2101', 'Business and Technical Communication', '4'],
            ['BT2102', 'Data Management and Visualisation', '4'],
            ['BT2101', 'Econometrics Modeling for Business Analytics', '4'],
          ],
        ),
        Semester(
          title: 'Year 2 Semester 1',
          moduleData: [
            ['CS2040', 'Data Structures and Algorithms', '4'],
            [
              'CP2106',
              'Independent Software Development Project (Orbital)',
              '4'
            ],
            ['GES1028', 'Singapore Society', '4'],
            ['HSH1000', 'The Human Condition', '4'],
            ['ST2334', 'Probability and Statistics', '4'],
            ['GEC1000', 'Globalisation and New Media', '4'],
          ],
        ),
      ],
    );
  }
}
