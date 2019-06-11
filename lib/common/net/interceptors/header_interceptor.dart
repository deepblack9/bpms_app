import 'package:bpms_app/common/config/config.dart';
import 'package:bpms_app/common/local/local_storage.dart';
import 'package:dio/dio.dart';

/**
 * header拦截器
 * Created by guoshuyu
 * on 2019/3/23.
 */
class HeaderInterceptors extends InterceptorsWrapper {


  @override
  onRequest(RequestOptions options) async {
    /// 超时
    options.connectTimeout = 15000;
    /// 设置请求token
    var token = await LocalStorage.get(Config.TOKEN_KEY);
//    print("token: " + token);
    if(token != null) {
      options.headers["Authorization"] = Config.TOKEN_TYPE + " " + token;
    }
    return options;
  }
}