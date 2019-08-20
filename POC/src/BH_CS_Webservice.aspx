<%@ Page Language="C#"  ContentType="application/json;charset=UTF-8" Inherits="BackEndlogic" %>
<%@ Import Namespace="Newtonsoft.Json.Linq"%>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="log4net" %>
<%@ Import Namespace="logSessionCore" %>
<%@ Import Namespace="BHWebRequest"%>

<script runat="server">
    
    public override JObject PerformLogic(JObject state, Hashtable additionalParams)
    {
		 
        JObject result = new JObject();
        JObject appSession = ((JObject)state["appSession"]);//Getting appsession
      
        
       
  	    JObject requestObj;
  	    JObject requestObj1;
  		JObject WS_Response;
  		
    	try 
    	{ 
    		
    	
    		
    		string filepath="/src/BH_CSWS02.json";
    		string appPath = string.Format("{0}://{1}{2}{3}{4}",
                                        HttpContext.Current.Request.Url.Scheme,
                                        HttpContext.Current.Request.Url.Host,
                                        HttpContext.Current.Request.Url.Port == 80
                                            ? string.Empty
                                            : ":" + HttpContext.Current.Request.Url.Port,
                                        "/POC", filepath);
        
        	
       
                	
                	requestObj = JObject.Parse(new System.Net.WebClient().DownloadString(appPath));
        			
        				//JObject delurl=new JObject(new JProperty("URL",(string)requestObj["get"]["WebUrl"]));
        				//requestObj["delete"]["WebUrl"].Replace(delurl["URL"]);
        				requestObj1=JObject.Parse(requestObj["get"].ToString());
        				WS_Response=JObject.Parse(BHWebRequest.ExecuteWebRequest(requestObj1));
        				if(WS_Response["audioString"]!= null)
        				{
        					appSession["BH_CSWS02"]["GetResponse"].Replace(WS_Response);
        					appSession["BH_CSWS02_Status"].Replace(appSession["BH_WebserviceStatusREST"]);
        				}
        				else
        				{
        					appSession["BH_CSWS02"]["GetResponse"].Replace(WS_Response);
        					appSession["BH_CSWS02_Status"].Replace(appSession["BH_WebserviceStatusError"]);
        				}
        				
        			
        			
                 
            
        	
        
        }
        catch (Exception exc) 
        {	//Log error info
			
		}
		result = new JObject(new JProperty("appSession", appSession));
        
        return result;
       
        
        
        
        
        
       
    }


</script>