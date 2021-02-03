component accessors="true"{

	property name="settings" inject="coldbox:moduleSettings:api-auth-helper";
	property name="authToken" type="string";
	property name="authTokenExpirationDateTime" type="string";

	any function getApiToken(){

		var token = "";
		var currentDateTime = now();
		var expirationDateTime = now();

		// If no Token exists, create one
		if( (this.getAuthToken() EQ "") AND (this.getAuthTokenExpirationDateTime() EQ "") ){
			token = deserializeJson(makeTokenRequest().content).access_token;
			setAuthToken(token);
			setAuthTokenExpirationDateTime(dateTimeFormat(currentDateTime, "yyyy-mm-dd HH:nn:ss"));
		} else {
			expirationDateTime = dateTimeFormat(getAuthTokenExpirationDateTime(), "yyyy-mm-dd HH:nn:ss");
			var totalMinutes = datediff("n", expirationDateTime, currentDateTime);

			if (totalMinutes > 59){
				token = deserializeJson(makeTokenRequest().content).access_token;
				setAuthToken(token);
				setAuthTokenExpirationDateTime(dateTimeFormat(currentDateTime, "yyyy-mm-dd HH:nn:ss"));
			}
		}

		return getAuthToken();
	}

	any function makeTokenRequest(){

		cfhttp(
			method="POST",
			charset="utf-8",
			url=settings.tokenEndpoint,
			result="result"
		){
			cfhttpparam(type="header", name="Content-Type", value="application/x-www-form-urlencoded");
			cfhttpparam(type="formfield", name="grant_type", value="client_credentials");
			cfhttpparam(type="formfield", name="client_id", value=settings.clientId);
			cfhttpparam(type="formfield", name="client_secret", value=settings.clientSecret);
		}

		if(result.ResponseHeader['Status_Code'] == '200') {
			response.success = true;
			response.content = result.FileContent;
		} else {
			response.success = false;
			response.content = result.Statuscode;
		}

	  	return response;
	}
}