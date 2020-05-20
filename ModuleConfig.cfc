component {
    // Module Properties
    this.title          = "API Auth Helper";
    this.name           = "api-auth-helper";
    this.author         = "Mike Burt";
    this.webUrl         = "https://github.com/octanner/scs-api-auth-helper";
    this.description    = "A module to help authenticate to an API manager";
    this.version            = "1.0.1";
    // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
    this.viewParentLookup   = true;
    // If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
    this.layoutParentLookup = true;
    // Module Entry Point
    this.entryPoint         = "api-auth-helper";
    // CF Mapping
    this.cfMapping          = "api-auth-helper";

    function configure() {
        settings = {
            clientId = "1a2b3c",
            clientSecret = "shhhhItsaSecret",
            tokenEndpoint = "https://any-api.com/"
        };
    }
}