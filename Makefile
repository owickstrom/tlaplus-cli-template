OUT = target
WORKERS = 4

TLA_SOURCES=$(shell find spec/*.tla)
TLA_TARGETS=$(TLA_SOURCES:spec/%.tla=$(OUT)/%.tla)

MODEL_SOURCES=$(shell find model/*.cfg)
MODEL_CFG_TARGETS=$(MODEL_SOURCES:model/%.cfg=$(OUT)/%.cfg)

CHECK_TARGETS=$(MODEL_SOURCES:model/%.cfg=check-$(call cfg_spec_name,%))

define cfg_spec_name
$(shell echo $(shell basename $(1)) | sed 's/\..*//')
endef

.PHONY: all
all: check

# Copy and translate PlusCal code

$(OUT):
	mkdir -p $@

$(OUT)/%.tla: spec/%.tla $(OUT)
	cp $< $@
	pcal -nocfg $@

$(OUT)/%.cfg: model/%.cfg $(OUT)
	cp $< $@

# Keep copied files

.SECONDARY: $(TLA_TARGETS) $(MODEL_CFG_TARGETS)

# Syntax checking using SANY

.PHONY: lint
lint: $(TLA_TARGETS)
	sany $(TLA_TARGETS)

# Check using TLC

check-%: $(OUT)/%.cfg $(TLA_TARGETS)
	(cd $(OUT) && tlc $(call cfg_spec_name,$<).tla -workers $(WORKERS) -config $(shell basename $<))

.PHONY: check
check: $(CHECK_TARGETS)

# Clean everything

.PHONY: clean
clean:
	echo $(CHECK_TARGETS)
	rm -rf $(OUT)
