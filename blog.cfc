<cfcomponent>
    <cffunction name="getEmpList" access="remote" returntype="any">
		<cfquery name="EmpList" datasource="cfdocexamples" result="tmpResult">
		    SELECT FirstName, LastName, Salary, Contract
		    FROM Employee
		</cfquery>
        <cfreturn cf2ng(EmpList)>
        <!--- <cfreturn EmpList> --->
    </cffunction>

    <cffunction name="cf2ng" access="remote" returntype="string">     
        <cfargument name="data" type="any" required="Yes" />

        <!--- Variable Decralation --->
        <cfset var jsonString = "" />

        <cfset columnListName = arrayNew(1)>

        <!--- Query Column Name to Set Array --->
        <cfloop index="lpc" from="1" to="#listLen(data.columnList, ',')#">
            <cfset columnListName[lpc] = LCase(listGetAt(#data.columnlist#, #lpc#, ","))>
        </cfloop>

        <cfset jsonString = "[">

        <cfloop query="data">
          <cfset jsonString = #jsonString# &  '{"'>
          <cfloop index="lpcnt" from="1" to="#listLen(data.columnList, ',')#">
                <cfset jsonString = #jsonString# & columnListName[lpcnt] & '":"'>
                <cfset tmpvalue = #data[columnListName[lpcnt]][data.currentRow]#>

                <cfif lpcnt eq #listLen(data.columnList, ',')#>
                    <cfset jsonString = #jsonString# & #tmpvalue# & '"},'>
                <cfelse>
                    <cfset jsonString = #jsonString# & #tmpvalue# & '","'> 
                </cfif>
          </cfloop>
        </cfloop>

        <cfset jsonString =  mid(#jsonString#, 1, len(jsonString)-1) & "]">

        <cffile action="write" file="c:\temp\testest.txt" output="#jsonString#">
        <cfreturn jsonString>
    </cffunction>
</cfcomponent>