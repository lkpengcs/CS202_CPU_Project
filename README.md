# CS202_CPU_Project

# task3（如何用跑在MiniSys上artix_7里MIPS指令集的CPU挖矿  
- ① [做一个计算sha256的C程序](https://github.com/LinkaiPeng-SUSTech/CS202_CPU_Project/blob/master/asm_files/calc_hash.cpp)  
让程序尽可能不会被优化，每行代码的操作尽量少
- ② 把C程序改写成MIPS指令，一行一行改也用不了多久  
都有C代码了为什么不去在线或者自助-target mipsel叉编？叉编的代码我们的汇编器是不能识别的，且不是所有指令我们的CPU都能处理。~~（有大佬的脚本除外~~  
- ③ 修改我们的CPU处理不了的MIPS指令
这里可以拓展CPU指令集，也可以通过已支持的指令完成。  
添加功能是可行的，我们在ALU中添加了除法和乘法的ip核，并扩展了(div mult mfhi mflo mthi mtlo)指令。  
然而32位除法器需要CPU主周期降低32倍，以保证ALU能完成除法。这对于性能的打击过大，为了不让Project升级成双周期CPU，我们删除了乘除法功能。  
优化\替代是可行的，对于a%/b且b=2^n的除法，可以用**srl b,b,n**计算除法结果，用**andi b,b,2^n**计算余数。  
对于其它特殊除数，也可以尝试优化成位运算，如 **$t6=$t5/10** ：  
``` asm
	srl $20,$t5,1		#($t5 >> 1) 
	srl $18,$t5,2		#($t5 >> 2);
	addu $22,$18,$20	#$22 = ($t5 >> 1) + ($t5 >> 2);
	srl $18,$22,4		#($22 >> 4);
	addu $22,$22,$18	#$22 = $22 + ($22 >> 4);
	srl $18,$22,8
	addu $22,$22,$18	#$22 = $22 + ($22 >> 8);
	srl $18,$22,16
	addu $22,$22,$18	#$22 = $22 + ($22 >> 16);
	srl $22,$22,3		#$22 = $22 >> 3;
	sll $18,$22,2
	addu $18,$18,$22
	sll $18,$18,1
	subu $23,$t5,$18	#$23 = $t5 - ((($22 << 2) + $22) << 1);
	addiu $1,$0,1
	subu $1,$23,$1
	slti $1,$1,9
	bne $1,$0,sjmp1
		addiu $22,$22,1
	sjmp1:
	addu $t6,$22,$zero	#t6=$22 + ($23 > 9);
```
如上位移和按位与的原理，可以使用**sw**完成**sb**命令：
``` asm
	or    $23,$t6,$zero	#paramater 1
	addiu   $22,$t2,0	#paramater 0 2
	andi	$20,$22,3
	srl	$18,$22,2
	sll	$18,$18,2
	lw	$28, 0($18)
	sll	$20,$20,3	
	addiu	$21,$zero,255	#init 14
	sllv 	$21,$21,$20
	nor	$21,$21,$zero	#14  11110000111111111
	and	$21,$28,$21   #14  0101000010101010
	sllv 	$22,$23,$20	
	or	$22,$22,$21
	sw	$22,0($18)    #paramater 2
	or $t6,$23,$zero 	#paramater 1
```
至此，我们可以在编写的CPU上完成所有Mars上可以执行的操作。
- ④ 将指令修改到最简  
替换不支持的指令，如 可被addi替代的指令 li,move  
替换复杂指令，如     须被lui 0x1234 + ori 0x5678替代的指令addi 0x12345678   
替换有歧义的指令，如 可被addi 0x9c40替代的指令addi 40000
- ④ 编译上板
程序可以按sha256算法正常计算哈希，通过[脚本](https://github.com/LinkaiPeng-SUSTech/CS202_CPU_Project/blob/master/asm_files/check_hash.py)验算。  
**CPU算力约为1KH/s**,在不超频的情况下算力是RTX 3090的十万分之一，假设挖ETH，运行一天约有0.01元的毛利润(2021/5/25)。  

# task3遇到的问题
很不幸，Mars运行一切正常，仿真结果却完全错误  
冷静分析，多次仿真并比对Mars和MinisysAv生成的汇编代码，发现MinisysAv对指令格式要求十分严格，而Mars要求比较宽松且会转化有歧义的代码。  
**事实上只需要替换Jal和J两条指令的基址由0x400000到0x0即可使用Mars生成的指令做coe**，~~Mars效率相比MinisysAv好像VS和DEV的区别(x~~  
Mars和MinisysAv生成的汇编的区别具体差异如下
## ①.text代码段 
如下表：  

 原汇编指令 | MinisysAv反汇编 | MinisysAv执行后$1的值 | Mars反汇编 | Mars执行后$1的值
| -- | ---- | ---- |  --- | -- |
| addiu $1, $0, 65535 | Syntax Err | - | lui  $2, 0 <br> ori  $2, $2, 0xffff <br> addu  $1, $1, $2 | 65535 |
| addiu $1, $0, 0xffff | addiu $1, $0, 0xffff | -1 | lui  $2, 0 <br> ori  $2, $2, 0xffff <br> addu  $1, $1, $2 | 65535 | 
| addiu $1, $0, -1 | addiu $1, $0, 0xffff | -1 | addiu $1, $0, 0xffff | -1 |  

立即数为0xFFFF时，**decoder**的立即数扩展会将高16位补1，于是$1=0xFFFFFFFF。  
而Mars通过高位lui，低位ori，$1=0x00000000 -> 0x0000FFFF  
我们知道单一指令携带的立即数不能超过2^16，对于有歧义的汇编指令，两种汇编处理方式不同：  
- Mars会默认立即数不超过2^32，如果超出2^16如果超出则拆分指令，通过**lui**立即数高16位和**ori**立即数16低位两步将立即数存入寄存器，再通过寄存器运算完成指令。  
- MinisysAv只会限制立即数在-32768(0xFFFF)~32767(0X7FFF)之间，如果以立即数4位16进制传递，MinisysAv会不加检查地直接嵌入代码中。  
## ②.data数据段
如下表：

 原数据声明 | MinisysAv汇编 | Mars汇编 
| -- | -- | -- |
|test : .ascii  "1234123" | 34333231,<br>00000000 | 34333231,<br>00333231 |
|test : .asciiz "1234123" | 34333231,<br>00000000 | 34333231,<br>00333231 |
|test : .half   0xffff,0xffff,0xffff | ffffffff,<br>00000000 | ffffffff,<br>0000ffff |
|test : .byte   0xff,0xff,0xff,0xff,0xff,0xff | ffffffff,<br>00000000 | ffffffff,<br>0000ffff | 

对于MinisysAv，.align对齐也不会产生影响，汇编后未以word对齐声明的数据将会丢失。  
Mars不会自动对齐word，但是不会丢失未对齐的数据。  
