# Docker variables
MachineName := default
Name        := elf_on_elk_container
Image       := elf_on_elk:0.1
Port        := 8081:5601

run:
	@scripts/run.sh $(Name) $(Image) $(Port) $(MachineName)

resume:
	@scripts/resume.sh $(Name) $(MachineName)

remove:
	@scripts/remove.sh $(Name) $(Image) $(MachineName)
