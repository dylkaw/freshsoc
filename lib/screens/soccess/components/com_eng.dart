import 'package:flutter/material.dart';
import 'package:freshsoc/screens/soccess/components/semester.dart';

class ComputerEngineering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semester(
          title: 'Year 1 Semester 1',
          moduleData: [
            ['CS1010', 'Programming Methodology', '4'],
            ['CG1111A', 'Engineering Principles and Practice I', '4'],
            ['EG1311', 'Design and Make', '4'],
            ['MA1508E', 'Linear Algebra for Engineering', '4'],
            ['GES1028', 'Singapore Society', '4'],
            ['CFG1002', 'Career Catalyst', '2'],
          ],
        ),
        Semester(
          title: 'Year 1 Semester 2',
          moduleData: [
            ['DTK1234', 'Design Thinkning', '4'],
            ['PF1101', 'Fundamentals of Project Management', '4'],
            ['MA1511', 'Calculus for Engineering', '4'],
            ['CG2111A', 'Engineering Principles and Practice II', '4'],
            ['GEA1000', 'Quantitative Reasoning with Data', '4'],
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
            ['CS1231', 'Discrete Structures', '4'],
            ['CS2040C', 'Data Structures and Algorithms', '4'],
            ['IE2141', 'Systems Thinking', '4'],
            [
              'ES2631',
              'Critique and Communication of Thinking and Design',
              '4'
            ],
            ['GEC1000', 'Globalisation and New Media', '4'],
          ],
        ),
      ],
    );
  }
}
