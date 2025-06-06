import 'dart:developer';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/explore/domain/model/search_people_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ExploreRemoteDatasource {
  Future<List<SearchPeopleModel>> serachPeople({required String searchString});
}

class ExploreRemoteDatasourceImpl implements ExploreRemoteDatasource {
  final Supabase supabase;
  ExploreRemoteDatasourceImpl({required this.supabase});
  @override
  Future<List<SearchPeopleModel>> serachPeople({
    required String searchString,
  }) async {
    final List<SearchPeopleModel> searchedPeopleList = [];
    try {
      final res = await supabase.client
          .from(userTable)
          .select('username, user_id, profile_image_url')
          .like('username', '$searchString%');
      final userId = await getLoggedUserId();
      if (res.isNotEmpty) {
        for (var item in res) {
          if (item['user_id'] == userId) {
            continue;
          }
          searchedPeopleList.add(
            SearchPeopleModel(
              userId: item['user_id'],
              username: item['username'],
              profileImageUrl: item['profile_image_url'],
            ),
          );
        }
        return searchedPeopleList;
      }

      return searchedPeopleList;
    } catch (err) {
      log('Error: $err');
      return searchedPeopleList;
    }
  }
}
