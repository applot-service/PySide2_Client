import sys

from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine
from modules.Applot import Application as ApplotApplication

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)

    applot_app = ApplotApplication(engine)
    applot_app.set_context_property()

    app.setWindowIcon(QIcon("applot_icon.png"))

    engine.load('qml/main.qml')
    sys.exit(app.exec_())
