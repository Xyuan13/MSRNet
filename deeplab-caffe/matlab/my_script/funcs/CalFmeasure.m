function [ ratio ] = CalFmeasure(precision, recall, beta_square)
  ratio = (1+beta_square) * precision .* recall;
  denominator = beta_square*precision + recall;
  
  ratio = ratio ./ denominator;
end