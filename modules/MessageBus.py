import json

from PySide2 import QtWebSockets
from PySide2.QtCore import QUrl, QTimer, QObject

from modules.Events import Handler as EventsHandler


class Client(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.events_handler = None
        self.client = QtWebSockets.QWebSocket("", QtWebSockets.QWebSocketProtocol.Version13, None)
        self.client.textMessageReceived.connect(self._on_event)
        self.client.error.connect(self._on_error)
        self.client.pong.connect(self._on_pong)

    def enable_event_handling(self, application):
        self.events_handler = EventsHandler(application=application)
        self.client.open(QUrl("wss://oa6f4xkird.execute-api.us-east-1.amazonaws.com/Prod"))
        QTimer.singleShot(2000, self.t_post)
        self.pong_timer = QTimer()
        self.pong_timer.setInterval(20000)
        self.pong_timer.timeout.connect(self._ping)
        self.pong_timer.start()

    def _on_event(self, event):
        print("Received event:", event)

    def _on_error(self, error_code):
        print("error code: {}".format(error_code))
        print(self.client.errorString())

    def _close(self):
        self.client.close()

    def post(self, command):
        self.client.sendTextMessage(json.dumps({
            "action": "send_command",
            "command": "authorize_user"
        }))

    def t_post(self):
        self.client.sendTextMessage(json.dumps({"action": "send_command"}))

    def _ping(self):
        print("client: Ping")
        self.client.ping(b"pinging connection")

    def _on_pong(self, elapsedTime, payload):
        print("onPong - time: {} ; payload: {}".format(elapsedTime, payload))

    def _on_received_message(self):
        pass


    def send_message(self, data):
        print("client: send_message")
        self.client.sendBinaryMessage(data)