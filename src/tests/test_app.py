import pytest
from src.app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_get_string_default(client):
    """Test the default string value."""
    response = client.get('/api/string')
    assert response.status_code == 200
    assert response.json['string'] == "Hello, World! (Default)"

def test_post_string_update(client):
    """Test updating the string via POST."""
    new_string = "Testing 123"
    response = client.post('/api/string', json={'string': new_string})
    assert response.status_code == 200
    assert response.json['string'] == new_string
    
    # Verify the GET reflects the change
    response = client.get('/api/string')
    assert response.json['string'] == new_string

def test_post_string_missing_payload(client):
    """Test error handling for missing payload."""
    response = client.post('/api/string', json={})
    assert response.status_code == 400
    assert "error" in response.json

def test_index_renders(client):
    """Test the index page loads."""
    response = client.get('/')
    assert response.status_code == 200
