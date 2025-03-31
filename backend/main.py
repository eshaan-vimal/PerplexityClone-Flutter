from fastapi import FastAPI, WebSocket
import asyncio

from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_service import SortService
from services.llm_service import LLMService


app = FastAPI()
search_service = SearchService()
sort_service = SortService()
llm_service = LLMService()


@app.websocket('/ws/chat')
async def ws_chat (websocket: WebSocket):

    await websocket.accept()

    try:
        await asyncio.sleep(0.01)
        data = await websocket.receive_json()
        body = data.get('query')

        if not body:
            raise Exception('Query not provided')
        
        search_results, results = search_service.search_web(body)
        await asyncio.sleep(0.01)
        sorted_results = sort_service.sort_sources(body.query, search_results)
        await websocket.send_json({
            'type': 'sources',
            'data': results,
        })

        
        response = llm_service.generate_ws_response(body, sorted_results)

        for chunk in response:
            asyncio.sleep(0.01)
            await websocket.send_json({
                'type': 'response',
                'data': chunk.text,
            })


    except Exception as e:
        print(e)

    finally:
        await websocket.close()


@app.post('/chat')
def chat (body: ChatBody):

    search_results, results = search_service.search_web(body.query)
    sorted_results = sort_service.sort_sources(body.query, search_results)
    response = llm_service.generate_response(body.query, sorted_results)

    return response