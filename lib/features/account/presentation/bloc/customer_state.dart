part of 'customer_bloc.dart';
enum CustomerStatus { LOADING, SUCCESS, ERROR, INITIAL}

abstract class CustomerState extends Equatable {

  const CustomerState();

  @override
  List<Object?> get props => [];

}

class CustomerLoading extends CustomerState {
  const CustomerLoading();
}

class CustomerError extends CustomerState {
  const CustomerError(this.error);
  final String error;
}

class CustomerSuccess extends CustomerState {
  const CustomerSuccess(this.customer);
  final CustomerModel customer;
}