"""Quick script to check available translations."""
import asyncio
import aiohttp

async def main():
    async with aiohttp.ClientSession() as session:
        # Check available translations
        async with session.get("https://api.quran.com/api/v4/resources/translations?language=en") as resp:
            data = await resp.json()
            print("Available English Translations:")
            for t in data.get("translations", [])[:20]:
                print(f"  ID {t['id']:3d}: {t['name']}")
        
        # Test a specific translation
        print("\nTesting translation with ID 20 (Sahih International):")
        async with session.get("https://api.quran.com/api/v4/quran/translations/20?chapter_number=1") as resp:
            data = await resp.json()
            if data.get("translations"):
                t = data["translations"][0]
                print(f"  Keys: {list(t.keys())}")
                print(f"  Sample: {t}")

if __name__ == "__main__":
    asyncio.run(main())
