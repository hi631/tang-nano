What is # TD4?

The name of the CPU written in the book "How to create a CPU".

Approximate performance is as follows.

Address 4 bits (address 16)

ALU 4 bit

Input / output 4 bits

Command word length 8 bits

13 types of orders

The following was added as a slight change.

1. Display of counters on LCD instead of LED.

2. When the button B is pressed, the clock is stopped. Reset with button A.

Completed with 46 LUT without LCD display.

With the addition of LCD, it becomes 135 LUT.


What is # TD8?

TD4 self-extended version. It seems that various people are doing it.

It is not a big extension because it is premised on holding the instructions of TD4.

Address 8 bits (256 address)

ALU 8 bits

Command word length 12 bits

Increased instruction expansion registers to 3 (A, B, S)

Added JPM, CALL, RET

It became 78 LUT without LCD.


! [TD4/TD8] (https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/159764/023e622e-f235-2d81-3280-4e3bd058e88b.jpeg) 