#! /bin/bash

bamboohr_api="https://api.bamboohr.com/api/gateway.php/thechopegroup/v1/"
directory_for_test="employees/directory"
timeoff_requests="time_off/requests/"
timeoff_request="time_off/request/"

apikey=$1
operation=$2
employeeid=employees/$3/
startdate=$4
enddate=$5

auth=${apikey}":x"

if [[ ${operation} == "test" ]]; then
	opcmd="curl -i -u $auth $bamboohr_api$directory_for_test"
elif [[ ${operation} == "requests" ]]; then 
	opcmd="curl -i -u $auth $bamboohr_api$timeoff_requests"
elif [[ ${operation} == "timeoff" ]]; then 
	body="<request>
    	<status>approved</status>
    	<start>$4</start>
    	<end>$5</end>
    	<timeOffTypeId>1</timeOffTypeId>
	    <notes>
	        <note from='employee'>testing bamboohr</note>
	        <note from='manager'>Test for bamboo api usage, please ignore</note>
	    </notes>
	</request>"
	opcmd="curl -i -u $auth $bamboohr_api$employeeid$timeoff_request -H 'Content-Type:application/xml' -X PUT -d \"$body\""
else
 	echo "Oops, the arguement error"
 	echo "parameter 1 apikey, the key can be found from BambooHR system, click avatar then API Keys"
 	echo "parameter 2 operation (test/requests/timeoff)"
 	echo "parameter 3 employeeid for timeoff"
 	echo "parameter 4 startdate for timeoff (YYYY-MM-DD)"
    echo "parameter 5 enddate for timeoff (YYYY-MM-DD)"
    echo "example:"
    echo "sh bamboohr.sh xxxxxxxxxxxxxx timeoff 1 2018-10-01 2018-10-02"
fi

echo "start..."
echo $opcmd 
eval $opcmd
echo "done..."