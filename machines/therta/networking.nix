{
  # https://www.reddit.com/r/NixOS/comments/1ix7asv/comment/mekh866/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  networking.networkManager.ensureProfile.profiles = {
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
        dns = [
          "1.1.1.1"
        ];
      };
    };
  };
}
