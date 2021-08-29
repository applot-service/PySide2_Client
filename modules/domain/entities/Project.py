from dataclasses import dataclass, field, asdict


@dataclass
class ProjectInfo:
    project_id: str = field(default=None)
    title: str = field(default="Project title")
    description: str = field(default="This is project description...")
    last_updated: str = field(default="Date when last updated")
    participants: str = field(default=None)

    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, source: dict) -> "ProjectInfo":
        return cls(**source)
