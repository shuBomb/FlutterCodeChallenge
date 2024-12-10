import 'package:code_challenge/app/modules/search_module/search_controller.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>SearchscreenController());
  }

}