
%This assignment is about doing simple(and primitive) analysis on London weather data from 1941 to 2013
%And it will show 5 graphs about temperature, rainfall, snowfall, precipitation, and snow on the ground data
%Also, it will show 6 graphs for the pearson correlation coefficient between 
%(a) temperature versus precipitation 
%(b) temperature versus snowfall
%(c) temperature versus snow on the ground 
%(d) precipitation versus snowfall
%(e) rainfall versus snowfall
%(f) snow on the ground versus snowfall
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ass1_2017()
close all
% Program to perform seasonal climate analysys on London
% Ontario weather data from 1942 to 2013.

% 2013-1940+1 years of data, 12 months in a year,
% max of 31 days in a month, 32 for LAST (contains
% number of days for which data items are stored per month)
% Basically this is the number of days per month, with February
% having 29 days for leap years: leaprear(year) return true
% true if year is a leap year and false otherwise.

% 7 elements per day:
% 1 - 001 - max daily temperature degrees C to 0.1C
% 2 - 002 - min daily temperature degrees C to 0.1C
% 3 - 003 - ave daily temperature degrees C to 0.1C
% 4 - 010 - total rainfall 0.1mm
% 5 - 011 - total snowfall 0.1cm
% 6 - 012 - total precipitation 0.1mm
% 7 - 013 - snow on the ground 1cm
element_desc{1}='max daily temperature (0.1C)';
element_desc{2}='min daily temperature (0.1C)';
element_desc{3}='ave daily temperature (0.1C)';
element_desc{4}='total rainfall (0.1mm)';
element_desc{5}='total snowfall (0.1cm)';
element_desc{6}='total precipitation (0.1mm)';
element_desc{7}='ground snow (1.0cm)';

% true for all 4 seasons 
num_seasons=4;
first_day_of_season=22;
last_day_of_season=21;

seasonal_desc{1}='Winter Dec 22nd-March 21st';
seasonal_desc{2}='Spring March 22st-June 21st';
seasonal_desc{3}='Summer June 22st-Sept 21st';
seasonal_desc{4}='Fall Sept 22nd-Dec 21st';

season_name{1}='Winter';
season_name{2}='Spring';
season_name{3}='Summer';
season_name{4}='Fall';

winter=1;
spring=2;
summer=3;
fall=4;

days_in_month(1)=31; % january
days_in_month(2)=28; % february (or 29 for leap years)
days_in_month(3)=31; % march
days_in_month(4)=30; % april
days_in_month(5)=31; % may
days_in_month(6)=30; % june
days_in_month(7)=31; % july
days_in_month(8)=31; % august
days_in_month(9)=30; % september
days_in_month(10)=31; % october
days_in_month(11)=30; % november
days_in_month(12)=31; % december
month_name={'January'; 'February'; 'March'; 'April'; 'May'; 'June';
            'July'; 'August'; 'September'; 'October'; 'November'; 'December'};

% variable with the month positional numbers
january=  1;
february= 2;
march=    3;
april=    4;
may=      5;
june=     6;
july=     7;
august=   8;
september=9;
october= 10;
november=11;
december=12;

% element colours for plotting
plot_color{1}='red';
plot_color{2}='green';
plot_color{3}='blue';
plot_color{4}='magenta';
plot_color{5}='cyan';
plot_color{6}='yellow';

% Set the default line width to 2.0 for all plotting
set(0,'defaultlinelinewidth',2.0)

base_year=1940;
year_index_1941=1941-base_year; % 1
year_index_1942=1942-base_year; % 2
year_index_2013=2013-base_year; % 73
num_of_years=2013-1941+1; % 73
num_of_months=12;
num_of_elements=7;
num_of_data_items=31+1; % maximum number of data items per month
LAST=32; % the last data item at index 32 is the number of data_items read

% climate data available on the course webpage
load london_weather_1941_2013.mat 'climate';

fprintf('Number of single numbers in climate:%d\n',....
        size(climate,1)*size(climate,2)*size(climate,3)*size(climate,4));
fprintf('Size of climate:\n');
fprintf('%d by %d by %d by %d\n',size(climate,1),...
         size(climate,2),size(climate,3),size(climate,4));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 1: Compute mean temperature, mean snowfall, 
% mean snow of the ground, mean rainfall and mean precipitation 
% for the 12 nonths for years 1942 to 2013 and display as
% appropriately labeled/titled surf graphs.
%
% Task 2: Compute Pearson's correlation coefficients for
% temperature versus precipitation, temperature versus snowfall,
% temperature versus snow on the ground, precipitation versus
% snowfall, rainfall versus snowfall and snow on the ground
% versus snowfall, for the 12 months from 1942 to 2013 and 
% display the results as a surf graphs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temperature=3;
rainfall=4;
snowfall=5;
precipitation=6;
snow_on_ground=7;

% Six correlation graphs are required:
% 1. temperature versus precipitation
% 2. temperature versus snowfall
% 3. temperature versus snow on the ground
% 4. preciptitation versus snowfall
% 5. rainfall versus snowfall
% 6. snow on the ground versus snowfall
% We have to collect the appropriate data in two 1D arrays
% that we use to compute the correlation coefficients, which
% we save in a 2D array

for year=year_index_1942:year_index_2013
for month=1:12

% last day potentially different for each month
LAST=climate(year,month,temperature,32);
% Read 1:LAST elements of data

%original temperature data
temperature_data(1:LAST)=squeeze(climate(year,month,temperature,1:LAST));
%temperature data without all NaN value
temperature_data=temperature_data(~isnan(temperature_data));
%mean of temperature data
monthly_mean_data_temperature(year-year_index_1942+1,month)=mean(temperature_data(:));

%original rainfall data
rainfall_data(1:LAST)=squeeze(climate(year,month,rainfall,1:LAST));
%rainfall data without all NaN value
rainfall_data=rainfall_data(~isnan(rainfall_data));
%mean of rainfall data
monthly_mean_data_rainfall(year-year_index_1942+1,month)=mean(rainfall_data(:));

%if the average rainfall data is negative, giving an error message
if(monthly_mean_data_rainfall(year-year_index_1942+1,month) < 0)
    fprintf('Error: average rainfall is negative: %20.12f in %s in year %d\n',...
               monthly_mean_data_rainfall(year-year_index_1942+1,month),month_name{month},year+base_year);
    %return;
end

%original snowfall data
snowfall_data(1:LAST)=squeeze(climate(year,month,snowfall,1:LAST));
%snowfall data without all NaN value
snowfall_data=snowfall_data(~isnan(snowfall_data));
%mean of snowfall data
monthly_mean_data_snowfall(year-year_index_1942+1,month)=mean(snowfall_data(:));

%if the average rainfall data is negative, giving an error message
if(monthly_mean_data_snowfall(year-year_index_1942+1,month) < 0)  
    fprintf('Error: average snowfall is negative: %20.12f in %s in year %d\n',...
           monthly_mean_data_snowfall(year-year_index_1942+1,month),month_name{month},year+base_year);
    %return;
end

%original precipitation data
precipitation_data(1:LAST)=squeeze(climate(year,month,precipitation,1:LAST));
%precipitation data without all NaN value
precipitation_data=precipitation_data(~isnan(precipitation_data));
%mean of precipitation data
monthly_mean_data_precipitation(year-year_index_1942+1,month)=mean(precipitation_data(:));

%if the average precipitation data is negative, giving an error message
if(monthly_mean_data_precipitation(year-year_index_1942+1,month) < 0)  
  fprintf('Error: average precipitation is negative: %20.12f in %s in year %d\n',...
           monthly_mean_data_precipitation(year-year_index_1942+1,month),month_name{month},year+base_year);
  %return;
end

%original snow_on_ground data
snow_on_ground_data(1:LAST)=squeeze(climate(year,month,snow_on_ground,1:LAST));
%snow_on_ground data without all NaN value
snow_on_ground_data=snow_on_ground_data(~isnan(snow_on_ground_data));
%mean of snow_on_ground data
monthly_mean_data_snow_on_ground(year-year_index_1942+1,month)=mean(snow_on_ground_data(:));

%if the average snow_on_ground data is negative, giving an error message
if(monthly_mean_data_snow_on_ground(year-year_index_1942+1,month) < 0)  
  fprintf('Error: average precipitation is negative: %20.12f in %s in year %d\n',...
           monthly_mean_data_snow_on_ground(year-year_index_1942+1,month),month_name{month},year+base_year);
  %return;
end

% position x data for all x and y arrays (even is no nan) 
% to keep all the arrays the same length
myTemperature(1:LAST)=squeeze(climate(year,month,temperature,1:LAST));
myRainfall(1:LAST)=squeeze(climate(year,month,rainfall,1:LAST));
mySnowfall(1:LAST)=squeeze(climate(year,month,snowfall,1:LAST));
myPrecipitation(1:LAST)=squeeze(climate(year,month,precipitation,1:LAST));
mySnow_on_ground(1:LAST)=squeeze(climate(year,month,snow_on_ground,1:LAST));

%SETUP ARRAYS x1 TO x6 AND y1 to y6 
%PREALLOCATE THE ARAYS AND ASSIGN VAUES
x1=myTemperature(:);
y1=myPrecipitation(:);

x2=myTemperature(:);
y2=mySnowfall(:);

x3=myTemperature(:);
y3=mySnow_on_ground(:);

x4=myPrecipitation(:);
y4=mySnowfall(:);

x5=myRainfall(:);
y5=mySnowfall(:);

x6=mySnow_on_ground(:);
y6=mySnowfall(:);

%USE FIND TO COMPUTE THE COORDINATES OF CORRESPONDING NAN ARRAY
%ELEMENTS AND RESET x1 TO x6 AND y1 to y6
index=find(~isnan(x1) & ~isnan(y1) & ~isnan(x2) & ~isnan(y2) & ~isnan(x3) ...
            & ~isnan(y3) & ~isnan(x4) & ~isnan(y4) & ~isnan(x5) & ~isnan(y5)...
            & ~isnan(x6) & ~isnan(y6));
        
x1=x1(index);
y1=y1(index);

x2=x2(index);
y2=y2(index);

x3=x3(index);
y3=y3(index);

x4=x4(index);
y4=y4(index);

x5=x5(index);
y5=y5(index);

x6=x6(index);
y6=y6(index);


%COMPUTE PEARSON'S COLLELATION COEFFICIENT for (x1,y1), (x2,y2, (x3,y3),
%(x4,y4), (x5,y5) AND (x6,y6) AND SAVE

%(a) temperature versus precipitation 
temperature_vs_precipitation(year-year_index_1942+1,month)=pearson_correlation_coefficient(x1,y1);
% (b) temperature versus snowfall
temperature_vs_snowfall(year-year_index_1942+1,month)=pearson_correlation_coefficient(x2,y2);
% (c) temperature versus snow on the ground 
temperature_vs_snow_on_the_ground(year-year_index_1942+1,month)=pearson_correlation_coefficient(x3,y3);
% (d) precipitation versus snowfall
precipitation_vs_snowfall(year-year_index_1942+1,month)=pearson_correlation_coefficient(x4,y4);
% (e) rainfall versus snowfall
rainfall_vs_snowfall(year-year_index_1942+1,month)=pearson_correlation_coefficient(x5,y5);
% (f) snow on the ground versus snowfall
snow_on_the_ground_vs_snowfall(year-year_index_1942+1,month)=pearson_correlation_coefficient(x5,y5);


end % for year
end % for month

% display the mean and correlation data using surf
% compute X and Y to contain all the x and y coordinates need by surf

%USE meshgrid TO COMPUTE X AND Y
[X,Y]=meshgrid(1:12,1942:2013);

%DISPLAY FIVE MEAN SURFACE PLOTS
%Display the mean temperature graph
surf(X,Y,squeeze(monthly_mean_data_temperature));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp

%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Degrees Celsius');
title('\bf \fontsize{14} \color{red} Mean Temperature');

figure
%Display the mean rainfall graph
surf(X,Y,squeeze(monthly_mean_data_rainfall));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Millimetre');
title('\bf \fontsize{14} \color{red} Mean Rainfall');

figure
%Display the mean snowfall graph
surf(X,Y,squeeze(monthly_mean_data_snowfall));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Millimetre');
title('\bf \fontsize{14} \color{red} Mean Snowfall');

figure
%Display the mean precipitation graph
surf(X,Y,squeeze(monthly_mean_data_precipitation));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Millimetre');
title('\bf \fontsize{14} \color{red} Mean Precipitation');

figure
%Display the mean snow on ground graph
surf(X,Y,squeeze(monthly_mean_data_snow_on_ground)); 
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Centimeters');
title('\bf \fontsize{14} \color{red} Mean Snow on Ground');

%DISPLAY SIX PEARSON'S CORRELATION COEFFICIENT SURFACE PLOTS
figure
%Display the Pearson'correlation coefficients for temperature versus precipitation graph
surf(X,Y,squeeze(temperature_vs_precipitation));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Correlation');
title({'\bf \fontsize{14} \color{red} Pearson''correlation coefficients';'\bf \fontsize{14} \color{red}for temperature versus precipitation'});

figure
%Display the Pearson'correlation coefficients for temperature versus snowfall
surf(X,Y,squeeze(temperature_vs_snowfall));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Correlation');
title({'\bf \fontsize{14} \color{red} Pearson''correlation coefficients';'\bf \fontsize{14} \color{red}for temperature versus snowfall'});

figure
%Display the Pearson'correlation coefficients for temperature versus snow on the ground
surf(X,Y,squeeze(temperature_vs_snow_on_the_ground));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Correlation');
title({'\bf \fontsize{14} \color{red} Pearson''correlation coefficients';'\bf \fontsize{14} \color{red}for temperature versus snow on the ground '});

figure
%Display the Pearson'correlation coefficients for precipitation versus snowfall
surf(X,Y,squeeze(precipitation_vs_snowfall));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Correlation');
title({'\bf \fontsize{14} \color{red} Pearson''correlation coefficients';'\bf \fontsize{14} \color{red}for precipitation versus snowfall'});

figure
%Display the Pearson'correlation coefficients for rainfall versus snowfall
surf(X,Y,squeeze(rainfall_vs_snowfall));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Correlation');
title({'\bf \fontsize{14} \color{red} Pearson''correlation coefficients';'\bf \fontsize{14} \color{red}for rainfall versus snowfall'});

figure
%Display the Pearson'correlation coefficients for snow on the ground versus snowfall
surf(X,Y,squeeze(snow_on_the_ground_vs_snowfall));
%show the colorbar
colorbar
%produced the smooth shadings
shading interp
%label the x,y,z axis and the title
xlabel('\bf \fontsize{14} \color{red} Month');
ylabel('\bf \fontsize{14} \color{red} Year');
zlabel('\bf \fontsize{14} \color{red} Correlation');
title({'\bf \fontsize{14} \color{red} Pearson''correlation coefficients';'\bf \fontsize{14} \color{red}for snow on the ground versus snowfall'});
end % ass4_2017 function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%COMPUTE r FROM PEARSON'S CORRELATION COEFFICIENT
function r=pearson_correlation_coefficient(x,y)

        %get the number of non-NaN number
        x=x(~isnan(x));
        n = numel(x);   
        %up
        up = n.*sum(x.*y)-sum(x).*sum(y);
        %bottom
        bottom = sqrt((n.*sum(x.^2)-(sum(x)).^2).*(n.*sum(y.^2)-(sum(y)).^2))+eps;
        %r
        r=up/bottom;
    
end % pearson_correlation_coefficient function
