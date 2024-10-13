import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/repositories/event/event_repository.dart';
import 'package:flutter_psu_course_review/utilities/utilities.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  List<EventModel> allEventList = [];
  List<EventModel> myEventList = [];
  List<EventModel> categoryEventList = [];
  EventModel eventModel = EventModel.empty();

  EventBloc({required this.eventRepository}) : super(LoadingEventState()) {
    on<LoadEventEvent>(_onLoadedEvent);
    on<LoadEventsEvent>(_onLoadedEvents);
    on<LoadMyEventsEvent>(_onLoadedMyEvents);
    on<LoadEventsByCategoryEvent>(_onLoadedEventsByCategory);
    on<SearchCategotyEventsEvent>(_onSearchedCategoryEvents);
    on<SearchMyEventsEvent>(_onSearchedMyEvents);
    on<SearchClearEvent>(_onSearchedClear);
    on<SelectEventEvent>(_onSelectedEvent);
    on<SelectCategoryEvent>(_onSelectedCategory);
    on<CreateEventEvent>(_onCreatedEvent);
    on<UpdateEventEvent>(_onUpdatedEvent);
    on<DeleteEventEvent>(_onDeletedEvent);
  }

  _onLoadedEvent(LoadEventEvent loadEvent, Emitter<EventState> emit) async {
    eventModel = await eventRepository.getEvent(eventId: loadEvent.eventId);
    emit(ReadyEventState(
        event: eventModel,
        myEvents: myEventList,
        categoryEvents: categoryEventList,
        events: allEventList));
  }

  _onLoadedEvents(LoadEventsEvent loadEvents, Emitter<EventState> emit) async {
    allEventList = await eventRepository.getEvents(page: loadEvents.page);
    emit(ReadyEventState(
        event: eventModel,
        myEvents: myEventList,
        categoryEvents: categoryEventList,
        events: allEventList));
  }

  _onLoadedMyEvents(
      LoadMyEventsEvent loadMyEvents, Emitter<EventState> emit) async {
    myEventList = await eventRepository.getMyEvents(page: loadMyEvents.page);
    emit(ReadyEventState(
        event: eventModel,
        myEvents: myEventList,
        categoryEvents: categoryEventList,
        events: allEventList));
  }

  _onLoadedEventsByCategory(LoadEventsByCategoryEvent loadEventsByCategory,
      Emitter<EventState> emit) async {
    categoryEventList = await eventRepository.getEvents(
      page: loadEventsByCategory.page,
    );
    categoryEventList = categoryEventList
        .where((event) => event.category == loadEventsByCategory.category)
        .toList();
    emit(ReadyEventState(
        event: eventModel,
        myEvents: myEventList,
        categoryEvents: categoryEventList,
        events: allEventList));
  }

  _onSearchedCategoryEvents(
      SearchCategotyEventsEvent searchEvents, Emitter<EventState> emit) async {
    final filteredmyEventList = categoryEventList
        .where((event) => event.eventTitle
            .toLowerCase()
            .contains(searchEvents.searchQuery.toLowerCase()))
        .toList();
    emit(ReadyEventState(
        event: eventModel,
        myEvents: myEventList,
        categoryEvents: filteredmyEventList,
        events: allEventList));
  }

  _onSearchedMyEvents(
      SearchMyEventsEvent searchMyEvents, Emitter<EventState> emit) async {
    final filteredmyEventList = await eventRepository.searchMyEvents(
      searchQuery: searchMyEvents.searchQuery,
      page: searchMyEvents.page,
    );
    emit(ReadyEventState(
        event: eventModel,
        myEvents: filteredmyEventList,
        categoryEvents: categoryEventList,
        events: allEventList));
  }

  _onSearchedClear(
      SearchClearEvent searchClear, Emitter<EventState> emit) async {
    allEventList = await eventRepository.getEvents(page: 1);
    myEventList = await eventRepository.getMyEvents(page: 1);
    emit(ReadyEventState(
        event: eventModel,
        myEvents: myEventList,
        categoryEvents: categoryEventList,
        events: allEventList));
  }

  _onSelectedEvent(
      SelectEventEvent selectEvent, Emitter<EventState> emit) async {
    if (state is ReadyEventState) {
      emit(LoadingEventState(
          isMyEvent: isMyEvent(selectEvent.eventUserId, selectEvent.myUserId)));
      add(LoadEventEvent(eventId: selectEvent.eventId));
    }
  }

  _onSelectedCategory(
      SelectCategoryEvent selectCategory, Emitter<EventState> emit) async {
    emit(LoadingEventState());
    add(LoadEventsByCategoryEvent(category: selectCategory.category, page: 1));
  }

  _onCreatedEvent(
      CreateEventEvent createEvent, Emitter<EventState> emit) async {
    if (state is ReadyEventState) {
      final response = await eventRepository.createEvent(
        eventTitle: createEvent.eventTitle,
        eventDescription: createEvent.eventDescription,
        eventDate: createEvent.eventDate,
        category: createEvent.category,
      );
      emit(LoadingEventState(responseText: response));
      add(LoadEventsEvent());
      add(LoadMyEventsEvent());
    }
  }

  _onUpdatedEvent(
      UpdateEventEvent updateEvent, Emitter<EventState> emit) async {
    if (state is ReadyEventState) {
      final response = await eventRepository.updateEvent(
        eventTitle: updateEvent.eventTitle,
        eventDescription: updateEvent.eventDescription,
        eventDate: updateEvent.eventDate,
        category: updateEvent.category,
        likesAmount: updateEvent.likesAmount,
        eventId: updateEvent.eventId,
      );
      emit(LoadingEventState(responseText: response));
      add(LoadEventsEvent());
      add(LoadMyEventsEvent());
      add(LoadEventEvent(eventId: updateEvent.eventId));
    }
  }

  _onDeletedEvent(
      DeleteEventEvent deleteEvent, Emitter<EventState> emit) async {
    if (state is ReadyEventState) {
      final response = await eventRepository.deleteEvent(
        eventId: deleteEvent.eventId,
      );
      emit(LoadingEventState(responseText: response));
      add(LoadEventsEvent());
      add(LoadMyEventsEvent());
    }
  }
}
