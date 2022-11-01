/// category_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timesofkashmir/features/news/domain/entities/category.dart';

part 'category_state.freezed.dart';

///Extension Method for easy comparison
extension CategoryGetters on CategoryState {
  bool get isLoading => this is _CategoryStateLoading;
}

@freezed
abstract class CategoryState with _$CategoryState {
  ///Initial
  const factory CategoryState.initial() = _CategoryStateInitial;

  ///Loading
  const factory CategoryState.loading() = _CategoryStateLoading;

  ///Data
  const factory CategoryState.data({required List<Category> category}) =
      _CategoryStateData;

  ///Error
  const factory CategoryState.error([String? error]) = _CategoryStateError;
}
