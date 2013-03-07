#OBS: � muito importante que a entrada SourcePath dos arquivos de configura��o do protheus 10 tenham o �ltimo caracter como sendo "\", indicando que � um diret�rio. Pois se n�o estiver dessa forma podem ser apresentadas mensagens de erro na execu��o do Script.

#Diret�rio de origem do RPO compilado para Homologa��o
$comphlg = "C:\Protheus10_TST\apo\CompHLG"

#Declara vari�veis a utilizar no tratamento do totvsappserver.copyini
$find       	= ""
#Diret�rio de bin�rios do Protheus 10
$pathbin    	= "C:\Protheus10_TST\bin"
#Arquivo INI que ser� trabalhado para altera��o do RPO
$copyIniFile	= "totvsappserver.copyini"
#Diretorio dos RPOs de destino, ou seja, o que se quer atualizar. Destino.
$rpospath		= "C:\Protheus10_TST\apo\RPOsHomolog\"
#String de busca do sourcepath do arquivo INI
$rposmatch  	= get-childitem -path $rposPath
#Arquivo RPO que ser� copiado
$rpoName		= "tttp101.rpo"
	 
#Chama o script que copia o totvsappserver.ini para totvsappserver.copyini
Invoke-Expression -Command "$pathbin\Scripts\SaveCopyIni.ps1"
	 
#strings que v�o ser utilizadas para verificar qual RPO o INI est� apontando
$find00      = "sourcepath=C:\\Protheus10_TST\\apo\\RPOsHomolog\\rpo00\\"
$find01      = "sourcepath=C:\\Protheus10_TST\\apo\\RPOsHomolog\\rpo01\\"
$find02      = "sourcepath=C:\\Protheus10_TST\\apo\\RPOsHomolog\\rpo02\\"
$find03      = "sourcepath=C:\\Protheus10_TST\\apo\\RPOsHomolog\\rpo03\\"
$find04      = "sourcepath=C:\\Protheus10_TST\\apo\\RPOsHomolog\\rpo04\\"
$match	     = get-childitem -path $pathbin -include $copyIniFile -recurse | select-string $find00 -list

#Cadeia de SE que checa se a string procurada est� contida no INI e armazena na vari�vel $find que ser� utilizada para alterar o sourcepath do arquivo totvsappserver.copyini
if ( $match -match $find00 )
{
	$find		= $find00
	$TargetFilePathRpoSync = "C:\Protheus10_TST\apo\RPOsHomolog\rpo01\"
}
else
{
	$match	     = get-childitem -path $pathbin -include $copyIniFile -recurse | select-string $find01 -list
	if ( $match -match $find01 )
	{
		$find		= $find01
		$TargetFilePathRpoSync = "C:\Protheus10_TST\apo\RPOsHomolog\rpo02\"
	}
	else
	{	
		$match	    = get-childitem -path $pathbin -include $copyIniFile -recurse | select-string $find02 -list
		if ( $match -match $find02 )
		{
			$find		= $find02
			$TargetFilePathRpoSync = "C:\Protheus10_TST\apo\RPOsHomolog\rpo03\"
		}
		else
		{
			$match	    = get-childitem -path $pathbin -include $copyIniFile -recurse | select-string $find03 -list
			if ( $match -match $find03 )
			{
				$find		= $find03
				$TargetFilePathRpoSync = "C:\Protheus10_TST\apo\RPOsHomolog\rpo04\"
			}
			else
			{
				$find       = $find04
				$TargetFilePathRpoSync = "C:\Protheus10_TST\apo\RPOsHomolog\rpo00\"
			}
		}	
	}	
}
#Uma que n�o exista o caracter "\" no final do caminho de destino do RPO, inclui esse caracter
if( !$TargetFilePathRpoSync.endsWith("\")) 
{
	$TargetFilePathRpoSync+="\" 
}
#Adiciona a string SourcePath no in�cio do caminho de destino do RPO
$replace = "SourcePath="
$replace += $TargetFilePathRpoSync
$TargetFilePathRpoSync += $rpoName
#Comp�e o caminho do RPO source, que ser� utilizado para atualizar o diret�rio destino 
$SourceFilePathRpoSync = $comphlg
if( !$SourceFilePathRpoSync.endsWith("\")) 
{ 
	$SourceFilePathRpoSync+="\" 
}
$SourceFilePathRpoSync += $rpoName

#Testa se o RPO de destino n�o existe ou tem data de modifica��o inferior ao de origem. Nesse caso ent�o remove o RPO de destino, copia o RPO de origem no destino e altera o caminho no totvsappserver.copyini
if(!(Test-Path $TargetFilePathRpoSync) -or ((get-item $SourceFilePathRpoSync).lastWriteTime -gt (get-item $TargetFilePathRpoSync).lastWriteTime))
{
	if(Test-Path $TargetFilePathRpoSync)
	{
		Remove-Item -Force $TargetFilePathRpoSync
	}
	#Esse � o comando que copia efetivamente o RPO de origem para o caminho de destino
	copy-item $SourceFilePathRpoSync $TargetFilePathRpoSync -force
	#Essa � a linha de comando que, utilizando as vari�veis trabalhadas anteriormente, substitui efetivamente o sourcepath nos arquivos totvsappserver.copyini
	get-childitem -path $pathbin -include $copyIniFile -recurse | % { (get-content $_) |% { $_ -replace $find,$replace } | set-content $_ -force }
}

#Chama o script que copia o totvsappserver.copyini para totvsappserver.ini
Invoke-Expression -Command "$pathbin\Scripts\RestoreCopyIni.ps1"
