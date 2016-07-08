import re
import glob

def float_to_binary(i,j):
	a = re.match('0x(\d+).(.*)p(\D)(\d)',float.hex(i))
	if a:
		hexa = a.group(1)+a.group(2)
		integer = int(hexa,16)
		if a.group(3) == "-":
			padding = format(0,'0'+str(int(a.group(4))-1)+'b')
			integer_form = integer >> int(a.group(4))
			final_bin = "" + padding + bin(integer_form)[2:int(j)+2-int(a.group(4))]
		elif a.group(3) == "+":
			final_bin = integer << int(a.group(4))
			final_bin = bin(final_bin)[2:int(a.group(4))+3] + "" + bin(final_bin)[int(a.group(4))+3:int(j)+int(a.group(4))+3]
		#print final_bin
		return final_bin



c1 = []
c0 = []
output = []
for i in glob.glob("cos_co_effs.txt"):
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
			c_1 = float(coeff.group(1)+"."+coeff.group(2))
			print c_1
			c_0 = float(coeff.group(3)+"."+coeff.group(4))
			c_1 = float_to_binary(c_1,12)
			c_0 = float_to_binary(c_0,19)
			print c_1, c_0
			bin_fil.write("\t\t\t\t"+str(7)+"'d"+str(count)+" : d = 31'b"+c_1+"_"+c_0+";\n")
			count = count + 1
			#print coeff.group(2)
			#print coeff.group(4)


pi = long(3.1415926535897932384626433832795)
inp = 0
for i in range(0,128):
	#print c1[i],c0[i]
	inp = float(inp) + float(3.14159265/256)
	temp = float(c0[i])-float(float(c1[i])*float(inp))
	#output.append(temp)
	print i,inp,c1[i],c0[i],temp
	




