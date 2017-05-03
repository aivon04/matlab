
%I am the first function
function ass2_2017(num_x)
    %Making a string to a number
    num_x = str2num(num_x);
    %Generate uniformly distributed random numbers
    x = rand(num_x,1,'double');
    %Generate normally distibuted random numbers
    y = randn(num_x,1,'double');

    %Matlab builtin functions for skewness and kurtosis
    start = tic;
    s_x = skewness(x);
    finish1 = toc(start);

    start=tic;
    k_x = kurtosis(x);
    finish2 = toc(start);
    
    start=tic;
    s_y = skewness(y);
    finish3 = toc(start);

    start=tic;
    k_y = kurtosis(y);
    finish4 = toc(start);
    
    %My skewness and kurtosis functions(serialized)
    start=tic;
    s_x2 = my_skewness(x);
    finish5 = toc(start);

    start=tic;
    k_x2 = my_kurtosis(x);
    finish6 = toc(start);

    start=tic;
    s_y2 = my_skewness(y);
    finish7 = toc(start);

    start=tic;
    k_y2 = my_kurtosis(y);
    finish8 = toc(start);
    
    %My second skewness and kurtosis functions(vectorized)
    start=tic;
    s_x3 = my_skewness2(x);
    finish9 = toc(start);

    start=tic;
    k_x3 = my_kurtosis2(x);
    finish10 = toc(start);

    start=tic;
    s_y3 = my_skewness2(y);
    finish11 = toc(start);

    start=tic;
    k_y3 = my_kurtosis2(y);
    finish12 = toc(start);
    
    %Mystery functions(serialized and vectorized)
    start=tic;
    mystery_vector1 = vectorized_mystery_calculation(x,y);
    finish13 = toc(start);

    start=tic;
    mystery_vector2 = vectorized_mystery_calculation(y,x);
    finish14 = toc(start);

    start=tic;
    mystery_serial1 = serialized_mystery_calculation(x,y);
    finish15 = toc(start);

    start=tic;
    mystery_serial2 = serialized_mystery_calculation(y,x);
    finish16 = toc(start);
    
    %Showing the matlab skewness result
    fprintf('Using Matlab builtin functions for skewness: matlab_skewResult =%20.12f\n', skewness(x));
    %Showing my skewness function result
    fprintf('Using user written functions for skewness: my_skewResult =%20.12f\n', my_skewness(x));
    %Showing my second skewness function result
    fprintf('Using second user written functions for skewness: my_skewResult =%20.12f\n', my_skewness2(x));
    fprintf('\n');
    %Showing the matlab kurtosis result
    fprintf('Using Matlab builtin functions for kurtosis: matlab_kurtResult =%20.12f\n', kurtosis(x));
    %Showing my kurtosis function result
    fprintf('Using user written functions for kurtosis: my_kurtResult =%20.12f\n', my_kurtosis(x));
    %Showing my second kurtosis function result
    fprintf('Using second user written functions for kurtosis: my_kurtResult =%20.12f\n', my_kurtosis2(x));

    
    %tic toc Output  
    fprintf('---------------------------------------TICTOC OUTPUT---------------------------------------\n');
    fprintf('skewness(x):                           %20.10f        serial time: %f\n', s_x, finish1);
    fprintf('kurtosis(x):                           %20.10f        serial time: %f\n', k_x, finish2);
    fprintf('skewness(y):                           %20.10f        serial time: %f\n', s_y, finish3);
    fprintf('kurtosis(y):                           %20.10f        serial time: %f\n', k_y, finish4);
    fprintf('\n');
    fprintf('my_skewness(x):                        %20.10f        serial time: %f\n', s_x2, finish5);
    fprintf('my_kurtosis(x):                        %20.10f        serial time: %f\n', k_x2, finish6);
    fprintf('my_skewness(y):                        %20.10f        serial time: %f\n', s_y2, finish7);
    fprintf('my_kurtosis(y):                        %20.10f        serial time: %f\n', k_y2, finish8);
    fprintf('\n');
    fprintf('my_skewness2(x):                       %20.10f        vector time: %f\n', s_x3, finish9);
    fprintf('my_kurtosis2(x):                       %20.10f        vector time: %f\n', k_x3, finish10);
    fprintf('my_skewness2(y):                       %20.10f        vector time: %f\n', s_y3, finish11);
    fprintf('my_kurtosis2(y):                       %20.10f        vector time: %f\n', k_y3, finish12);
    fprintf('\n');
    fprintf('vectorized_mystery_calculation(x,y):   %20.10f        vector time: %f\n', mystery_vector1, finish13);
    fprintf('vectorized_mystery_calculation(y,x):   %20.10f        vector time: %f\n', mystery_vector2, finish14);
    fprintf('serialized_mystery_calculation(x,y):   %20.10f        serial time: %f\n', mystery_serial1, finish15);
    fprintf('serialized_mystery_calculation(y,x):   %20.10f        serial time: %f\n', mystery_serial2, finish16);
    fprintf('\n');
    fprintf('Speedup of MatLab skewness and kurtosis over serialized: %f\n', (finish5 + finish6 + finish7 + finish8) / (finish1 + finish2 + finish3 + finish4));
    fprintf('Speedup of vectorized over MatLab skewness and kurtosis: %f\n', (finish1 + finish2 + finish3 + finish4) / (finish9 + finish10 + finish11 + finish12));
    fprintf('Speedup of vectorized over serialized skewness and kurtosis: %f\n',(finish5 + finish6 + finish7 + finish8) / (finish9 + finish10 + finish11 + finish12));
    fprintf('Speedup of vectorized over serialized mystery_calculation(x,y): %f\n',(finish15 + finish16)/ (finish13 + finish14));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my_skewness and my_kurtosis functions (as on assignment 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I am the old function(my_skewness(x))
function skewness_result = my_skewness(x)
        skewness_result = 0;
        %Caculate the average
        ave_x = 0.0;
        n = numel(x);
        sum = 0;
        for i = 1:n
            sum = sum + x(i);
        end
        ave_x = sum/n;
       % M = mean(x)
        
       term = zeros(n,1,'double');
       for i = 1: n
          term(i)=x(i) - ave_x; 
       end
        %Caculate the top
         top = 0.0;
         for i = 1:n
             top = top + (term(i))^3;
         end
         top = top/n;
         %Caculate the bottom
         bottom = 0.0;
         for i = 1:n
            bottom = bottom + (term(i))^2;
         end
         bottom = (sqrt(bottom/n))^3;
         
         %Caculate the skewness result
         skewness_result = top / bottom;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I am the old function(my_kurtosis(x))
function kurtosis_result = my_kurtosis(x)
        kurtosis_result = 0;
        %Caculate the average
        ave_x=0.0;
        n = numel(x);
        sum = 0;
        for i = 1:n
            sum = sum + x(i);
        end
        ave_x = sum/n;

        term=zeros(n,1,'double');
        for i=1:n
            term(i)=x(i)-ave_x;
        end

        %Caculate the top
        top = 0.0;
        for i = 1:n
            top = top + (term(i))^4;
        end
        top = top/n;
        %Caculate the bottom
        bottom = 0.0;
        for i = 1:n
            bottom = bottom + (term(i))^2;
        end
        bottom = (bottom/n)^2;
        %Caculate the kurtosis result
        kurtosis_result = top / bottom;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I am the second function(my_skewness2(x))
function skewness_result = my_skewness2(x)

    skewness_result = ( sum((x-mean(x)).^3) / numel(x)) / ( sqrt( sum((x-mean(x)).^2) / numel(x) ))^3;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I am the third function(my_kurtosis2(x))
function kurtosis_result = my_kurtosis2(x)

    kurtosis_result = ( sum( (x-mean(x)).^4) / numel(x) ) / ( sum( (x-mean(x)).^2 / numel(x) )^2 );

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I am the fourth function(vectorized_mystery_calculation(x,y))
function mystery_V_result=vectorized_mystery_calculation(x,y)

 mystery_V_result = sum( ( ( (2.*x) .* (2 - y)).^(1/3) ./ ( ( (x.^2).*(y.^3) ).^(1/4) + 5  ).^(1/6) ).^(1/9) );

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% serialized_mystery_calculation as on the course webpage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [value]=serialized_mystery_calculation(x,y)
    % latex: result=\sum sqrt[9]{\frac{\left( \sqrt[3]{\frac{2x(2-y)}}}
    %{\left( \sqrt[6]{\left( {sqrt[4]{(x^2y^2)+5}} \right)}^2 \right)}}
    n=numel(x); % or numel(y)
    top=zeros(n,1,'double');
    bottom=zeros(n,1,'double');

    for i=1:n
      top(i)=(2*x(i)*(2-y(i)))^(1/3);
    end

    for i=1:n
      bottom(i)=((((x(i)^2*y(i)^3)^(1/4)+5)^(1/6)));
    end

    for i=1:n
      value(i)=(top(i)/bottom(i))^(1/9);
    end

    % convert value array into a scalar
    value=sum(value);
end
