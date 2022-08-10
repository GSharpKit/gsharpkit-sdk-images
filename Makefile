# Override the arch with `make ARCH=i386`
ARCH   ?= $(shell flatpak --default-arch)
REPO   ?= repo

RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
RUSER=root
RHOST=sdk.gsharpkit.org
RPATH=/www/sdk.gsharpkit.org

# SDK Versions setup here
#
# SDK_BRANCH:          The version (branch) of runtime and sdk to produce
# SDK_RUNTIME_VERSION: The org.gnome.Sdk and platform version to build against
#
SDK_BRANCH=36
SDK_RELEASE=1
SDK_RUNTIME_VERSION=3.38

# Canned recipe for generating metadata
SUBST_FILES=org.gsharpkit.Sdk.json metadata.sdk metadata.platform org.gsharpkit.Platform.metainfo.xml
define subst-metadata
	@echo -n "Generating files: ${SUBST_FILES}... ";
	@for file in ${SUBST_FILES}; do 					\
	  file_source=$${file}.in; 						\
	  sed -e 's/@@SDK_ARCH@@/${ARCH}/g' 					\
	      -e 's/@@SDK_BRANCH@@/${SDK_BRANCH}/g' 				\
	      -e 's/@@SDK_RELEASE@@/${SDK_RELEASE}/g' 				\
	      -e 's/@@SDK_RUNTIME_VERSION@@/${SDK_RUNTIME_VERSION}/g' 		\
	      $$file_source > $$file.tmp && mv $$file.tmp $$file || exit 1;	\
	done
	@echo "Done.";
endef

all: ${REPO} $(patsubst %,%.in,$(SUBST_FILES))
	$(call subst-metadata)
	flatpak-builder --force-clean --ccache --require-changes --repo=${REPO} --arch=${ARCH} --gpg-sign=0F1B3A5BD598CA6DCD3FF002C104C8E516AC3C73 --subject="build of org.gsharpkit.Sdk, `date`" sdk org.gsharpkit.Sdk.json

build: ${REPO} $(patsubst %,%.in,$(SUBST_FILES))
	$(call subst-metadata)
	flatpak-builder --build-only --force-clean --ccache --require-changes --repo=${REPO} --arch=${ARCH} --gpg-sign=0F1B3A5BD598CA6DCD3FF002C104C8E516AC3C73 --subject="build of org.gsharpkit.Sdk, `date`" sdk org.gsharpkit.Sdk.json

update-repo: ${REPO} $(patsubst %,%.in,$(SUBST_FILES))
	$(call subst-metadata)
	flatpak build sdk cp org.gsharpkit.Platform.metainfo.xml /usr/share/metainfo/
	flatpak-builder --force-clean --ccache --repo=${REPO} --arch=${ARCH} --gpg-sign=0F1B3A5BD598CA6DCD3FF002C104C8E516AC3C73 --subject="build of org.gsharpkit.Sdk, `date`" sdk org.gsharpkit.Sdk.json
	flatpak build sdk cp org.gsharpkit.Platform.metainfo.xml /usr/share/metainfo/

export:
	flatpak build-update-repo --generate-static-deltas --prune --gpg-sign=0F1B3A5BD598CA6DCD3FF002C104C8E516AC3C73 ./repo

deploy:
	${RSYNC} -avz --delete-after -e "${SSH}" repo ${RUSER}@${RHOST}:${RPATH}

pkg:
	flatpak build-bundle --arch=${ARCH} --runtime ${REPO} GSharpKit-${SDK_BRANCH}.${SDK_RELEASE}.flatpak org.gsharpkit.Platform ${SDK_BRANCH}

${REPO}:
	ostree  init --mode=archive-z2 --repo=${REPO}


install-sdk:
	flatpak install org.gnome.Platform/x86_64/${SDK_RUNTIME_VERSION}
	flatpak install org.gnome.Platform.Locale/x86_64/${SDK_RUNTIME_VERSION}
	flatpak install org.gnome.Sdk/x86_64/${SDK_RUNTIME_VERSION}
	flatpak install org.gnome.Sdk.Locale/x86_64/${SDK_RUNTIME_VERSION}
	flatpak install org.gnome.Sdk.Debug/x86_64/${SDK_RUNTIME_VERSION}
	#flatpak update --user --subpath= org.gnome.Sdk.Locale

