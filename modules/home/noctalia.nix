{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      margin_edge = 0;
      border = "outline";
      border_width = 1.0;
    };
  };
}
