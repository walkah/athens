{ pkgs, ... }: {

  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;

    # see here for more info: https://minecraft.gamepedia.com/Server.properties#server.properties
    serverProperties = {
      server-port = 25565;
      gamemode = "survival";
      motd = "Vanilla Survival";
      max-players = 20;
      white-list = true;
    };

    # Grab UUIDs from https://mcuuid.net/
    whitelist = {
      walkahj = "7209094c-b3ef-4c89-b8cd-0aef7c1d57a6";
      puffpuffpassion = "72e0d040-fa54-47e8-a6e7-162fdaa0cac5";
    };
  };
}
