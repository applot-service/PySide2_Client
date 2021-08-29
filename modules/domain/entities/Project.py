from dataclasses import dataclass, field, asdict


@dataclass
class ProjectInfo:
    project_id: str = field(default=None)
    title: str = field(default=None)
    description: str = field(default=None)
    last_updated: str = field(default=None)
    participants: str = field(default=None)

    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, source: dict) -> "ProjectInfo":
        return cls(**source)