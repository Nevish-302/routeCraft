import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'ACCESS_TOKEN', obfuscate: true)
  static final String ACCESS_TOKEN = _Env.ACCESS_TOKEN;

  @EnviedField(varName: 'GEMINI', obfuscate: true)
  static final String GEMINI = _Env.GEMINI;

  @EnviedField(varName: 'PEXELS', obfuscate: true)
  static final String PEXELS = _Env.PEXELS;
}