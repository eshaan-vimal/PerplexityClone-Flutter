from google import genai

from config import Settings


settings = Settings()


class LLMService:

    def __init__(self):
        self.client = genai.Client(api_key=settings.LLM_KEY)

    def generate_ws_response (self, query: str, search_results: list[dict]):

        print("ws_response")
        
        context = '\n\n'.join([
            f"Source {i+1} ({result.get('url', '')}): \n{result.get('content', '')}"
            for i, result in enumerate(search_results)
        ])

        prompt = f"""
            Query:
            {query}

            Context from web search:
            {context}
            
            Please provide a comprehensive, detailed, well-cited and accurate response for the mentioned query using the provided context and sources. 
            Think and reason deeply, while ensuring that the user receives a correct and satisfactory answer to their query.
        """

        response = self.client.models.generate_content_stream(
            model = 'gemini-2.0-flash-lite',
            contents = [prompt],
        )

        for chunk in response:
            yield chunk

    def generate_response (self, query: str, search_results: list[dict]):
        
        context = '\n\n'.join([
            f"Source {i+1} ({result.get('url', '')}): \n{result.get('content', '')}"
            for i, result in enumerate(search_results)
        ])

        prompt = f"""
            Query:
            {query}

            Context from web search:
            {context}
            
            Please provide a comprehensive, detailed, well-cited and accurate response for the mentioned query using the provided context and sources. 
            Think and reason deeply, while ensuring that the user receives a correct and satisfactory answer to their query.
        """

        response = self.client.models.generate_content(
            model = 'gemini-2.0-flash-lite',
            contents = [prompt],
        )

        return response.text

