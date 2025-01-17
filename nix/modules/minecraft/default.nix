_: {

  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;

    # see here for more info: https://minecraft.gamepedia.com/Server.properties#server.properties
    serverProperties = {
      server-port = 25565;
      enable-query = true;
      gamemode = "survival";
      motd = "Vanilla Survival";
      max-players = 20;
      white-list = true;
    };

    # Grab UUIDs from https://mcuuid.net/
    whitelist = {
      walkahj = "7209094c-b3ef-4c89-b8cd-0aef7c1d57a6";
      puffpuffpassion = "72e0d040-fa54-47e8-a6e7-162fdaa0cac5";
      rafadoodle = "9a7c860e-e269-4c38-b2f7-ca5533c27e98";
      camylamb = "c9fcbfa1-89da-4cf9-97fe-b9e5290a4eb4";
      shortychark = "3f420f61-867f-4651-a849-d2e54f8c220d";
    };
  };
}
