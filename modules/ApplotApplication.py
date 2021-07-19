from modules.domain.aggregates import Auth


class Base:

    def __init__(self):
        self.auth = Auth.Data()
