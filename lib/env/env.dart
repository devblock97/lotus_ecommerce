import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: 'scripts/env/.env')
abstract class Env {

  @EnviedField(varName: 'CONSUMER_KEY')
  static const String consumerKey = _Env.consumerKey;

  @EnviedField(varName: 'CONSUMER_SECRET')
  static const String consumerSecret = _Env.consumerSecret;
}
