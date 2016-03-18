# step 1 install word2vec (ref: http://nbviewer.jupyter.org/github/danielfrg/word2vec/blob/master/examples/word2vec.ipynb)
import word2vec
import numpy as np
import scipy.io as sio

vector_size = 100
amount_nearest = 100

word2vec.word2phrase('text8', 'text8-phrases', verbose=True)
word2vec.word2vec('text8-phrases', 'text8.bin', size=vector_size, verbose=True)
word2vec.word2clusters('text8', 'text8-clusters.txt', vector_size, verbose=True)

# read the trained model
model = word2vec.load('text8.bin')

# list of vague motivation coming from mind (topic: potential problems for enterprise)
motivation = ['enterprise', \
				'business',\
				'solution',\
				'entrepreneur',\
				'latent',\
				'problem',\
				'funds',\
				'management',\
				'quality',\
				'projects']
							
# start get nearest clusters by picking the similar words
amount_motivation = len(motivation)
motivation_vector = []
nearest_indexes = []
nearest_metrics = []
nearest_vector = []

for motivation_word in motivation:
	# get the vector of motivation
	motivation_vector.append(model.get_vector(motivation_word))
	indexes, metrics = model.cosine(motivation_word, amount_nearest)
	nearest_indexes.append(model.vocab[indexes])
	nearest_metrics.append(metrics)
	nearest_vector.append(model.vectors[indexes])
	 
sio.savemat('ClusteringResult.mat', \
			{'index': nearest_indexes, \
			'metric': nearest_metrics, \
			'vector': nearest_vector, \
			'mVector': motivation_vector, \
			'motivation': motivation})
	 