{
  # The server at home has a dynamic ip which is an issue, I dont want to get suprised when I cant ssh in because the ip is different.
  # So I tried to make my ip for the server static, but its not working rn. If I am having problems sshing into the server than Ill revisit this. 
  # or prehaps just use dhcp reservation in my router setting? Anyways, I want my second monitor back for my main desktop.
  # https://www.reddit.com/r/NixOS/comments/1ix7asv/comment/mekh866/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  networking.networkmanager.ensureProfiles.profiles = {
    "server" = {
      connection = {
        type = "wifi"; # hopefully eithernet with da switch soon
        id = "therta-server";
        interface-name = "wlp0s20f0u2";
        autoconnect = true;
      };

      ipv4 = {
        method = "manual";
        addresses = "192.168.4.100/24";
        gateway = "192.168.4.1";
        dns = "1.1.1.1";
      };
    };
  };
}
