load('ClusteringResult.mat');

motivation = cellstr(motivation);

% the motivation if not defined
% motivation = {'enterprise', ...
% 				'business',...
% 				'solution',...
% 				'entrepreneur',...
% 				'latent',...
% 				'problem',...
% 				'funds',...
% 				'management',...
% 				'quality',...
% 				'projects'}

motivation = {'enterprise', ...
				'factor',...
				'influence',...
				'entrepreneur'};

				
% the cell array used nearest 100 words
str_cell = cell(1, size(index, 1));
for idx = 1:size(index, 1)
	
	tmp_str_cell =  cellstr(squeeze(index(idx,:, :)));
	str_cell{idx} = tmp_str_cell;
end

% the vector used for clustering
[motivation_size, amount_nearest, vector_size] = size(vector);
labels = 1:motivation_size;
mlabels = labels;	% define the motivation label
labels = repmat(labels, [amount_nearest, 1]);
labels = reshape(labels', [motivation_size*amount_nearest, 1]);
labels = [mlabels'; labels];
input2tsne = reshape(vector, [motivation_size*amount_nearest, vector_size]);
input2tsne = [mVector; input2tsne];
output2tsne = tsne(input2tsne, labels, 2, 30, 20, motivation);

% generate the animation and save the final figure
savefig(gcf, 'result.fig');
