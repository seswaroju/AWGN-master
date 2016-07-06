format long;
c_2 = zeros(1);
c_1 = zeros(1);
c_0 = zeros(1);
m = 0;
n = 1;
in_0 = zeros(1);
in_1 = zeros(1);
for i=1:256
    m = n;
    n = m+(1/256);
    x = linspace(m,n);
    y = -log(x);
    a = polyfit(x,y,2);
    c_2(i) = a(1);
    c_1(i) = a(2);
    c_0(i) = a(3);
    in_0(i) = m;
    in_1(i) = n;
end
filename = 'C:\log_co_effs.txt';
fid = fopen(filename,'wt');
if( fid == -1 );
    error('! could not open file');
else
    lines = size(c_1);
    fprintf(fid,'from\t\tto\t\t\tC2\t\tC1\t\tC0\n');
    for k=1:lines(2)
        fprintf(fid,'%0.9f\t%0.9f\t\t%0.4f\t\t%0.6f\t\t%0.9f\n',in_0(k),in_1(k),c_2(k),c_1(k),c_0(k));
    end
end
fclose(fid);
