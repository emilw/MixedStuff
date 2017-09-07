Param(
  [string]$serverName = ".",
  [string]$database = "mediusflow",
  [string]$table = "[Medius.Core.Entities].[Company]",
  [string]$columnNameName = "Name",
  [string]$columnNameContent = "OrganizationNumber",
  [string]$outputFolder = "out",
  [string]$fileExtension = "txt",
  [string]$dbUser,
  [string]$dbPwd,
  [string]$encoding = "ASCII"
)

#No changes beneath this line
$fullFolderPath = $PSScriptRoot + "\" + $outputFolder

Write-Host "Checking if output folder exists";

if (-not (Test-Path $fullFolderPath)){
	New-Item -ItemType directory -Path $fullFolderPath
    Write-Host "Creating folder $out at $fullFolderPath";
}

Write-Host "Connecting to server $serverName and database $database";
Write-Host "Retrieving $columnNameName as filename and $columnNameContent as file content from $table and saves it in folder $fullFolderPath"

$connectionString = "Server=$serverName;Database=$database";

$sqlConnection = New-Object System.Data.SqlClient.SqlConnection;
if($dbUser){
    $sqlConnection.ConnectionString = $connectionString + ";Integrated Security=false;User Id=$dbUser;Password=$dbPwd";
}else{
    Write-Host "No database user or password provided, Integrated security will be used";
    $sqlConnection.ConnectionString = $connectionString + ";Integrated Security=true";
}

$sqlCommand = New-Object System.Data.SqlClient.SqlCommand;
$sqlCommand.Connection = $sqlConnection;
$sqlCommand.CommandText = "Select $columnNameName, $columnNameContent From $table";
$sqlDataAdapter = New-Object System.Data.SqlClient.SqlDataAdapter;
$sqlDataAdapter.SelectCommand = $sqlCommand;
$sqlDataSet = New-Object System.Data.DataSet;
Write-Host "Getting the data..."

$sqlDataAdapter.Fill($sqlDataSet);
$numberOfRows = $sqlDataSet.Tables[0].Rows.Count;
Write-Host "The number of rows fetched was $numberOfRows";
if($numberOfRows -gt 0){
    Write-Host "Creating files";

    foreach($row in $sqlDataSet.Tables[0].Rows){
        $fileName = $row[$columnNameName];
        $fileContent = $row[$columnNameContent];

        $fullFilePath = $fullFolderPath + "\" + $fileName + "." + $fileExtension;

        Set-Content -LiteralPath $fullFilePath -Value $fileContent -Encoding $encoding;
    }
    
    Write-Host "All files have been written, please check output in folder:" -ForegroundColor Green;
    Write-Host $fullFolderPath -ForegroundColor Green
} else{
    Write-Host "There were no files to write, please check the following:" -ForegroundColor Red;
    Write-Host "- Error above will indicate if it is a problem with the connection string" -ForegroundColor Red;
    Write-Host "- Below is the constructed query" -ForegroundColor Red;
    Write-Host "Sql query:";
    Write-Host $sqlCommand.CommandText;
    Write-Host "Connection string:";
    Write-Host $sqlConnection.ConnectionString;
    Write-Host "Full folder path:";
    Write-Host $fullFolderPath;
}