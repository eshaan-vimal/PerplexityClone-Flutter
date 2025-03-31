from sentence_transformers import SentenceTransformer
import numpy as np


class SortService:

    def __init__(self):
        self.embedding_model = SentenceTransformer('all-miniLM-L6-v2')

    def sort_sources(self, query: str, search_results: list[dict]):

        relevant_results = []
        query_embedding = self.embedding_model.encode(query)
        
        for result in search_results:
            result_embedding = self.embedding_model.encode(result)

            similarity = float(np.dot(query_embedding, result_embedding) / (np.linalg.norm(query_embedding) * np.linalg.norm(result_embedding)))
            result['relevance_score'] = similarity

            if (similarity > 0.3):
                relevant_results.append(result)

        relevant_results.sort(key=lambda x: x['relevance_score'], reverse=True)
        return relevant_results