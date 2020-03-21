.PHONY: all
all: ;

install-config: \
	~/.config/fish/config.fish \
	~/.config/fish/fish_variables \
	~/.tmux.conf \
	~/.config/nvim/init.vim \
	~/.gitconfig-global \
	~/.gitignore-global \
	;

install-essentials: \
	~/tools/bin/fzf \
	~/tools/bin/rg \
	~/tools/bin/fd \
	~/tools/bin/direnv \
	~/tools/bin/nvim \
	~/tools/bin/tmux \
	;

~/.config/fish/config.fish: .config/fish/config.fish
	mkdir -p ~/.config/fish
	cp .config/fish/config.fish ~/.config/fish/config.fish

~/.config/fish/fish_variables: .config/fish/fish_variables
	mkdir -p ~/.config/fish
	cp .config/fish/fish_variables ~/.config/fish/fish_variables

~/.tmux.conf: .tmux.conf
	cp .tmux.conf ~/.tmux.conf

~/.config/nvim/init.vim: .config/nvim/init.vim
	mkdir -p ~/.config/nvim
	cp .config/nvim/init.vim ~/.config/nvim/init.vim

~/.gitconfig-global: .gitconfig-global
	if ! grep -q 'path = ~/.gitconfig-global' ~/.gitconfig; then echo "\n[include]\n\tpath = ~/.gitconfig-global" | tee -a ~/.gitconfig; fi
	cp .gitconfig-global ~/.gitconfig-global

~/.gitignore-global: .gitignore-global
	cp .gitignore-global ~/.gitignore-global

~/tools/bin/fzf:
	mkdir -p ~/.config/fish/functions
	wget -O ~/.config/fish/functions/fzf_key_bindings.fish https://raw.githubusercontent.com/junegunn/fzf/0.20.0/shell/key-bindings.fish
	sed -i -e 's/ct fzf-file-widget/cy fzf-file-widget/g' ~/.config/fish/functions/fzf_key_bindings.fish
	mkdir -p ~/tools/bin
	wget -O - https://github.com/junegunn/fzf-bin/releases/download/0.20.0/fzf-0.20.0-$(shell uname | tr '[:upper:]' '[:lower:]')_amd64.tgz | tar -C ~/tools/bin -xzf -
	chmod +x ~/tools/bin/fzf

~/tools/bin/rg:
	mkdir -p ~/tools/bin
ifeq ($(shell uname -s),Linux)
	wget -O - https://github.com/BurntSushi/ripgrep/releases/download/12.0.0/ripgrep-12.0.0-x86_64-unknown-linux-musl.tar.gz | tar -C ~/tools -xzf -
	ln -s ../ripgrep-12.0.0-x86_64-unknown-linux-musl/rg ~/tools/bin/rg
endif
ifeq ($(shell uname -s),Darwin)
	wget -O - https://github.com/BurntSushi/ripgrep/releases/download/12.0.0/ripgrep-12.0.0-x86_64-apple-darwin.tar.gz | tar -C ~/tools -xzf -	
	ln -s ../ripgrep-12.0.0-x86_64-apple-darwin/rg ~/tools/bin/rg
endif

~/tools/bin/fd:
	mkdir -p ~/tools/bin
ifeq ($(shell uname -s),Linux)
	wget -O - https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-v7.4.0-x86_64-unknown-linux-musl.tar.gz | tar -C ~/tools -xzf -
	ln -s ../fd-v7.4.0-x86_64-unknown-linux-musl/fd ~/tools/bin/fd
endif
ifeq ($(shell uname -s),Darwin)
	wget -O - https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-v7.4.0-x86_64-apple-darwin.tar.gz | tar -C ~/tools -xzf -
	ln -s ../fd-v7.4.0-x86_64-apple-darwin/fd ~/tools/bin/fd
endif

~/tools/bin/direnv:
	mkdir -p ~/tools/bin
	wget -O ~/tools/bin/direnv https://github.com/direnv/direnv/releases/download/v2.21.2/direnv.$(shell uname | tr '[:upper:]' '[:lower:]')-amd64
	chmod +x ~/tools/bin/direnv

~/tools/bin/nvim:
	mkdir -p ~/.config/nvim/colors
	wget -O ~/.config/nvim/colors/base16-eighties.vim https://raw.githubusercontent.com/chriskempson/base16-vim/master/colors/base16-eighties.vim
	mkdir -p ~/tools/bin
ifeq ($(shell uname -s),Linux)
	wget -O - https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz | tar -C ~/tools -xzf -
	ln -s ../nvim-linux64/bin/nvim ~/tools/bin/nvim
endif
ifeq ($(shell uname -s),Darwin)
	wget -O - https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-macos.tar.gz | tar -C ~/tools -xzf -
	ln -s ../nvim-osx64/bin/nvim ~/tools/bin/nvim
endif

~/tools/bin/tmux:
ifeq ($(shell uname -s),Linux)
	mkdir -p ~/tools/bin
	wget -O ~/tools/bin/tmux https://github.com/nelsonenzo/tmux-appimage/releases/download/3.0a-appimage0.1.0/tmux-3.0a-x86_64.AppImage
	chmod +x ~/tools/bin/tmux
endif
