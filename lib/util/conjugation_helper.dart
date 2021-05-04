class ConjugationHelper {

  static String postsConjugation(int numberOfPosts) {
    if (numberOfPosts == 0) {
      return 'postów';
    } else if (numberOfPosts == 1) {
      return 'post';
    } else if (numberOfPosts > 10 && numberOfPosts < 20) {
      return 'postów';
    } else if (numberOfPosts % 10 == 2 || numberOfPosts % 10 == 3 || numberOfPosts % 10 == 4) {
      return 'posty';
    } else {
      return 'postów';
    }
  }

  static String likesConjugation(int numberOfLikes) {
    if (numberOfLikes == 0) {
      return 'polubień';
    } else if (numberOfLikes == 1) {
      return 'polubienie';
    } else if (numberOfLikes > 10 && numberOfLikes < 20) {
      return 'polubień';
    } else if (numberOfLikes % 10 == 2 || numberOfLikes % 10 == 3 || numberOfLikes % 10 == 4) {
      return 'polubień';
    } else {
      return 'postów';
    }
  }

}