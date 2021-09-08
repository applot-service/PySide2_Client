class SettingsActions:
    def __init__(self, settings):
        self._settings = settings

    def save_account_sign_in_data(self, token, email):
        self._settings.setValue("token", token)
        self._settings.setValue("email", email)

    def remove_account_sign_in_data(self):
        self._settings.remove("token")
        self._settings.remove("email")

    def get_account_token(self):
        return self._settings.value("token")

    def get_account_email(self):
        return self._settings.value("email")
