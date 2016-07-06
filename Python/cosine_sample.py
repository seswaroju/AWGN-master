import re
import glob

c1 = []
c0 = []
output = []
for i in glob.glob("co_effs.txt"):
	fil = open(i,'r')
	bin_fil = open("binary_out.txt",'w')
	bin_fil.write("C1_FB\t\tC0_FB\n")
	count = 0
	for line in fil:
		#print line
		coeff = re.match('\d\.\d+.*\d\.\d+.*(\d)\.(\d+).*(\d)\.(\d+)',line)
		if coeff:
			c1.append(coeff.group(1)+"."+coeff.group(2))
			c0.append(coeff.group(3)+"."+coeff.group(4))
			bin_fil.write("\t\t\t\t"+str(7)+"'d"+str(count)+" : d = 31'b"+format(int(coeff.group(2)),'012b')+"_1"+format(int(coeff.group(4)),'018b')+";\n")
			count = count + 1
			#print coeff.group(1)
			#print coeff.group(2)
pi = long(3.1415926535897932384626433832795)
inp = 0
for i in range(0,128):
	#print c1[i],c0[i]
	inp = float(inp) + float(3.14159265/256)
	temp = float(c0[i])-float(float(c1[i])*float(inp))
	#output.append(temp)
	print temp




