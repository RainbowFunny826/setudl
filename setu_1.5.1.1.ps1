chcp 65001
$host.ui.RawUI.WindowTitle="setu.python_1.5.1.1 ԭ��:Asankilp , ת��:RainbowFunny ��� Powershell / Aria2c(��ѡ)"
$tak=(Test-Path "apikey.txt")
if($tak)
{
#��ֵΪ��
}
else
{
Out-File apikey.txt
}
$tsd=(Test-Path "savedir.txt")
if($tsd)
{
#��ֵΪ��
}
else
{
Out-File savedir.txt
}
$sd=(Get-Content "savedir.txt")
$ak=(Get-Content "apikey.txt")
if($ak)
{
echo ���APIKEY��$ak
}
else
{
echo ��û��APIKEY��API���ô����뵥�η���ɬͼ�����������ơ� 
}
echo �������APIKEY������apikey.txt����д��
echo ��savedir.txt�п��������Զ��屣��·����·��ĩβ���б�ܣ����������жϴ���
if($sd)
{
echo ���·����$sd
}
else
{
echo �뾡����ʹ��·�����ƺ��Ǵ���ԭ�򣬲�ʹ�ñ���·�����ܻᱨ�������⽫�������
}
$stc=Read-Host "������ɬͼ?(������Χ: 1-300 �˱�����������)"
if($ak)
{
$imc=Read-Host "һ�ݼ���ɬͼ�������Ϊ10���˹��ܽ����ṩ��APIKEYʱ���ã�"
}
else
{
$imc=1
}
$kw=Read-Host "�������������廭���⡢���ߡ���ǩ�������������"
$ot=Read-Host "����������������֮����&�ָ������)"

$imfr= $imc -1
for ($i=1; $i -le $stc; $i++) { 
echo "��ǰ�ǵ� $i ��ѭ��"
echo ���ڷ���:"https://api.lolicon.app/setu/?apikey=$ak&num=$imc&keyword=$kw&$ot"
curl "https://api.lolicon.app/setu/?apikey=$ak&num=$imc&keyword=$kw&$ot">return.json
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

for ($a=0; $a -le $imfr; $a++) { 
$ulc=(Get-Content url.txt|%{$_.split()[$a]})
$pdc=(Get-Content pid.txt|%{$_.split()[$a]})
$pc=(Get-Content p.txt|%{$_.split()[$a]})
echo url:$ulc
echo "pid:$pdc"
echo "p:$p"
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