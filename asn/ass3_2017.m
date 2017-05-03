
%I am the first function
function ass3_2017()
    close all
    clc
    
    %set the two figures
    xmin=-4.0;
    xmax=+4.0;
    ymin=-4.0;
    ymax=+4.0;
    zmin=-8.0;
    zmax=+8.0;
    step=0.05;
    axis([xmin xmax ymin ymax zmin zmax])
   
    x=-4:step:4.0;
    y=-4.0:step:4.0;
    [X,Y]=meshgrid(x,y);
         
    Z1 = (3.*(1-X).^2.*exp(-(X.^2)-(Y+1).^2)-10.*(X./5-X.^3-Y.^5).*...
                       exp(-X.^2-Y.^2)-1/3.*exp(-(X+1).^2-Y.^2));
    Z2 = -Z1;
   
    %anonymous function
    %can be numerically integrated as integral2(fun1,xmin,xmax,ymin,ymax)
    fun1 = @(X,Y) (3.*(1-X).^2.*exp(-(X.^2)-(Y+1).^2)-10.*(X./5-X.^3-Y.^...
            5).*exp(-X.^2-Y.^2)-1./3.*exp(-(X+1).^2-Y.^2));
    fun2 = @(X,Y) -(3.*(1-X).^2.*exp(-(X.^2)-(Y+1).^2)-10.*(X./5-X.^3-Y.^...
            5).*exp(-X.^2-Y.^2)-1./3.*exp(-(X+1).^2-Y.^2));
    num_area1=integral2(fun1,xmin,xmax,ymin,ymax);
    num_area2=integral2(fun2,xmin,xmax,ymin,ymax);
    
    %print the numerical area number and symbolic area number under 1st and
    %second function
    fprintf('Numerical area under 1st function: %20.12f\n',...
    integral2(fun1,xmin,xmax,ymin,ymax));
    fprintf('Symbolic area under 1st function: %20.12f\n',...
    integral2(fun1,xmin,xmax,ymin,ymax));

    fprintf('Numerical area under 2st function: %20.12f\n',...
    integral2(fun2,xmin,xmax,ymin,ymax));
    fprintf('Symbolic area under 2st function: %20.12f\n',...
    integral2(fun2,xmin,xmax,ymin,ymax));

    %Symbolic Integration:
    syms f1 f2 x y
    f1=(3*(1-x)^2*exp(-(x^2) - (y+1)^2)- ...
    10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2));
    sym_area1=eval(int(int(f1,y,ymin,ymax),x,xmin,xmax));
    f2=-(3*(1-x)^2*exp(-(x^2) - (y+1)^2)- ...
    10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2));
    sym_area2=eval(int(int(f2,y,ymin,ymax),x,xmin,xmax));
        
    display_pause = 0.1;
    
    %show the first function figure 
    Z=Z1;
    mesh(X,Y,Z)
    xlabel('\bf \color{red} X azis');
    ylabel('\bf \color{green} Y azis');
    zlabel('\bf \color{blue} Z azis');
    axis([xmin xmax ymin ymax zmin zmax]);
    title(['Surface plot of (3*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5-x^3-'...
           'y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2-y^2))']);
    text(-4,3.7,-8,['\bf \fontsize{14} \color{blue} ' ...
                    'Numerical Integration: ' ...
                    sprintf('%8.3f',num_area1)]);
    text(-4,3.5,-9,['\bf \fontsize{14} \color{blue} ' ...
                    'Symbolic Integration: ' ...
                    sprintf('%8.3f',num_area1)]);
    figure
    
    %show the second function figure 
    Z=Z2;
    mesh(X,Y,Z)
    xlabel('\bf \color{red} X azis');
    ylabel('\bf \color{green} Y azis');
    zlabel('\bf \color{blue} Z azis');
    axis([xmin xmax ymin ymax zmin zmax]);
    title(['Surface plot of -(3*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5-x^3-'...
           'y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2-y^2))']);
    text(-4,3.9,12,['\bf \fontsize{14} \color{red} ' ...
                    'Numerical Integration: ' ...
                    sprintf('%8.3f',num_area2)]);
    text(-4,3.7,11,['\bf \fontsize{14} \color{red} ' ...
                    'Symbolic Integration: ' ...
                    sprintf('%8.3f',num_area2)]);    
                
    %type the return to show the animation
    fprintf('Type return to continue:\n');

    pause;
    
    set(0,'units','pixels');
    screenSizePixels=get(0,'screensize');
    screenWidth=screenSizePixels(3);
    screenHeight=screenSizePixels(4);
    figureAspectRatio=3/4; % height to width
    figureHeight=screenHeight*0.75;
    figureWidth=screenHeight*1.0/figureAspectRatio;
    % shift left 5% of the screen width
    leftx=screenWidth*0.05;
    % shift up 15% of the screen height
    lefty=screenHeight*0.15;
    ha=figure;
    set(ha,'Position',[leftx lefty figureWidth figureHeight]);
    
    %Set variables xpos1, ypos1 and zpos1 and xpos2, ypos2 and zpos2
    xpos1 = -3.7;
    ypos1 = 3.8;
    zpos1 = -8;
    
    xpos2 = -3.7;
    ypos2 = 3.6;
    zpos2 = -9;
    
    %show the animation of these two functions
    for t=0:0.05:1
        Z=Z1*(1-t)+Z2*(t);
        mesh(X,Y,Z)
        title({'\color{orange} (3*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5-x^3-y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2-y^2))';...
        '\color{black} warps to';...
        '\color{orange} -(3*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5-x^3-y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2-y^2))';...
        '\color{black} and back again'});
        axis([xmin xmax ymin ymax zmin zmax]);
        text(xpos1,ypos1,zpos1,['\bf \fontsize{18} \color{magenta} ' ...
                    'Numerical Integration: ' ...
                    sprintf('%8.3f',num_area1*(1-t)+num_area2*t)]);
        % {1.0 0.6 0.0} is orange
        text(xpos2,ypos2,zpos2,['\bf \fontsize{18} \color{magenta} ' ...
                    'Symbolic Integration: ' ...
                    sprintf('%8.3f',sym_area1*(1-t)+sym_area2*t)]);
        xlabel('\bf \color{red} X azis');
        ylabel('\bf \color{green} Y azis');
        zlabel('\bf \color{blue} Z azis');
        drawnow;
    end % for t
  
    %show the reverse of the animation of these two functions
    for t=0:0.05:1
        Z=Z2*(1-t)+Z1*(t);
        mesh(X,Y,Z)
        title({'\color{orange} (3*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5-x^3-y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2-y^2))';...
        '\color{black} warps to';...
        '\color{orange} -(3*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5-x^3-y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2-y^2))';...
        '\color{black} and back again'});
        axis([xmin xmax ymin ymax zmin zmax]);
        text(xpos1,ypos1,zpos1,['\bf \fontsize{18} \color{magenta} ' ...
                    'Numerical Integration: ' ...
                    sprintf('%8.3f',num_area1*(1-t)+num_area2*t)]);
        % {1.0 0.6 0.0} is orange
        text(xpos2,ypos2,zpos2,['\bf \fontsize{18} \color{magenta} ' ...
                    'Symbolic Integration: ' ...
                    sprintf('%8.3f',sym_area1*(1-t)+sym_area2*t)]);
        xlabel('\bf \color{red} X azis');
        ylabel('\bf \color{green} Y azis');
        zlabel('\bf \color{blue} Z azis');
        pause(display_pause);
        drawnow;
    end % for t
   
end

%I am the peaks function
function f1(x,y)

    f1(x,y)=(3.*(1-x).^2.*exp(-(x.^2)-(y+1).^2)-10.*(x./5-x.^3-y.^5).*...
            exp(-x.^2-y.^2)-1./3.*exp(-(x+1).^2-y.^2));

end

%I am the negative of the peaks function :f2(x,y)=-f1(x,y)
function f2(x,y)
    f2(x,y)=-f1(x,y);
end