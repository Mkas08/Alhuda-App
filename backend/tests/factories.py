import factory
from factory.alchemy import SQLAlchemyModelFactory
from app.models.user import User

class UserFactory(SQLAlchemyModelFactory):
    class Meta:
        model = User
        sqlalchemy_get_or_create = ("email",)

    user_id = factory.Faker("uuid4")
    email = factory.Faker("email")
    username = factory.Faker("user_name")
    password_hash = "hashed_password"  # Mocked
    is_active = True
