import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/domain/entities/example_model.dart';
import 'package:{{project_name}}/domain/repositories/example_repository.dart';
import 'package:{{project_name}}/presentation/providers/example/example_repository_provider.dart';
import 'package:{{project_name}}/presentation/services/notification_service.dart';

final exampleProvider = NotifierProvider<ExampleProviderNotifier, ExampleState>(
  ExampleProviderNotifier.new,
);

class ExampleProviderNotifier extends Notifier<ExampleState> {
  late final ExampleRepository _exampleRepository;

  @override
  ExampleState build() {
    _exampleRepository = ref.read(exampleRepositoryProvider);
    return ExampleState(isLoading: true);
  }

  Future<void> getItems() async {
    state = state.copyWith(isLoading: true);
    final response = await _exampleRepository.getAll();
    if (response.error) {
      state = state.copyWith(errorMessage: response.message, isLoading: false);
    } else {
      final items = (response.data as List)
          .map((item) => ExampleModel.fromJson(item as Map<String, dynamic>))
          .toList();
      state = state.copyWith(items: items, errorMessage: null);
    }
    state = state.copyWith(isLoading: false);
  }

  Future<ExampleModel?> getById(String id) async {
    state = state.copyWith(isLoading: true);
    final response = await _exampleRepository.getById(id);
    if (response.error) {
      state = state.copyWith(errorMessage: response.message, isLoading: false);
      return null;
    }
    state = state.copyWith(isLoading: false);
    return ExampleModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> create(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true);
    final response = await _exampleRepository.create(data);
    if (response.error) {
      state = state.copyWith(errorMessage: response.message, isLoading: false);
      NotificationService.showSnackbarError(response.message);
    } else {
      await getItems();
    }
  }

  Future<void> update(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true);
    final response = await _exampleRepository.update(data);
    if (response.error) {
      state = state.copyWith(errorMessage: response.message, isLoading: false);
      NotificationService.showSnackbarError(response.message);
    } else {
      await getItems();
    }
  }

  Future<void> delete(String id) async {
    state = state.copyWith(isLoading: true);
    final response = await _exampleRepository.delete(id);
    if (response.error) {
      state = state.copyWith(errorMessage: response.message, isLoading: false);
      NotificationService.showSnackbarError(response.message);
    } else {
      await getItems();
    }
  }
}

class ExampleState {
  final List<ExampleModel> items;
  final bool isLoading;
  final String? errorMessage;

  ExampleState({
    this.items = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  ExampleState copyWith({
    List<ExampleModel>? items,
    String? errorMessage,
    bool? isLoading,
  }) {
    return ExampleState(
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
