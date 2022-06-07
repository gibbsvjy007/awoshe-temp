
import 'package:Awoshe/logic/api/miscellaneous_api.dart';
import 'package:Awoshe/models/plan/Plan.dart';

class PlanService {


  /// Get all Awoshe plans subscription options.
  Future< List<Plan> > getAllPlans() async {

    try {
      List< dynamic > data = (await MiscellaneousApi.getSubscriptionPlans() )['data'];

      return data.map(  (plan) => Plan.fromJson(plan) ).toList();
    }

    catch(ex){
      print('Error in PlanService::getAllPlans $ex');
      return [];
    }
  }
}