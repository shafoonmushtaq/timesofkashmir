/// News_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timesofkashmir/features/news/domain/entities/news.dart';

part 'news_state.freezed.dart';

///Extension Method for easy comparison
extension NewsGetters on NewsState {
  bool get isLoading => this is _NewsStateLoading;
  bool get data => this is _NewsStateData;
}

@freezed
abstract class NewsState with _$NewsState {
  ///Initial
  const factory NewsState.initial() = _NewsStateInitial;

  ///Loading
  const factory NewsState.loading() = _NewsStateLoading;

  ///Data
  const factory NewsState.data({required List<News> news}) = _NewsStateData;

  ///Error
  const factory NewsState.error([String? error]) = _NewsStateError;
}
