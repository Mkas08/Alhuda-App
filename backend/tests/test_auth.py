import pytest
from httpx import AsyncClient

@pytest.mark.asyncio
async def test_register_user(client: AsyncClient):
    response = await client.post(
        "/api/v1/auth/register",
        json={
            "email": "test@example.com",
            "username": "testuser",
            "password": "TestPassword123", # Meets complexity
        },
    )
    assert response.status_code == 200
    data = response.json()
    assert data["email"] == "test@example.com"
    assert "user_id" in data

@pytest.mark.asyncio
async def test_register_user_weak_password(client: AsyncClient):
    response = await client.post(
        "/api/v1/auth/register",
        json={
            "email": "weak@example.com",
            "username": "weakuser",
            "password": "password", # Fails complexity
        },
    )
    assert response.status_code == 422 # Validation error

@pytest.mark.asyncio
async def test_login_user(client: AsyncClient):
    # First, register a user
    await client.post(
        "/api/v1/auth/register",
        json={
            "email": "logintest@example.com",
            "username": "loginuser",
            "password": "LoginPassword123",
        },
    )
    
    # Then, login
    response = await client.post(
        "/api/v1/auth/login",
        data={
            "username": "loginuser",
            "password": "LoginPassword123",
        },
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data
    assert data["token_type"] == "bearer"

@pytest.mark.asyncio
async def test_refresh_token(client: AsyncClient):
    # Register and login
    await client.post(
        "/api/v1/auth/register",
        json={
            "email": "refreshtest@example.com",
            "username": "refreshuser",
            "password": "RefreshPassword123",
        },
    )
    
    login_response = await client.post(
        "/api/v1/auth/login",
        data={"username": "refreshuser", "password": "RefreshPassword123"},
    )
    refresh_token = login_response.json()["refresh_token"]
    
    # Refresh
    response = await client.post(
        "/api/v1/auth/refresh",
        json={"refresh_token": refresh_token},
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data
@pytest.mark.asyncio
async def test_get_me(client: AsyncClient):
    # Register and login to get token
    await client.post(
        "/api/v1/auth/register",
        json={
            "email": "metest@example.com",
            "username": "meuser",
            "password": "MePassword123",
        },
    )
    
    login_response = await client.post(
        "/api/v1/auth/login",
        data={"username": "meuser", "password": "MePassword123"},
    )
    token = login_response.json()["access_token"]
    
    # Get /me
    response = await client.get(
        "/api/v1/auth/me",
        headers={"Authorization": f"Bearer {token}"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["username"] == "meuser"
