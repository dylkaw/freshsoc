import 'package:flutter/material.dart';
import 'package:freshsoc/screens/soccess/components/semester.dart';

class InformationSecurity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semester(
          title: 'Year 1 Semester 1',
          moduleData: [
            ['CS1101S', 'Programming Methodology', '4'],
            ['CS1231S', 'Discrete Structures', '4'],
            ['IS1108', 'Digital Ethics and Data Privacy', '4'],
            ['MA1522', 'Linear Algebra for Computing', '4'],
            ['GES1028', 'Singapore Society', '4'],
            ['CFG1002', 'Career Catalyst', '2'],
          ],
        ),
        Semester(
          title: 'Year 1 Semester 2',
          moduleData: [
            ['CS2040C', 'Data Structures and Algorithms', '4'],
            ['MA1521', 'Calculus for Computing', '4'],
            ['GEA1000', 'Quantitative Reasoning with Data', '4'],
            [
              'CS2101',
              'Effective Communication for Computing Professionals',
              '4'
            ],
            [
              'CS2113T',
              'Software Engineering & Object-oriented Programming',
              '4'
            ],
          ],
        ),
        Semester(
          title: 'Year 2 Semester 1',
          moduleData: [
            [
              'CP2106',
              'Independent Software Development Project (Orbital)',
              '4'
            ],
            ['CS2100', 'Computer Organisation', '4'],
            ['CS2105', 'Introduction to Computer Networks', '4'],
            ['CS2106', 'Introduction to Operating Systems', '4'],
            ['ST2334', 'Probability and Statistics', '4'],
            ['GEC1000', 'Globalisation and New Media', '4'],
          ],
        ),
      ],
    );
  }
}
