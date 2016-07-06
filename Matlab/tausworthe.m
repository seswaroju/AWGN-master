
s0=uint32(hex2dec('ffffffff'));
s1=uint32(hex2dec('cccccccc'));
s2=uint32(hex2dec('00ff00ff'));
out = zeros(1);
% Tausworthe Definition
filename = 'C:\random_out_1.txt';
for i = 1:10000
    b1 = bitshift(bitxor(bitshift(s0,13,'uint32'),s0),-19,'uint32');
    s0 = bitxor(bitshift(bitand(s0,hex2dec('fffffffe')),12),b1,'uint32');
    b2 = bitshift(bitxor(bitshift(s1,2),s1),-25,'uint32');
    s1 = bitxor(bitshift(bitand(s1,hex2dec('fffffff8')),4),b2,'uint32');
    b3 = bitshift(bitxor(bitshift(s2,3),s2),-11,'uint32');
    s2 = bitxor(bitshift(bitand(s2,hex2dec('fffffff0')),17),b3,'uint32');
    a = bitxor(s0,s1);
    b = bitxor(a,s2);
    out(i) = b;
end


histogram(out);
fid = fopen(filename,'wt');
if( fid == -1 );
    error('! could not open file');
else
    lines = size(out);
    for k=1:lines(2)
        fprintf(fid,'%4s\n',dec2hex(out(k),8));
    end
end
fclose(fid);
