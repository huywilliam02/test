import 'package:account/features/mE0001R00AA5/bloc/mE0001R00AA5_state.dart';

class ValidateUsecase {
  bool call(ME0001R00AA5State state) {
    return state.filePickerResult != null &&
        state.profileType != null &&
        state.createdAt != null &&
        state.signatory != null;
  }
}
