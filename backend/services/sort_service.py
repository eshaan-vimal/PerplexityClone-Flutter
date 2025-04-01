from sentence_transformers import SentenceTransformer
import numpy as np


class SortService:

    def __init__(self):
        self.embedding_model = SentenceTransformer('all-miniLM-L6-v2')

    def sort_sources(self, query: str, search_results: list[dict]):

        relevant_results = []
        query_embedding = self.embedding_model.encode(query)
        
        for result in search_results:

            if not result:
                continue
            
            content = result.get('content', '')
            if not content:
                continue

            result_embedding = self.embedding_model.encode(result.get('content', ''))
            result['relevance_score'] = float(np.dot(query_embedding, result_embedding) / (np.linalg.norm(query_embedding) * np.linalg.norm(result_embedding)))

            if (result['relevance_score'] > 0.3):
                relevant_results.append(result)

        relevant_results.sort(key=lambda x: x['relevance_score'], reverse=True)
        return relevant_results