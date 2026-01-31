import asyncio
import aiohttp
import json

async def main():
    async with aiohttp.ClientSession() as session:
        url = "https://api.quran.com/api/v4/quran/translations/20?chapter_number=1"
        print(f"Fetching {url}...")
        async with session.get(url) as resp:
            data = await resp.json()
            if "translations" in data and data["translations"]:
                t = data["translations"][0]
                print(f"First translation item keys: {list(t.keys())}")
                # Print safe representation
                print(f"Sample item: {json.dumps(t, ensure_ascii=True)}")
            else:
                print("No translations found or different structure:", data.keys())

if __name__ == "__main__":
    asyncio.run(main())
