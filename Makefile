# Override the arch with `make ARCH=i386`
ARCH   ?= $(shell flatpak --default-arch)
REPO   ?= repo

RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
RUSER=root
RHOST=sdk.appbox.info
RPATH=/www/sdk.appbox.info

# SDK Versions setup here
#
# SDK_BRANCH:          The version (branch) of runtime and sdk to produce
# SDK_RUNTIME_VERSION: The org.gnome.Sdk and platform version to build against
#
SDK_BRANCH=2.0
SDK_RUNTIME_VERSION=3.20

# Canned recipe for generating metadata
SUBST_FILES=org.appbox.Sdk.json metadata.sdk metadata.platform
define subst-metadata
	@echo -n "Generating files: ${SUBST_FILES}... ";
	@for file in ${SUBST_FILES}; do 					\
	  file_source=$${file}.in; 						\
	  sed -e 's/@@SDK_ARCH@@/${ARCH}/g' 					\
	      -e 's/@@SDK_BRANCH@@/${SDK_BRANCH}/g' 				\
	      -e 's/@@SDK_RUNTIME_VERSION@@/${SDK_RUNTIME_VERSION}/g' 		\
	      $$file_source > $$file.tmp && mv $$file.tmp $$file || exit 1;	\
	done
	@echo "Done.";
endef

all: ${REPO} $(patsubst %,%.in,$(SUBST_FILES))
	$(call subst-metadata)
	flatpak-builder --force-clean --ccache --require-changes --repo=${REPO} --arch=${ARCH} --gpg-sign=E7CE25C180A28B0AF66F15F4ABD3B7BFC46BFE6F --subject="build of org.appbox.Sdk, `date`" sdk org.appbox.Sdk.json

build: ${REPO} $(patsubst %,%.in,$(SUBST_FILES))
	$(call subst-metadata)
	flatpak-builder --build-only --force-clean --ccache --require-changes --repo=${REPO} --arch=${ARCH} --gpg-sign=E7CE25C180A28B0AF66F15F4ABD3B7BFC46BFE6F --subject="build of org.appbox.Sdk, `date`" sdk org.appbox.Sdk.json

update-repo: ${REPO} $(patsubst %,%.in,$(SUBST_FILES))
	$(call subst-metadata)
	flatpak-builder --force-clean --ccache --repo=${REPO} --arch=${ARCH} --gpg-sign=E7CE25C180A28B0AF66F15F4ABD3B7BFC46BFE6F --subject="build of org.appbox.Sdk, `date`" sdk org.appbox.Sdk.json

export:
	flatpak build-update-repo --generate-static-deltas --prune --gpg-sign=E7CE25C180A28B0AF66F15F4ABD3B7BFC46BFE6F ./repo

deploy:
	${RSYNC} -avz --delete-after -e "${SSH}" repo ${RUSER}@${RHOST}:${RPATH}

${REPO}:
	ostree  init --mode=archive-z2 --repo=${REPO}
