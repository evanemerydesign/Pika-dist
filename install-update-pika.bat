@echo off
REM ============================================================================
REM  Pika installer / updater — double-click to install Pika into Rhino 8, or to
REM  update to the newest build. Downloads the latest release from the public
REM  Pika-dist repo (no GitHub login needed) and installs it via Rhino's Yak.
REM  Run this same file again anytime to update to the newest build.
REM ============================================================================
setlocal

echo(
echo  ==================================================
echo(
echo     #####  #####  #   #   ###
echo     #   #    #    #  #   #   #
echo     #####    #    ###    #####
echo     #        #    #  #   #   #
echo     #      #####  #   #  #   #
echo(
echo      /\_/\
echo     ( o.o )
echo      ) ^^ (   Pika!
echo(
echo             P U B L I C   R E L E A S E
echo  ==================================================
echo(

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; [Console]::OutputEncoding=[System.Text.Encoding]::UTF8; chcp 65001 > $null; $yak='C:\Program Files\Rhino 8\System\Yak.exe'; if(-not (Test-Path $yak)){Write-Host 'ERROR: Rhino 8 not found (no Yak.exe). Install Rhino 8 first.' -ForegroundColor Red; Read-Host 'Press Enter to exit'; exit 1}; Write-Host 'Checking for the latest Pika build...'; try { $r=Invoke-RestMethod 'https://api.github.com/repos/evanemerydesign/Pika-dist/releases/latest' -Headers @{'User-Agent'='pika-updater'} } catch { Write-Host ('ERROR: could not reach GitHub: ' + $_.Exception.Message) -ForegroundColor Red; Read-Host 'Press Enter to exit'; exit 1 }; $a=$r.assets | Where-Object { $_.name -like '*.yak' } | Select-Object -First 1; if(-not $a){Write-Host 'ERROR: no .yak in the latest release.' -ForegroundColor Red; Read-Host 'Press Enter to exit'; exit 1}; $pkgDir=Join-Path $env:APPDATA 'McNeel\Rhinoceros\packages\8.0\pika'; $installed='not installed'; if (Test-Path $pkgDir) { $v = Get-ChildItem $pkgDir -Directory -ErrorAction SilentlyContinue | Sort-Object { try { [version]$_.Name } catch { [version]'0.0.0' } } | Select-Object -Last 1; if ($v) { $installed = $v.Name } }; Write-Host ''; Write-Host ('Installed : ' + $installed) -ForegroundColor Cyan; Write-Host ('Available : ' + $r.tag_name) -ForegroundColor Cyan; Write-Host ''; if ($r.body) { $bl = $r.body -split '\r?\n'; $si=-1; for ($i=0;$i -lt $bl.Count;$i++){ if ($bl[$i] -match 'TL;DR'){ $si=$i+1; break } }; if ($si -ge 0) { $bug1=[char]::ConvertFromUtf32(0x1F41B); $bug2=[char]::ConvertFromUtf32(0x1F41E); $others=@(); $bugs=@(); for ($j=$si;$j -lt $bl.Count;$j++){ if ($bl[$j] -match '^---'){ break }; if ($bl[$j].Trim() -eq ''){ continue }; if ($bl[$j].Contains($bug1) -or $bl[$j].Contains($bug2)) { $bugs += $bl[$j] } else { $others += $bl[$j] } }; if ($others.Count -gt 0) { Write-Host 'That New New' -ForegroundColor Green; foreach ($ln in $others) { Write-Host $ln } }; if ($bugs.Count -gt 0) { Write-Host ''; Write-Host 'Broke Shit We Fixed' -ForegroundColor Red; foreach ($ln in $bugs) { Write-Host $ln } }; Write-Host '' } }; $t=Join-Path $env:TEMP 'pika-update'; Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue; New-Item -ItemType Directory -Force $t | Out-Null; $d=Join-Path $t $a.name; Write-Host ('Downloading ' + $r.tag_name + '  (' + $a.name + ')...'); Invoke-WebRequest $a.browser_download_url -OutFile $d; Write-Host 'Installing into Rhino 8...'; & $yak install --source $t pika; Write-Host ''; Write-Host 'Done. Now restart Rhino 8 and type:  Pika' -ForegroundColor Green; Read-Host 'Press Enter to close'"

endlocal
