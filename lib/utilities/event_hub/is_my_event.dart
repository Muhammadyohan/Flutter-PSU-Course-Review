bool isMyEvent(int eventUserId, int myUserId) {
  if (eventUserId != myUserId) {
    return false;
  }
  return true;
}
