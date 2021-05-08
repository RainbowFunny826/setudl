$OS=[Environment]::OSVersion.Platform
Write-Output "你的OS为:$OS"
if ($OS -eq "Win32NT") {
$chcp=(chcp)
if ($chcp -eq "Active code page: 65001") {
Write-Output 检测到你目前的系统为UTF-8字符编码
Write-Host "所以你现在可以用任意Powershell解释器运行" -ForegroundColor Green
}
else
{
chcp 65001
Write-Host "此脚本因编码原因 无法使用Windows Powershell运行 请使用Powershell Core" -ForegroundColor Red
pause
Stop-Process -Name "powershell"
}
}
pause
Clear-Host
Function psExit {Stop-Process -Name "pwsh"}
$tak=(Test-Path "apikey.txt")
if($tak) {} else {Out-File apikey.txt}
$tsd=(Test-Path "savedir.txt")
if($tsd) {} else {Out-File savedir.txt}
$sd=(Get-Content "savedir.txt")
$ak=(Get-Content "apikey.txt")
if($ak) {Write-Output "你的APIKEY：$ak"} else {"Write-Output 你没有APIKEY。API调用次数与单次返回涩图张数将受限制。" }
Write-Output "如果你有APIKEY，请在apikey.txt中填写。"
Write-Output "在savedir.txt中可以输入自定义保存路径。路径末尾需加斜杠，否则程序会判断错误。"
if($sd) {Write-Output "你的路径：$sd"} else {Write-Output "涩图将会保存到当前脚本的目录下"}
$stc=Read-Host "来几份涩图?"
if($stc) {} else {Write-Host "份数无效!" -ForegroundColor Red | pause | psExit}
if($ak) {$imc=Read-Host "一份几张涩图？（最大为10，此功能仅限提供了APIKEY时可用）"} else {$imc=1}
if($imc) {} else {Write-Host "张数无效!" -ForegroundColor Red | pause | psExit}
$kw=Read-Host "搜索条件？（插画标题、作者、标签，留空则随机）"
$ot=Read-Host "其他参数？（参数之间用&分割，可留空)"

$imfr=$imc-1
for ($i=1; $i -le $stc; $i++) { 
Write-Output "当前是第 $i 次循环"
Write-Output "正在访问:https://api.lolicon.app/setu/?apikey=$ak&num=$imc&keyword=$kw&$ot"
Invoke-WebRequest -Uri "https://api.lolicon.app/setu/?apikey=$ak&num=$imc&keyword=$kw&$ot" -OutFile "return.json"
$sv=(Get-Content "return.json") | ConvertFrom-Json
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
Write-Output "剩余调用次数 $qo"

for ($a=0; $a -le $imfr; $a++) { 
$stct=$a+1
Write-Output "当前为第 $stct 张"
$ulc=(Get-Content url.txt|ForEach-Object{$_.split()[$a]})
$pdc=(Get-Content pid.txt|ForEach-Object{$_.split()[$a]})
$pc=(Get-Content p.txt|ForEach-Object{$_.split()[$a]})
Write-Output url:$ulc
Write-Output "pid:$pdc"
Write-Output "p:$pc"
$fn=$pdc + "_" + $pc + ".png"
$sdfn=$sd+$fn
Invoke-WebRequest -Uri "$ulc" -OutFile "$sdfn"
#你可以在这里加入你的自定义下载器,可以放到此目录然后使用./*运行
#你可以加入的变量 ulc:urlcount sd:savedir sdfn:savedir+filename fn:pdc+pc pdc:pidcount pc:pcount
Start-Sleep -Seconds 5
Clear-Host
}
Remove-Item url.txt
Remove-Item pid.txt
Remove-Item p.txt
Remove-Item return.json
}
pause
