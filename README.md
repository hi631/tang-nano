<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="GENERATOR" content="JustSystems Homepage Builder Version 15.0.1.0 for Windows">
<title></title>
</head>
<body>
<p>What is # TD4?<br>
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
2. When the button B is pressed, the clock is stopped. Reset with button A.<br>
Completed with 46 LUT without LCD display.<br>
With the addition of LCD, it becomes 135 LUT.<br>
<br>
What is # TD8?<br>
TD4 self-extended version. It seems that various people are doing it.<br>
It is not a big extension because it is premised on holding the instructions of TD4.<br>
Address 8 bits (256 address)<br>
ALU 8 bits<br>
Command word length 12 bits<br>
Increased instruction expansion registers to 3 (A, B, S)<br>
Added JPM, CALL, RET<br>
<br>
It became 78 LUT without LCD.<br>
<br>
! [Image31.jpg] (https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/159764/023e622e-f235-2d81-3280-4e3bd058e88b.jpeg) </p>
</body>
</html>
