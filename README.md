<p><font size="+1"><b>What is # TD4?</b></font><br>
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
<font size="+1"><b>What is # TD8?</b></font><br>
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
[ＴＤ４ & ＴＤ８]
<p><img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/159764/023e622e-f235-2d81-3280-4e3bd058e88b.jpeg" width="640" height="220" border="0"></p>
<p>For details, see the following page (in Japanese) <br>
<a href="https://qiita.com/hi631/items/35bb15a8b9dda83d9428">Move TD4 with Tang-Nano, and expand it a little more</a> <b><span class="VIiyi" jsaction="mouseup:BR6jm" jsname="jqKxS" lang="en" style="-webkit-tap-highlight-color: transparent; display: inline; color: rgb(0, 0, 0); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(245, 245, 245); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span jsaction="agoMJf:PFBcW;usxOmf:aWLT7;jhKsnd:P7O7bd,F8DmGf;Q4AGo:Gm7gYd,qAKMYb;uFUCPb:pvnm0e,pfE8Hb,PFBcW;f56efd:dJXsye;EnoYf:KNzws,ZJsZZ,JgVSJc;zdMJQc:cCQNKb,ZJsZZ,zchEXc;Ytrrj:JJDvdc;tNR8yc:GeFvjb;oFN6Ye:hij5Wb" jscontroller="Zl5N8" jsmodel="SsMkhd" jsname="txFAF" class="JLqJ4b ChMk0b" data-language-for-alternatives="en" data-language-to-translate-into="ja" data-phrase-index="0" jsdata="uqLsIf;_;$277" style="-webkit-tap-highlight-color: transparent; cursor: pointer;"><span jsaction="click:qtZ4nf,GFf3ac,tMZCfe; contextmenu:Nqw7Te,QP7LD; mouseout:Nqw7Te; mouseover:qtZ4nf,c2aHje" jsname="W297wb" style="-webkit-tap-highlight-color: transparent;"><br>
</span></span></span></b><span style="color: rgb(0, 0, 0); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(245, 245, 245); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span></p>
<p><b><font size="+1">Basic with Tango-nano</font></b><br>
　I found something like &quot;[light8080] (https://github.com/jaruiz/light8080)&quot;.<br>
　It can be configured with a small number of LUTs, and it seems that Basic also works.<br>
　As a structure, the logic can be shrunk by microcoding the logic.<br>
　However, a decrease in operating speed and a separate ROM area are required.<br>
　The decrease in operating speed will be okay if the 8080 operates at 80 MHz.<br>
　As for ROM, Flash can be used for GW1N, so it does not overwhelm resources.<br>
　Main specifications: LUT4 1152, Flip-Flop 864, BSRAM (bits) 72K, USER　Flash (bits) 96K<br>
　this configuration, 342 LUT is used. <br>
<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/159764/76c235fb-6daf-4029-eb05-e91393425104.jpeg" border="0"></p>
<p>For details, see the following page (in Japanese) <br>
<a href="https://qiita.com/hi631/items/d68c3b40c118588723f3">Run Basic with Tang-Nano</a> <font size="-1"><b><span style="color: rgb(0, 0, 0); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(245, 245, 245); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><br>
</span></b></font></p>
