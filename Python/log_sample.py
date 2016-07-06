import re
import glob

c2 = []
c1 = []
c0 = []
output = []
for i in glob.glob("log_co_effs.txt"):
	fil = open(i,'r')
	bin_fil = open("log_binary_out.txt",'w')
	bin_fil.write("C2_FB\t\t\tC1_FB\t\t\tC0_FB\n")
	count = 0
	for line in fil:
		#print line
		coeff = re.match('\d\.\d+.*\d\.\d+.*(\d)\.(\d+).*(\d)\.(\d+).*(\d)\.(\d+)',line)
		if coeff:
			c2.append(coeff.group(1)+"."+coeff.group(2))
			c1.append(coeff.group(3)+"."+coeff.group(4))
			c0.append(coeff.group(5)+"."+coeff.group(6))
			if coeff.group(5):
				c0_int = 1
			else:
				c0_int = 0
			bin_fil.write("\t\t\t"+str(8)+"'d"+str(count)+" : d = 65'b"+format(int(coeff.group(2)),'013b')+"_1"+format(int(coeff.group(4)),'021b')+"_"+str(c0_int)+format(int(coeff.group(4)),'029b')+";\n")
			count = count + 1
			#print coeff.group(1)
			#print coeff.group(2)

inp = 1
for i in range(0,256):
	#print c2[i],c1[i],c0[i]
	inp = float(inp) + float(float(1)/float(256))
	temp = float(c0[i])-float(float(c1[i])*float(inp))+float(float(c2[i])*float(inp)*float(inp))
	#output.append(temp)
	print inp, temp