from collections import defaultdict
from ApplotLibs.DataStructures.MessageBus.Events import Account as AccountEvents
from ApplotLibs.DataStructures.MessageBus.Events import Projects as ProjectsEvents

from modules.EventHandlers import Account as AccountEventHandlers
from modules.EventHandlers import Projects as ProjectsEventHandlers


class EventDeserializator:
    # Building event from source
    def __init__(self):
        self.event_classes = defaultdict(dict)
        self._set_up_account_events()
        self._set_up_projects_events()

    def _set_up_account_events(self):
        self.event_classes["Account"]["SignedIn"] = AccountEvents.SignedIn
        self.event_classes["Account"]["NotFound"] = AccountEvents.NotFound
        self.event_classes["Account"]["SignedOut"] = AccountEvents.SignedOut
        self.event_classes["Account"]["Registered"] = AccountEvents.Registered
        self.event_classes["Account"]["EmailAlreadyInUse"] = AccountEvents.EmailAlreadyInUse

    def _set_up_projects_events(self):
        pass

    def build_class(self, event_source: dict):
        event_type = event_source.get("event_type")
        event_action= event_source.get("event_action")
        print("EVENT TYPE:", event_type, "ACTION:", event_action)
        event_class = self.event_classes[event_type][event_action]
        print("EVENT CLASS:", event_class)
        if not event_class:
            raise Exception
        return event_class.from_dict(event_source)


class Router:
    # Routing command source, executing command
    def __init__(self, event_source):
        self.event_source = event_source
        self.event_instance = None

        self.event_handlers = defaultdict(dict)
        self._set_up_account_handlers()
        self._set_up_projects_handlers()

    def _set_up_account_handlers(self):
        self.event_handlers["Account"]["SignedIn"] = AccountEventHandlers.signed_in
        self.event_handlers["Account"]["NotFound"] = AccountEventHandlers.not_found
        self.event_handlers["Account"]["SignedOut"] = AccountEventHandlers.signed_out
        self.event_handlers["Account"]["Registered"] = AccountEventHandlers.registered
        self.event_handlers["Account"]["EmailAlreadyInUse"] = AccountEventHandlers.email_already_in_use

    def _set_up_projects_handlers(self):
        self.event_handlers["Projects"]["Pulled"] = None  # "ProjectsCommandHandlers.Pull"
        self.event_handlers["Projects"]["CreatedProject"] = None  # "ProjectsCommandHandlers.CreateProject"

    def create_event(self):
        self.event_instance = EventDeserializator().build_class(event_source=self.event_source)
        print("EVENT INSTANCE:", self.event_instance)
        return self

    def process_event(self):
        event_type = self.event_instance.event_type
        event_action = self.event_instance.event_action
        event_handler = self.event_handlers[event_type][event_action]
        if not event_handler:
            raise Exception
        return event_handler(self.event_instance)
