
import 'package:Awoshe/logic/bloc/blog/blog_bloc_event_v2.dart';
import 'package:Awoshe/logic/bloc/blog/blog_bloc_state_v2.dart';
import 'package:Awoshe/logic/services/blog_service_v2.dart';
import 'package:Awoshe/models/blog/blog.dart';
import 'package:bloc/bloc.dart';

class BlogBlocV2 extends Bloc<BlogBlocEvent, BlogBlocState> {
  final BlogServiceV2 _service = BlogServiceV2();

  // if we're reading only one blog (get blog by id)
  // then this variable should be used.
  Blog currentBlog;
  // if we're reading all blogs (getAll)
  // then this list should be used.
  List<Blog> blogList;

  @override
  BlogBlocState get initialState => BlogBlocStateInit();

  @override
  Stream<BlogBlocState> mapEventToState(BlogBlocEvent event) async* {
    yield BlogBlocStateBusy(eventType: event.eventType);

    switch(event.eventType){
      case BlogBlocEvents.INIT:
        break;
      case BlogBlocEvents.UPLOAD:
        if (event is BlogBlocUpload){
          var blog = Blog(
            mainCategory: event.category,
            title: event.title,
            images: event.images,
            feedType: event.feedType,
            description: event.description,
            url: event.url,
            status: event.status,
          );

          try {
            _service.create(userId: event.userId, blog: blog);
            yield BlogBlocStateSuccess(eventType: event.eventType);
          }
          catch(ex){
            print('BlogBloc::UPLOAD EVENT:: $ex');
            yield BlogBlocStateFail(eventType: event.eventType,
                message: 'Was not possible upload');
          }
        }
        break;
      case BlogBlocEvents.UPDATE:
        if (event is BlogBlocUpdate) {
          try {
            currentBlog.images = event.images ?? currentBlog.images;
            currentBlog.feedType = event.feedType ?? currentBlog.feedType;
            currentBlog.url = event.url ?? currentBlog.url;
            currentBlog.description =
                event.description ?? currentBlog.description;
            currentBlog.title = event.title ?? currentBlog.title;
            currentBlog.mainCategory =
                event.category ?? currentBlog.mainCategory;
            currentBlog.status = event.status ?? currentBlog.status;
            _service.update(userId: event.userId, blog: currentBlog);
            yield BlogBlocStateSuccess(eventType: event.eventType);
          }
          catch (ex) {
            print('BlogBloc::UPDATE EVENT:: $ex');
            yield BlogBlocStateFail(eventType: event.eventType,
                message: 'Was not possible update the blog');
          }
        }
        break;
      case BlogBlocEvents.READ:
        if (event is BlogBlocRead){
          try {
            currentBlog = await _service.getBlogById(
                userId: event.userId, blogId: event.id);

            if (currentBlog != null)
              yield BlogBlocStateSuccess(eventType: event.eventType);

            else
              yield BlogBlocStateFail(eventType: event.eventType,
                  message: 'Was not possible read the blog');
          }
          catch(ex) {
            print('BlogBloc::READ EVENT:: $ex');
            yield BlogBlocStateFail(eventType: event.eventType,
                message: 'Was not possible read the blog');
          }
        }
        break;

      case BlogBlocEvents.READ_ALL:
        if (event is BlogBlocReadAll){
          try {
            blogList = await _service.getAll(userId: event.userId);

            if (currentBlog != null)
              yield BlogBlocStateSuccess(eventType: event.eventType);

            else
              yield BlogBlocStateFail(eventType: event.eventType,
                  message: 'Was not possible read all the blogs');
          }
          catch(ex){
            print('BlogBloc::READ_ALL EVENT:: $ex');
            yield BlogBlocStateFail(eventType: event.eventType,
                message: 'Was not possible read all the blogs');
          }
        }
        break;

      case BlogBlocEvents.DELETE:
        if (event is BlogBlocDelete){
          try{
            await _service.delete(userId: event.userId, blogId: event.id);
            yield BlogBlocStateSuccess(eventType: event.eventType);
          }
          catch(ex){
            print('BlogBloc::DELETE EVENT:: $ex');
            yield BlogBlocStateFail(eventType: event.eventType,
                message: 'Was not possible delete the blog');
          }
        }
        break;
    }
  }

}