function installSQLPackage {
    if ($null -eq (Get-Package -Name "SqlServer" -ErrorAction SilentlyContinue)) {
        Write-Host "Pacote SqlServer não encontrado. Instalando..."

        # Instalar o pacote SqlServer
        Install-Package -Name "SqlServer" -Force -AllowClobber -Scope CurrentUser > $null 2>&1

        Write-Host "Pacote SqlServer instalado com sucesso."
    } else {
        Write-Host "Pacote SqlServer já está instalado."
    }
}


function databaseConn {
    $envFile = ".\.env"

    Get-Content $envFile | ForEach-Object {

        if ($_ -and $_ -notmatch '^\s*#') {
            
            # Separar a chave e o valor
            $key, $value = $_ -split '=', 2

            # Definir a variável de ambiente no PowerShell (Possibilita usar $env:VariavelNome)
            [System.Environment]::SetEnvironmentVariable($key.Trim(), $value.Trim(), [System.EnvironmentVariableTarget]::Process)
        }
    }

    try {
    if ($env:SERVER -eq "") { $env:SERVER = read-host "Enter the hostname/IP address of the SQL server" }
    if ($env:DATABASE -eq "") { $env:DATABASE = read-host "Enter the database name" }
    if ($env:USERNAME -eq "") { $env:USERNAME = read-host "Enter the database username" }
    if ($env:PASSWORD -eq "") { $env:PASSWORD = read-host "Enter the database user password" }
    if ($env:QUERY -eq "") { $env:QUERY = read-host "Enter the database query" }
    } catch {
        Write-Output "Arquivo .env não encontrado."
    }

    return "Server=$env:SERVER;Database=$env:DATABASE;User Id=$env:USERNAME;Password=$env:PASSWORD;TrustServerCertificate=True;"
}

    
# Execução da query e criação do arquivo CSV
function convertCreate {
    param(
        [string]$tabela,
        [string]$sql,
        [string]$connString,
        [string]$path = "Importacao"
    )

    try {
        $formattedDate = Get-Date -Format "dd_MM_yyyy_HH_mm_ss"

        $csvfilepath = "$PSScriptRoot\$path\Importacoes\TABELA-$tabela-$formattedDate.csv"

        $directory = [System.IO.Path]::GetDirectoryName($csvfilepath)
        Write-Output $directory
        if (-not (Test-Path $directory)) {
            # Se o diretório não existir, cria o diretório
            Write-Output "Criando diretório: $directory"
            New-Item -Path $directory -ItemType Directory -Force | Out-Null
        }

        $result =  Invoke-Sqlcmd -Query $sql -ConnectionString $connString
    
        $result | Export-Csv $csvfilepath -NoTypeInformation
    } catch {
        Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        return 1
    }

    return 
}


function createTestDataBase {
    $endLoop = 0
    $sqlFile = "$PSScriptRoot\QUERY\query.sql"
    $sqlQuery = Get-Content -Path $sqlFile -Raw
    while ($endLoop -eq 0) {
        $TestDatabase = Read-Host "Você deseja criar um banco como teste em sua instância para realizar o teste do script? (S/n)"
        $conn = "Server=localhost;;Database=Teste;Integrated Security=True;TrustServerCertificate=True;"
        if ($TestDatabase -eq "S") {
            Invoke-Sqlcmd -ConnectionString $conn -Query "IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'teste') BEGIN CREATE LOGIN teste WITH PASSWORD = '123456';END"
            Write-Output "Criação de usuário e atribuição de privilégios concluídas com sucesso!"

            Invoke-Sqlcmd -ConnectionString $conn -Query "if NOT exists(select name from sys.databases where name = 'Teste') BEGIN CREATE DATABASE Teste;END"
            Write-Output "Criação de banco concluída com sucesso!"

            # Write-Output $sqlQuery
            Invoke-Sqlcmd -ConnectionString $conn -InputFile $sqlFile
            Write-Output "Criação de conteúdos no banco foi concluída com sucesso!"
            return 
        } elseif ($TestDatabase -eq "n") {
            # Prosseguir com o processo
            Clear-Host
            return
        } else {
            Write-Output "Comando inválido"
        }
    }
}


# Interface
function main {
    # Conferir se o Pacote está instalado
    installSQLPackage
    # Gerar banco teste e usuário para realizar o teste
    createTestDataBase

    $list = New-Object System.Collections.Generic.List[System.String]

    $stringConn = databaseConn

    $query = Invoke-Sqlcmd -Query "select name from sys.tables" -ConnectionString $stringConn

    foreach ($table in $query) {
        $table = $table.name
        $list.Add("$table")
    }

    $op = 1
    $sql = ""

    while ($op -ne 0) {
        Write-Output "Selecione digite um numero para importar os dados das tabelas a seguir: "
        
        $query = Invoke-Sqlcmd -Query "select name from sys.tables" -ConnectionString $stringConn
        $option = 1
        foreach ($t in $list) {
            Write-Output "[ $option ] $t"
            $option = $option + 1
        }
        Write-Output "[ 999 ] Fazer a importação de todas as tabelas."

        $op1 = Read-Host "Escolha uma opção ou digite 0 para sair"
        
        if ($op1 -match '^\d+$' -and [int]$op1 -ge 0) {
            $op = [int]$op1
        } else {
            Write-Output "Opção inválida. Tente novamente."
        }


        if ($op -ge 1 -and $op -le $list.Count) {
            $temp = $list[$op - 1]
            $sql = "SELECT * FROM $temp"
            
            # Write-Output $sql, $stringConn
            # Envia a query em SQL e a conexão do banco em string para fazer o processo de criação do arquivo.
            convertCreate -tabela $temp -sql $sql -connString $stringConn -path $null
        } elseif ($op -eq 999) {
            Clear-Host
            Write-Output "`n`nIniciando a exportação em massa de todas as tabelas..."

            $path = Read-Host "`n`nInsira o caminho para ser feito a exportacao em massa. (ex.: \importacao) `n`n"
            
            foreach ($table in $list) {
                $sql = "SELECT * FROM $table"
                Write-Output "`nExportando tabela: $table"
                

                # Write-Output $sql, $stringConn
                # Envia a query em SQL e a conexão do banco em string para fazer o processo de criação do arquivo.
                convertCreate -tabela $table -sql $sql -connString $stringConn -path $path
            }

            Write-Output "Todas as tabelas foram corretamente importadas!"
            Start-Sleep -Seconds 3
            Clear-Host
        } elseif ($op -eq 0) {
            Start-Sleep -Seconds 2
            Clear-Host
        } else {
            Write-Output "Opção inválida. Tente novamente."
        }
    }
}


main