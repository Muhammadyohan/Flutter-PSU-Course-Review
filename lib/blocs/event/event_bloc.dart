import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/repositories/event/event_repository.dart';
import 'package:flutter_psu_course_review/utilities/utilities.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  List<EventModel> allEventList = [];
  List<EventModel> myEventList = [];
  EventModel eventModel = EventModel.empty();

  EventBloc({required this.eventRepository}) : super(LoadingEventState()) {
    on<LoadEventEvent>(_onLoadedEvent);
    on<LoadEventsEvent>(_onLoadedEvents);
    on<LoadMyEventsEvent>(_onLoadedMyEvents);
    on<ActionEventEvent>(_onActionEvent);
    on<SelectEventEvent>(_onSelectedEvent);
    on<CreateEventEvent>(_onCreatedEvent);
    on<UpdateEventEvent>(_onUpdatedEvent);
    on<DeleteEventEvent>(_onDeletedEvent);
  }

  _onLoadedEvent(LoadEventEvent loadEvent, Emitter<EventState> emit) async {
    eventModel = await eventRepository.getEvent(eventId: loadEvent.eventId);
    emit(ReadyEventState(
        event: eventModel, myEvents: myEventList, events: allEventList));
  }

  _onLoadedEvents(LoadEventsEvent loadEvents, Emitter<EventState> emit) async {
    allEventList = await eventRepository.getEvents(page: loadEvents.page);
    emit(ReadyEventState(
        event: eventModel, myEvents: myEventList, events: allEventList));
  }

  _onLoadedMyEvents(
      LoadMyEventsEvent loadMyEvents, Emitter<EventState> emit) async {
    myEventList = await eventRepository.getMyEvents(page: loadMyEvents.page);
    emit(ReadyEventState(
        event: eventModel, myEvents: myEventList, events: allEventList));
  }

  _onActionEvent(ActionEventEvent actionEvent, Emitter<EventState> emit) async {
    emit(LoadingEventState());
  }

  _onSelectedEvent(
      SelectEventEvent selectEvent, Emitter<EventState> emit) async {
    if (state is ReadyEventState) {
      emit(LoadingEventState(
          isMyEvent: isMyEvent(selectEvent.eventUserId, selectEvent.myUserId)));
      add(LoadEventEvent(eventId: selectEvent.eventId));
    }
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
    }
  }
}
