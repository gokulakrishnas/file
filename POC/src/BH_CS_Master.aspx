
<%@ Page Language="C#"  ContentType="application/json;charset=UTF-8" Inherits="BackEndlogic" %>
<%@ Import Namespace="Newtonsoft.Json.Linq"%>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="log4net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="logSessionCore" %> 


<script runat="server">
    
    public override JObject PerformLogic(JObject state, Hashtable additionalParams)
    {

       JObject result = new JObject(); 
      
       
      
       
       try
       {
       
       
       
       string BH_CS_Master_filepath="/src/BH_CS_Master.json";
	   string BH_CS_Master_appPath = string.Format("{0}://{1}{2}{3}{4}",
                                    HttpContext.Current.Request.Url.Scheme,
                                    HttpContext.Current.Request.Url.Host,
                                    HttpContext.Current.Request.Url.Port == 80
                                        ? string.Empty
                                        : ":" + HttpContext.Current.Request.Url.Port,
                                    HttpContext.Current.Request.ApplicationPath,BH_CS_Master_filepath);
        JObject appSession =JObject.Parse(new System.Net.WebClient().DownloadString(BH_CS_Master_appPath));
        
       
        result = new JObject(new JProperty("appSession", appSession));
        
        
        
       
        }
        catch (Exception exc) 
        {	//Log error info
		
		}
        
        return result;
    }

    

</script>