import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final Widget svg = SvgPicture.asset(
  'images/pic.svg',
  color: Colors.red,
);

class TestPage extends StatelessWidget {
  static String id = 'test_page';
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        height: 800,
        child: CustomPaint(
          // size: Size(WIDTH, (WIDTH*2).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..style=PaintingStyle.fill
    ..color=Colors.black;
    Path path_0 = Path();
    path_0.moveTo(size.width*-0.01105943,size.height*0.7000982);
    path_0.cubicTo(size.width*0.1344595,size.height*0.6455286,size.width*0.3163970,size.height*0.5895258,size.width*0.5088643,size.height*0.6183959);
    path_0.cubicTo(size.width*0.6562231,size.height*0.6404997,size.width*0.8665023,size.height*0.7255350,size.width*1.013933,size.height*0.6518196);

    Paint paint_0_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.004000000;
    paint_0_stroke.color=Colors.red.withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_stroke);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
