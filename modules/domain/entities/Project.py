from dataclasses import dataclass, field, asdict
from modules.domain.actions import projects as projects_actions

from typing import Optional


@dataclass
class Project:
    project_id: str = field(default=None)
    title: str = field(default="Project title")
    description: str = field(default="This is project description...")
    last_updated: str = field(default="Date when last updated")
    participants: str = field(default=None)

    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, source: dict) -> "Project":
        return cls(**source)

    @classmethod
    def create_empty_project(cls) -> Optional["Project"]:
        project_dict = projects_actions.create_empty_project()
        if project_dict:
            return cls.from_dict(project_dict)
        return None
