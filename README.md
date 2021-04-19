<p><font size="+1">What is # TD4?</font><br>
　The name of the CPU written in the book &quot;How to create a CPU&quot;.<br>
　Approximate performance is as follows.<br>
　　Address 4 bits (address 16)<br>
　　ALU 4 bit<br>
　　Input / output 4 bits<br>
　　Command word length 8 bits<br>
　　13 types of orders<br>
<br>
　The following was added as a slight change.<br>
　　1. Display of counters on LCD instead of LED.<br>
　　2. When the button B is pressed, the clock is stopped. Reset with button
A.<br>
　Completed with 46 LUT without LCD display.<br>
　With the addition of LCD, it becomes 135 LUT.<br>
<br>
<font size="+1">What is # TD8?</font><br>
　TD4 self-extended version. It seems that various people are doing it.<br>
　It is not a big extension because it is premised on holding the instructions
of TD4.<br>
　　Address 8 bits (256 address)<br>
　　ALU 8 bits<br>
　　Command word length 12 bits<br>
　Increased instruction expansion registers to 3 (A, B, S)<br>
　Added JPM, CALL, RET<br>
<br>
　It became 78 LUT without LCD.<br>
<br>
[ＴＤ４／ＴＤ８] (https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/159764/023e622e-f235-2d81-3280-4e3bd058e88b.jpeg)</p>
