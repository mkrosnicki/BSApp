class AdderInfoModel {
  final String id;
  final String username;
  final DateTime registeredAt;
  final int addedDeals;
  final int addedComments;
  final int addedPosts;


  AdderInfoModel(
      {this.id,
      this.username,
      this.registeredAt,
      this.addedDeals,
      this.addedComments,
      this.addedPosts});

  static AdderInfoModel of(dynamic adderInfoSnapshot) {
    return AdderInfoModel(
        id: adderInfoSnapshot['id'],
        username: adderInfoSnapshot['username'],
        registeredAt: DateTime.parse(adderInfoSnapshot['registeredAt']),
        addedDeals: adderInfoSnapshot['addedDeals'],
        addedComments: adderInfoSnapshot['addedComments'],
        addedPosts: adderInfoSnapshot['addedPosts'],
    );
  }
}