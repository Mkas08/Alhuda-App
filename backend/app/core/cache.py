import json
import functools
from typing import Any, Callable, Optional
from redis.asyncio import Redis
from fastapi import Request, Response
from app.api import deps

def cache_response(expire: int = 3600):
    """
    Cache FastAPI response in Redis.
    Note: Simple implementation for static data like Quran.
    """
    def decorator(func: Callable):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            # Try to find Request and Redis in kwargs or args
            request: Optional[Request] = kwargs.get("request")
            redis_client: Optional[Redis] = kwargs.get("redis")
            
            if not request or not redis_client:
                # Fallback to normal execution if deps missing
                return await func(*args, **kwargs)

            # Generate cache key from URL path and query params
            cache_key = f"cache:{request.url.path}:{str(request.query_params)}"
            
            # Try to get from cache
            cached = await redis_client.get(cache_key)
            if cached:
                return json.loads(cached)

            # Get fresh data
            result = await func(*args, **kwargs)
            
            # Store in cache
            if result:
                await redis_client.setex(
                    cache_key,
                    expire,
                    json.dumps(result, default=str)
                )
            
            return result
        return wrapper
    return decorator
