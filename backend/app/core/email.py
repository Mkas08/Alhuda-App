import random
import string
from pathlib import Path
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, MessageType
from pydantic import EmailStr
from app.config import settings

conf = ConnectionConfig(
    MAIL_USERNAME=settings.SMTP_USER,
    MAIL_PASSWORD=settings.SMTP_PASSWORD,
    MAIL_FROM=settings.EMAILS_FROM_EMAIL,
    MAIL_PORT=settings.SMTP_PORT,
    MAIL_SERVER="smtp.gmail.com", # Default to Gmail as per user creds
    MAIL_STARTTLS=settings.SMTP_TLS,
    MAIL_SSL_TLS=settings.SMTP_SSL,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=True
)

class EmailService:
    @staticmethod
    def generate_otp(length: int = 6) -> str:
        """Generate a random 6-digit OTP."""
        return ''.join(random.choices(string.digits, k=length))

    @staticmethod
    async def send_reset_email(email_to: EmailStr, otp: str):
        """Send password reset email with OTP."""
        html = f"""
        <html>
            <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
                <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                    <h2 style="color: #10B981; text-align: center;">Password Reset Request</h2>
                    <p style="font-size: 16px; color: #333;">As-salamu alaykum,</p>
                    <p style="font-size: 16px; color: #333;">You have requested to reset your password for the Al-Huda app.</p>
                    <div style="background-color: #F0FDF4; padding: 15px; border-left: 4px solid #10B981; margin: 20px 0;">
                        <p style="font-size: 14px; color: #064E3B; margin: 0;">Your Verification Code:</p>
                        <p style="font-size: 32px; font-weight: bold; color: #065F46; margin: 10px 0; letter-spacing: 5px;">{otp}</p>
                    </div>
                    <p style="font-size: 14px; color: #666;">This code will expire in 15 minutes. If you did not request this change, please ignore this email.</p>
                </div>
            </body>
        </html>
        """

        message = MessageSchema(
            subject="Al-Huda Password Reset Code",
            recipients=[email_to],
            body=html,
            subtype=MessageType.html
        )

        fm = FastMail(conf)
        await fm.send_message(message)
