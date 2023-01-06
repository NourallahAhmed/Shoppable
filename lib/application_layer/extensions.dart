import 'dart:ffi';

import 'app_constants.dart';

extension NotNullString on String?{
    String orEmpty(){
      if (this == null) {
        return AppConstants.empty;
      } else {
        return this!;
      }
    }
}


extension NotNullInteger on int?{
  int notZero(){
    if(this == null){
      return  AppConstants.zero ; // 0 = success  it might be one not zero
    }
    else{
      return this! ;
    }
  }
}
extension NotNullDouble on double?{
  double notZero(){
    if(this == null){
      return  AppConstants.zeroDouble ; // 0 = success  it might be one not zero
    }
    else{
      return this! ;
    }
  }
}