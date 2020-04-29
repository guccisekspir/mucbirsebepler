


import 'package:mucbirsebepler/data/dbApiClient.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbRepository{

  DbApiClient _dbApiClient= getIt<DbApiClient>();

  Future<bool> saveUser(User user)async{

    return await _dbApiClient.saveUser(user);
  }



}