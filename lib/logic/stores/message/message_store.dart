import 'package:Awoshe/logic/api/message_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/messages/chat.dart';
import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

const int CHATS_FETCH_LIMIT = 10;

abstract class _MessageStore with Store {
  @observable
  bool loading = false;

  @observable
  bool allChatsFetched = false;

  int fetchChatsPage = 0;

  @observable
  ObservableList<Chat> chats = ObservableList<Chat>();

  ObservableList<Chat> filteredChats = ObservableList<Chat>();

  @action
  void setLoading(bool l) {
    loading = l;
  }

  @action
  void setChats(List<Chat> c) {
    chats.addAll(c);
  }

  @action
  void setFilteredChats(List<Chat> c) {
    filteredChats.addAll(c);
    print(c.length);
    print(filteredChats.length);
  }

  Future<void> fetchUserChats({String userId}) async {
    
    try {
      setLoading(true);

      RestServiceResponse response = await MessageApi.fetchUserChats(
        userId: userId, page: fetchChatsPage, limit: CHATS_FETCH_LIMIT);
      
      if (response.success) {
        final List<Chat> allChats = response.content.map<Chat>((c) {
          print(c);
          return Chat.fromJson(c);
        }).toList();
        
        setChats(allChats);
        fetchChatsPage++;
        
        if (allChats.length < CHATS_FETCH_LIMIT) {
          allChatsFetched = true;
        }
      }
    } 

    catch(ex){
      setChats([]);
      allChatsFetched = false;
    }
    setLoading(false);
  }
}
