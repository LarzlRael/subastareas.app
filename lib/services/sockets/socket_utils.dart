part of '../services.dart';

void disconnectEvents(SocketService socketService, int idRoom) {
  socketService.socket.emit('leaveOfferRoom', idRoom);
  socketService.socket.off('leaveOfferRoom');
  socketService.socket.off('makeOfferToClient');
  socketService.socket.off('deleteOffer');
  socketService.socket.off('editOffer');
}
