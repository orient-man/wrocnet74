$path=$null;
if(Test-Path -Path "c:\Program Files\IIS Express")
{
    $path = "c:\Program Files\IIS Express";
}
if(Test-Path -Path "c:\Program Files (x86)\IIS Express")
{
   $path = "c:\Program Files (x86)\IIS Express";
}
if($path -eq $null)
{
    throw "No IIS express installed";
}
Start-Process "http://localhost:9090"
& "$path\iisexpress.exe" /path:"$pwd" /port:9090