format long;
c_1 = zeros(1);
c_0 = zeros(1);
m = 0;
n = 0;
in_0 = zeros(1);
in_1 = zeros(1);
for i=1:128
    m = n;
    n = m+(pi/256);
    x = linspace(m,n);
    y = cos(x);
    a = polyfit(x,y,1)
    c_1(i) = a(1);
    c_0(i) = a(2);
    in_0(i) = m;
    in_1(i) = n;
end
filename = 'C:\cos_co_effs.txt';
fid = fopen(filename,'wt');
if( fid == -1 );
    error('! could not open file');
else
    lines = size(c_1);
    fprintf(fid,'from\t\tto\t\t\tC1\t\tC0\t\toutput\n');
    for k=1:lines(2)
        fprintf(fid,'%0.9f\t%0.9f\t\t%0.3f\t\t%0.5f\t\t%0.5f\n',in_0(k),in_1(k),c_1(k),c_0(k));
    end
end
fclose(fid);




