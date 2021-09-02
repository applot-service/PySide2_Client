from dataclasses import dataclass, field, asdict
from modules.domain.actions import projects as projects_actions

from typing import Optional


@dataclass
class BaseProject:
    project_id: str = field(default=None)
    title: str = field(default="Project title")
    description: str = field(default="This is project description...")
    last_updated: str = field(default="Date when last updated")
    entity_created_date: str = field(default=None)
    participants: str = field(default=None)

    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, source: dict) -> "BaseProject":
        return cls(
            project_id=source.get("project_id"),
            title=source.get("title"),
            description=source.get("description"),
            last_updated=source.get("last_updated"),
            entity_created_date=source.get("entity_created_date"),
            participants=source.get("participants"),
        )

    @classmethod
    def create_empty_project(cls) -> Optional["BaseProject"]:
        project_dict = projects_actions.create_empty_project()
        if project_dict:
            return cls.from_dict(project_dict)
        return None
