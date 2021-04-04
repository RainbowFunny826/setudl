chcp 65001
$host.ui.RawUI.WindowTitle="setu.python_1.5.1.2 原作:Asankilp , 转换:RainbowFunny 组件 Powershell / Aria2c(可选)"
$tak=(Test-Path "apikey.txt")
if($tak)
{
#此值为空
}
else
{
Out-File apikey.txt
}
$tsd=(Test-Path "savedir.txt")
if($tsd)
{
#此值为空
}
else
{
Out-File savedir.txt
}
$sd=(Get-Content "savedir.txt")
$ak=(Get-Content "apikey.txt")
if($ak)
{
echo 你的APIKEY：$ak
}
else
{
echo 你没有APIKEY。API调用次数与单次返回涩图张数将受限制。 
}
echo 如果你有APIKEY，请在apikey.txt中填写。
echo 在savedir.txt中可以输入自定义保存路径。路径末尾需加斜杠，否则程序会判断错误。
if($sd)
{
echo 你的路径：$sd
}
else
{
echo 请尽可能使用路径。似乎是代码原因，不使用保存路径可能会报错，此问题将不解决。
}
$stc=Read-Host "来几张涩图?(变量范围: 1-300 此变量必须输入)"
if($ak)
{
$imc=Read-Host "一份几张涩图？（最大为10，此功能仅限提供了APIKEY时可用）"
}
else
{
$imc=1
}
$kw=Read-Host "搜索条件？（插画标题、作者、标签，留空则随机）"
$ot=Read-Host "其他参数？（参数之间用&分割，可留空)"

$imfr= $imc -1
for ($i=1; $i -le $stc; $i++) { 
echo "当前是第 $i 次循环"
echo 正在访问:"https://api.lolicon.app/setu/?apikey=$ak&num=$imc&keyword=$kw&$ot"
Invoke-WebRequest -Uri "https://api.lolicon.app/setu/?apikey=$ak&num=$imc&keyword=$kw&$ot" -OutFile "return.json"
$sv = (Get-Content "return.json") | ConvertFrom-Json
$co=$sv.code
$qo=$sv.quota
$ct=$sv.count
$pd=$sv.data.pid
$p=$sv.data.p
$ud=$sv.data.uid
$te=$sv.data.title
$ah=$sv.data.author
$ul=$sv.data.url
$ra=$sv.data.r18
$tg=$sv.data.tags

"$ul" | Out-File -Append url.txt
"$pd" | Out-File -Append pid.txt
"$p 1" | Out-File -Append p.txt
echo "剩余调用次数 $qo"

for ($a=0; $a -le $imfr; $a++) { 
echo "当前为第 $a 张"
$ulc=(Get-Content url.txt|%{$_.split()[$a]})
$pdc=(Get-Content pid.txt|%{$_.split()[$a]})
$pc=(Get-Content p.txt|%{$_.split()[$a]})
echo url:$ulc
echo "pid:$pdc"
echo "p:$pc"
$fn="$pdc $pc.png"
$sdfn=$sd+$fn
Invoke-WebRequest -Uri "$ulc" -OutFile "$sdfn"
}
rm url.txt
rm pid.txt
rm p.txt
rm return.json
}
pause
