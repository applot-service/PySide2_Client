import json

from PySide2 import QtWebSockets
from PySide2.QtCore import QUrl, QTimer, QObject

from modules.EventHandlers import Router


class Client(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.events_handler = None
        self.client = QtWebSockets.QWebSocket("", QtWebSockets.QWebSocketProtocol.Version13, None)
        self.client.textMessageReceived.connect(self.on_event)
        self.client.error.connect(self.on_error)
        self.client.pong.connect(self.on_pong)

    def enable_event_handling(self, application):
        # self.events_handler = EventsHandler(application=application)
        self.client.open(QUrl("wss://oa6f4xkird.execute-api.us-east-1.amazonaws.com/Prod"))
        self.pong_timer = QTimer()
        self.pong_timer.setInterval(20000)
        self.pong_timer.timeout.connect(self._ping)
        self.pong_timer.start()

    def post(self, command):
        print(">> COMMAND:", command)
        print(">> DICT COMMAND:", json.dumps(command.to_dict()))
        self.client.sendTextMessage(json.dumps(command.to_dict()))

    def on_event(self, event):
        print("Received event:", event)
        if event:
            event_source = json.loads(event)
            router = Router(event_source=event_source).create_event()
            processed_event = router.process_event()

    def on_error(self, error_code):
        print("error code: {}".format(error_code))
        print(self.client.errorString())

    def on_pong(self, elapsedTime, payload):
        print("onPong - time: {} ; payload: {}".format(elapsedTime, payload))

    def close(self):
        self.client.close()

    def _ping(self):
        print("client: Ping")
        self.client.ping(b"pinging connection")
