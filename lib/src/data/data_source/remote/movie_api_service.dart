import 'dart:convert';
import 'dart:io';
import '../../../../env/env.dart';
import 'package:http/http.dart';
import '../../../core/resource/data_state.dart';
import '../../../core/util/api_service.dart';
import '../../../core/util/strings.dart';
import '../../../domain/entity/movies_list_entity.dart';
import '../../model/movies_list.dart';

class MovieApiService {
  Client client = Client();

  Future<DataState<MoviesListEntity>> getMoviesList(String nameMovie) async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiService.uri}${ApiService.endpointSearchClient}${ApiService.apiKeyParameter}${Env.movieApiKey}${ApiService.queryParameter}$nameMovie',
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        MoviesList moviesList = MoviesList.fromJson(
          json.decode(
            response.body,
          ),
        );
        if (moviesList.results.isNotEmpty) {
          return DataSuccess(
            moviesList,
          );
        } else {
          return const DataEmpty();
        }
      } else {
        return DataFailed(
          '${Strings.errorMessage} ${response.statusCode}',
        );
      }
    } catch (exception) {
      return DataFailed(
        '${Strings.errorMessage} ${exception.toString()}',
      );
    }
  }
}
