{nix, ...}: {
  nix.gc = {
    automatic = true;
    dates = "03:15";
    persistent = true;
  };
}
