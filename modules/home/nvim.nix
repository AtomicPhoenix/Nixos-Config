{
  pkgs,
  ...
}: {
  programs.neovim = {
	viAlias = true;
  	vimAlias = true;
	enable = true;
  	extraConfig = ''
  	'';
  };
}

