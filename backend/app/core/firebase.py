import firebase_admin
from firebase_admin import credentials, messaging

def init_firebase(service_account_path: str):
    cred = credentials.Certificate(service_account_path)
    firebase_admin.initialize_app(cred)

def send_push_notification(token: str, title: str, body: str, data: dict = None):
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        token=token,
        data=data,
    )
    response = messaging.send(message)
    return response
