{config, pkgs, ...}:

{

  programs.wofi = {
    enable = true;

    settings = {
      width = 660;
      height = 410;
      location="center";
      show="drun";
      prompt="Look up...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
      normal_window = true;
    };

    style =
    ''
      * {
        font-family: monospace;
        font-weight: 600;
      }

      window {
          margin: 0px;
          background: rgba(20, 20, 20, 0.8);
          padding: 20px;
          border-radius: 15px;
          border: none;
          font-weight: bold;
      }

      #outer-box {
          border-radius: 15px;
          padding: 15px;
          width: 100%;
          height: 100%;
       /*   border: 2px solid rgb(225, 225, 225); */
      }

      #entry {
          background: transparent;
          margin-bottom: 10px;
          padding: 8px 10px;
          border-radius: 10px;
          color: white;
      }

      #entry:selected {
          background-color: rgba(232, 232, 232, 0.2);
          box-shadow: inset 0 0 5px rgba(205, 205, 205, 0.5);
          color: white;
      }

      #entry:focus {
          outline: none;
      }

      #entry:last-child {
          margin-bottom: 0;
      }

      #text {
          font-size: 14px;
      }

      #input {
          border-radius: 15px;
          background: rgba(255, 255, 255, 0.05);
          border: none;
          padding: 10px;
          color: white;
          margin-bottom: 15px;
      }

      #img {
          margin-right: 10px;
      }
    '';

  };

}
