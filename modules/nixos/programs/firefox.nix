{
  config,
  lib,
  ...
}: {
  options.firefox.enable = lib.mkEnableOption "enable firefox";

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;

      # https://mozilla.github.io/policy-templates/
      policies = {
        AIControls.Default.Value = "blocked";

        AutofillCreditCardEnabled = false;
        BrowserDataBackup = {
          AllowBackup = false;
          AllowRestore = false;
        };

        Cookies.Behavior = "reject-tracker-and-partition-foreign";
        DisableTelemetry = true;

        FirefoxHome = {
          Highlights = false;
          Search = false;
          SponsoredStories = false;
          SponsoredTopSites = false;
          Stories = false;
          TopSites = true;
        };
      };
    };
  };
}
