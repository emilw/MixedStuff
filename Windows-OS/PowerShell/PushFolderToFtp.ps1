"Starting..."

$folder = "E:\Temp\TestSite\"

$directory = New-Object System.IO.DirectoryInfo($folder)

if(!$directory.Exists)
{
	"Folder do not exists"
}
else
{
	"It exists"
	
	"Files in folder:"
	foreach($file in $directory.GetFiles())
	{
		$file.Name
	}
}


#####
#$ftpPath = "ftp://postback.se/emil.postback.se/"
## Get the object used to communicate with the server.
#$request = [System.Net.WebRequest]::Create($ftpPath)
#$request.UsePassive = false
#$request.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
## This example assumes the FTP site uses anonymous logon.
#$request.Credentials = New-Object System.Net.NetworkCredential("postback","lightweight")
#
#$response = $request.GetResponse()
##FtpWebResponse response = (FtpWebResponse)request.GetResponse();
#    
#$responseStream = $response.GetResponseStream()
#$reader = New-Object System.IO.StreamReader($responseStream)
#"Output for " + $ftpPath + ":"
#$reader.ReadToEnd()
#"End of output"
#
#"Download Complete, status " + $response.StatusDescription
#
#$reader.Close()
#$response.Close()
