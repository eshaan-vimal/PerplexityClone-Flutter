from tavily import TavilyClient
import trafilatura

from config import Settings


settings = Settings()
tavily_client = TavilyClient(api_key=settings.SEARCH_KEY)

class SearchService:

    def search_web(self, query: str):

        search_results = []

        response = tavily_client.search(query, max_results=10)
        results = response.get('results', [])
        
        for result in results:

            raw_content = trafilatura.fetch_url(result.get('url'))
            clean_content = trafilatura.extract(raw_content, include_comments=False)
            
            search_results.append(
                {
                    'title': result.get('title', ''),
                    'url': result.get('url', ''),
                    'content': clean_content,
                }
            )
        
        return search_results, results
            
