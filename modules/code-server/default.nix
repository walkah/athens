{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ code-server ];
}
