import 'dart:math' as math show pow;

class MathFormula {
    static double getNthroot({double number ,num factor}) {
      return ((math.pow(number, 1 / factor) * 1000000000).round() / 1000000000);
    }

    static double getPower({double number, num exponent}){
      return math.pow(number, exponent);
    }

    static double getBMI({double mass, double height}){
      return (mass/height*height);
    }
}
