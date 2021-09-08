from PySide2.QtCore import QObject, Signal, Slot
from ApplotLibs.DataStructures.MessageBus.Commands import Account as AccountCommands


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.message_bus = application.message_bus

    @Slot(str, str)
    def sign_in(self, email: str, password: str):
        sign_in_command = AccountCommands.SignIn(
            email=email,
            password=password
        )
        self.message_bus.post(sign_in_command)

    @Slot()
    def sign_out(self):
        sign_out_command = AccountCommands.SignOut(
            local=True
        )
        self.message_bus.post(sign_out_command)

    @Slot(str, str, str, str, str)
    def register(self, first_name: str, last_name: str,
                 company: str, email: str, password: str):
        register_command = AccountCommands.Register(
            first_name=first_name,
            last_name=last_name,
            company=company,
            email=email,
            password=password
        )
        self.message_bus.post(register_command)


# /////////////////////////////////
# def _sign_in(email: str, password: str):
#     return User.Account.sign_in(
#         email,
#         password
#     )
#
#
# def _register(first_name: str, last_name: str,
#               company: str, email: str, password: str):
#     return User.register(
#         first_name,
#         last_name,
#         company,
#         email,
#         password
#     )
#
#
# class Manager(QObject):
#     def __init__(self, application):
#         QObject.__init__(self)
#         self._settings = application.settings
#         self._thread_pool = application.thread_pool
#
#     # Slots
#     @Slot(str, str)
#     def sign_in(self, email: str, password: str):
#         worker = Worker(_sign_in, email=email, password=password)
#         worker.signals.result.connect(self.sign_in_result)
#         worker.signals.finished.connect(self.sign_in_finished)
#         worker.signals.error.connect(self.sign_in_error)
#
#         self._thread_pool.start(worker)
#
#     @Slot()
#     def sign_out(self):
#         self._settings.remove_account_sign_in_data()
#         self._token = None
#         self._email = None
#         self.token_changed.emit(self._token)
#         self.email_changed.emit(self._email)
#
#     @Slot(str, str, str, str, str)
#     def register(self, first_name: str, last_name: str,
#                  company: str, email: str, password: str):
#         worker = Worker(_register,
#                         first_name=first_name, last_name=last_name,
#                         company=company, email=email, password=password)
#         worker.signals.result.connect(self.register_result)
#         worker.signals.finished.connect(self.register_finished)
#         worker.signals.error.connect(self.register_error)
#
#         self._thread_pool.start(worker)
#
#     # Handlers
#     def sign_in_result(self, account):
#         self._account = None
#         if account:
#             self._account = account
#             self._token = account.token
#             self.token_changed.emit(self._token)
#
#             self._email = account.email
#             self.email_changed.emit(self._email)
#
#             self._settings.save_account_sign_in_data(self._token, self._email)
#
#     def sign_in_finished(self):
#         pass
#
#     def sign_in_error(self, err):
#         print("ERROR:", err)
#
#     def register_result(self):
#         print("REGISTER:")
#
#     def register_finished(self):
#         pass
#
#     def register_error(self, err):
#         print("ERROR:", err)


