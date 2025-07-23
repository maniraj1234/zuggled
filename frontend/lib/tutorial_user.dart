import 'package:stream_video_flutter/stream_video_flutter.dart';

class TutorialUser {
  const TutorialUser({required this.user, required this.token});

  final User user;
  final String? token;

  factory TutorialUser.user2() => TutorialUser(
    user: User.regular(
      userId: 'zK8Y4fTYAOXa2WDDVjekzXzHJO92',
      name: 'Mohamed Sameer',
      image:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    token:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoieks4WTRmVFlBT1hhMldERFZqZWt6WHpISk85MiJ9.SGJ8lO-d_w-KsSVRgtMkpvRF5rBGvW2KERDUqR2TaPU',
  );

  factory TutorialUser.user1() => TutorialUser(
    user: User.regular(
      userId: '6OLq7ZaPmKUZpsQYsqL67lfl83p2',
      name: 'Dhusinth N',
      image:
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    token:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNk9McTdaYVBtS1VacHNRWXNxTDY3bGZsODNwMiJ9.GN8yDGWMEd8yfFdt7RNYuJDxVYpxoYI44ctWZF5ROgE',
  );

  static List<TutorialUser> get users => [TutorialUser.user2()];
}
