
%I am the first function
function ass1_2017(num_x)
    %Making a string to a number
    num_x = str2num(num_x);
    x = rand(num_x,1,'double');
    %Building the uniformly distributed histogram
    hist(x,50)
    xtitle = ['Histogram of ' num2str(num_x) ' random numbers'];
    title(xtitle);
    
    y = randn(num_x,1,'double');
    figure
    %Building the normally distributed histogram
    hist(y,50)
    ytitle = ['Histogram of ' num2str(num_x) ' normal random numbers'];
    title(ytitle);
    
    %Showing the matlab skewness result
    fprintf('Using Matlab builtin functions for skewness: matlab_skewResult =%22.12f\n', skewness(x));
    %Showing my skewness function result
    fprintf('Using user written functions for skewness: my_skewResult =%22.12f\n', myskewness(x));
    %Showing the matlab kurtosis result
    fprintf('Using Matlab builtin functions for kurtosis: matlab_kurtResult =%22.12f\n', kurtosis(x));
    %Showing my kurtosis function result
    fprintf('Using user written functions for kurtosis: my_kurtResult =%22.12f\n', mykurtosis(x));
    fprintf('\n');
    
    [x,min_x1,max_x1,min_x2,max_x2] = generate_distribution(-999999,999999,num_x);
    
    fprintf('\n');
    fprintf('The result of sum(x) is: %22.12f\n',sum(x));
    fprintf('The result of sum(sort(x)) is: %22.12f\n',sum(sort(x)));
    %print the comment of
    %The two results of sum(sort(x)) and sum(x) are similar.
    %According to the roundoff error, when sort the numbers, I think sum(sort(x)) will be more accurate than sum(x).
    fprintf('The two results of sum(sort(x)) and sum(x) are similar.\nAccording to the roundoff error, when sort the numbers, I think sum(sort(x)) will be more accurate than sum(x).\n');
    fprintf('\n');
    fprintf('Assume there is 2 variables a = 4, and b = 1.0*10^64.\n');
    b = 1.0e64;
    %determine another variable a is 4
    a = 4;
    %adding a to b, get a new b
    fprintf('Then, a+b = b = %e\n',b);
    %Verify a is relative zero to b or not
    if (a + b) == b
        fprintf('When b is a large number(i.e. 1.0e64), and a is smaller than b&non-zero number, then a+b=b. a is relative zero to b.\n');
    else
        fprintf('a is not relative zero to b.\n');
    return
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%I am the second function(myskewness(x))
function skewness_result = myskewness(x)
        skewness_result = 0;
        %Caculate the average
        n = numel(x);
        sum = 0;
        for i = 1:n
            sum = sum + x(i);
        end
        ave = sum/n;
        % M = mean(x)

        %Caculate the top
        top = 0;
        for i = 1:n
            top = top + (x(i) - ave)^3;
        end
        top = top/n;
        %Caculate the bottom
        bottom = 0;
        for i = 1:n
           bottom = bottom + (x(i) - ave)^2;
        end
        bottom = (sqrt(bottom/n))^3;
         
        %Caculate the skewness result
        skewness_result = top / bottom;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%I am the third function(mykurtosis(x))
function kurtosis_result = mykurtosis(x)
        kurtosis_result = 0;
        %Caculate the average
        n = numel(x);
        sum = 0;
        for i = 1:n
            sum = sum + x(i);
        end
        ave = sum/n;
        %Caculate the top
        top = 0;
        for i = 1:n
            top = top + (x(i) - ave)^4;
        end
        top = top/n;
        %Caculate the bottom
        bottom = 0;
        for i = 1:n
            bottom = bottom + (x(i) - ave)^2;
        end
        bottom = (bottom/n)^2;
        %Caculate the kurtosis result
        kurtosis_result = top / bottom;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%I am the fourth function
function [x,min_x1,max_x1,min_x2,max_x2]=generate_distribution(low_bound_x,high_bound_x,num_x)
    x = rand(num_x,1,'double');
    % x as originally passed in
    min_x1=min(x);
    max_x1=max(x);
 
    x = (x - min_x1) / (max_x1 - min_x1);

    % scaled/shift x using min and max
    min_x2=min(x);
    max_x2=max(x);

    %if low_bound_x < high_bound_x then x * (high_bound_x - low_bound_x) + low_bound_x
    %else print the error message
    if low_bound_x < high_bound_x
    x = x * (high_bound_x - low_bound_x);
    x = x + low_bound_x;
    else
    fprintf('Error: the lower bound is not less than higher bound!\n');
    return
    end
    
    %print the value of min_x1, max_x1, min_x2, max_x2, low_bound_x,
    %high_bound_x, mean(x), median(x)
    fprintf('The value of min_x1 is: %22.12f\nThe value of max_x1 is: %22.12f\nThe value of min_x2 is: %22.12f\nThe value of max_x2 is: %22.12f\n', min_x1, max_x1, min_x2, max_x2);
    fprintf('The value of low_bound_x is: %22.12f\nThe value of high_bound_x is: %22.12f\n',low_bound_x, high_bound_x);
    fprintf('The average of x is: %22.12f\nThe median of x is: %22.12f\n', mean(x), median(x));
end

