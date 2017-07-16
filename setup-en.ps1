function Invoke-DownloadFile{
	[CmdletBinding()]
	param(
		[parameter(Mandatory,position=0)]
		[string]
		$Uri,

		[parameter(Mandatory,position=1)]
		[string]
		$DownloadFolder,

		[parameter(Mandatory,position=2)]
		[string]
		$FileName
	)
	begin
	{
		If (-not(Test-Path $DownloadFolder))
		{
			try
			{
				New-Item -ItemType Directory -Path $DownloadFolder -ErrorAction stop
			}
			catch
			{
				#throw $_
			}
		}
		try
		{
			$DownloadPath = Join-Path $DownloadFolder $FileName -ErrorAction Stop
		}
		catch
		{
			#throw $_
		}
	}
	process
	{
		Invoke-WebRequest -Uri $Uri -OutFile $DownloadPath #-Verbose -PassThru
	}
	end
	{
		#Get-Item $DownloadPath
	}
}

echo Welcome to GenisysPro installer
if(Test-Path ".\tmp\src.zip"){
	Remove-Item ".\tmp\src.zip" -Recurse
}else{
}
echo Began to download GenisysPro src.
Invoke-DownloadFile -Uri "https://github.com/GenisysPro/GenisysPro/archive/master.zip" -DownloadFolder ".\tmp\" -FileName "src.zip"
Expand-Archive ".\tmp\src.zip" ".\"
Move-Item ".\GenisysPro-master\src" ".\" -Passthru
Move-Item ".\GenisysPro-master\start.cmd" ".\" -Passthru
Move-Item ".\GenisysPro-master\start.ps1" ".\" -Passthru
Remove-Item ".\GenisysPro-master" -Recurse

$os = Get-WmiObject -Class Win32_OperatingSystem
if($os.OSarchitecture -match "64"){
echo This os is 64bit
if(Test-Path ".\tmp\bin.zip"){
	Remove-Item ".\tmp\bin.zip" -Force
    echo There is an old bin.So removed it.
}else{
}
Invoke-DownloadFile -Uri "https://github.com/Takesikaityo/PocketMine_Bin_win_x64/archive/master.zip" -DownloadFolder ".\tmp\" -FileName "bin.zip"
if(Test-Path ".\bin"){
	Remove-Item ".\bin" -Recurse
    echo There is an old bin.So removed it.
}else{
}
if(Test-Path ".\PocketMine_Bin_win_x64-master"){
	Remove-Item ".\PocketMine_Bin_win_x64-master" -Recurse
    echo There is an old bin.So removed it.
}else{
}
Expand-Archive ".\tmp\bin.zip" ".\"
Move-Item ".\PocketMine_Bin_win_x64-master\bin" ".\" -Passthru
Remove-Item ".\PocketMine_Bin_win_x64-master" -Recurse
}else{
if(Test-Path ".\tmp\bin.zip"){
	Remove-Item ".\tmp\bin.zip" -Recurse
    echo There is an old bin.So removed it.。
}else{
}
Invoke-DownloadFile -Uri "https://github.com/Takesikaityo/PocketMine_Bin_win_x32/archive/master.zip" -DownloadFolder "tmp\" -FileName "bin.zip"
if(Test-Path ".\bin"){
	Remove-Item ".\bin" -Recurse
    echo There is an old bin.So removed it.
}else{
}
if(Test-Path ".\PocketMine_Bin_win_x32-master"){
	Remove-Item ".\PocketMine_Bin_win_x32-master" -Recurse
    echo There is an old bin.So removed it.
}else{
}
Expand-Archive ".\tmp\bin.zip" ".\"
Move-Item ".\PocketMine_Bin_win_x32-master\bin" ".\"
Remove-Item ".\PocketMine_Bin_win_x32-master" -Recurse
}
echo Done!
echo Run start.ps1 or start.cmd, and GenisysPro'll run on ur PC!
