function test = f(x,y,z)
    if nargin ==1
        disp(x);
    elseif nargin ==2
        disp(x + z)
    elseif nargin ==3
        disp(x,y,z)
    end
end