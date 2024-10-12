import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/models/event_model.dart';
import 'package:flutter_psu_course_review/repositories/event/event_repository.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  final List<EventModel> emptyEventList = [];

  EventBloc({required this.eventRepository}) : super(LoadingEventState()) {
    on<LoadEventEvent>(_onLoadedEvent);
    on<LoadEventsEvent>(_onLoadedEvents);
    on<CreateEventEvent>(_onCreatedEvent);
    on<UpdateEventEvent>(_onUpdatedEvent);
    on<DeleteEventEvent>(_onDeletedEvent);
  }

  _onLoadedEvent(LoadEventEvent loadEvent, Emitter<EventState> emit) async {
    if (state is LoadingEventState) {
      final event = await eventRepository.getEvent(eventId: loadEvent.eventId);
      emit(ReadyEventState(event: event, events: emptyEventList));
    }
  }

  _onLoadedEvents(LoadEventsEvent loadEvents, Emitter<EventState> emit) async {
    if (state is LoadingEventState) {
      final events = await eventRepository.getEvents(page: loadEvents.page);
      emit(ReadyEventState(event: EventModel.empty(), events: events));
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
