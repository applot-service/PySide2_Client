from modules.domain.entities import User


class Data:

    def __init__(self):
        self.account = User.Account()
        self.token = None
