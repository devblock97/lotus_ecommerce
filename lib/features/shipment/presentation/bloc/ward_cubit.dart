import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/get_wards.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/ward_state.dart';

class WardCubit extends Cubit<WardState> {
  WardCubit(this.getWards) : super(const WardState());
  GetWards getWards;

  Future<void> getWard(String parentCode) async {
    emit(state.copyWith(status: WardStatus.loading));
    final response = await getWards(ParamGetWards(parentCode: parentCode));
    response.fold(
      (error) => emit(state.copyWith(status: WardStatus.error, message: error.toString())),
      (wards) => emit(state.copyWith(wards: wards, status: WardStatus.success))
    );
  }
}