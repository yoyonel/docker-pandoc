FROM debian:latest

RUN apt-get update && \
	apt-get install -y \
		make \
		context \
		pandoc \
		pandoc-citeproc \
		texlive-xetex \
		git

# Install:
# - wget curl
# - packages to install mscorefonts
RUN apt-get install -y \
	python-pdfminer \
	wget curl \
	cabextract xfonts-utils

# mscorefonts
# url: https://doc.ubuntu-fr.org/msttcorefonts
# Fonts: Verdana
RUN wget \
		http://ftp.fr.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb && \
	dpkg -i ttf-mscorefonts-installer_3.6_all.deb && \
	rm -f ttf-mscorefonts-installer_3.6_all.deb

# Font: Menlo
# url: https://github.com/hbin/top-programming-fonts
RUN curl -L \
	https://github.com/hbin/top-programming-fonts/raw/master/install.sh | \
	bash

# Font: Source Pro Code

# Ne fonctionne pas !
# url: https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116
# RUN [ -d /usr/share/fonts/opentype ] || mkdir -p /usr/share/fonts/opentype && \
# 	git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp && \
# 	fc-cache -f -v

# Fonctionne et patchée en plus :p
RUN wget https://github.com/stefano-meschiari/dotemacs/raw/master/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf && \
	mkdir -p ~/.fonts/. && \
	cp SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts/.
# COPY fonts/SourceCodePro+Powerline+Awesome+Regular.ttf ~/.fonts/.

# Mise à jour du cache des fonts
RUN fc-cache -fv 

# Packages pour la gestion des langues sous latex
# - Francais
# - (Package anglais de base je crois)
RUN apt-get install -y \
		texlive-lang-french

# Host mounted volume
WORKDIR /source
