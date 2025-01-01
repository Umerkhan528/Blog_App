import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class CheckConnection{
  Future<bool> get isConnection;
}

class CheckConnectionImpl implements CheckConnection{
  InternetConnection checkConnection ;
  CheckConnectionImpl(this.checkConnection);
  @override
  Future<bool> get isConnection => checkConnection.hasInternetAccess;

}