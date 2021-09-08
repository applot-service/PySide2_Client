from PySide2 import QtWebSockets
from PySide2.QtCore import QUrl, QTimer, QObject

from modules.Events import Handler as EventsHandler


class Client(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.events_handler = None
        self.client = QtWebSockets.QWebSocket("", QtWebSockets.QWebSocketProtocol.Version13, None)
        self.client.error.connect(self._error)
        self.client.pong.connect(self._on_pong)

    def enable_event_handling(self, application):
        self.events_handler = EventsHandler(application=application)
        self.client.open(QUrl("ws://127.0.0.1:1302"))
        QTimer.singleShot(20000, self._ping)

    def post(self, command):
        print("Posted command:", command)

    def _ping(self):
        print("client: do_ping")
        self.client.ping(b"foo")

    def _on_pong(self, elapsedTime, payload):
        print("onPong - time: {} ; payload: {}".format(elapsedTime, payload))

    def _on_received_message(self):
        pass

    def _error(self, error_code):
        print("error code: {}".format(error_code))
        print(self.client.errorString())

    def _close(self):
        self.client.close()

    def send_message(self, data):
        print("client: send_message")
        self.client.sendBinaryMessage(data)