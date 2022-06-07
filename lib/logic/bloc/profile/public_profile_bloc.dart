import 'package:Awoshe/pages/profile/public/public_profile_page.dart';
import 'package:rxdart/rxdart.dart';

class PublicProfileBloc  {
  final BehaviorSubject<Tabs> _tabSubject = BehaviorSubject.seeded(Tabs.DESIGNS);
  Observable<Tabs> get tabStream => _tabSubject.stream;
  PublicProfileBloc() : super();


  void goToTab(Tabs tab) => _tabSubject.sink.add(tab);

  void dispose() {
    _tabSubject?.close();
  }

}
