local M = {}

-- Create Makefile for Latex usage
function M.CreateLatex()
	local bufname = vim.fn.expand("%:t")
	local file_ext = vim.fn.expand("%:e")
    local file_name = vim.fn.expand("%:t:r")

	if file_ext ~= "tex" or file_name == "" then
		print("Current buffer is not a .tex file.")
		return
	end

	if vim.fn.system("command -v latexmk") == "" then
		print("latexmk is not installed. Please install it.")
		return
	end
	
	if vim.fn.system("command -v zathura") == "" then
		print("Zathura is not installed. Please install it.")
		return
	end


    if file_name == "" then
        print("No .tex file found in the current directory.")
        return
    end

    -- Create Makefile if it doesn't exist
    local makefile_path = "./Makefile"
    if vim.fn.filereadable(makefile_path) == 0 then
        local makefile_content = string.format([[
FILE ?= %s
TEX := $(FILE).tex
PDF := $(FILE).pdf
LATEX := latexmk

all: $(PDF)

$(PDF): $(TEX)
	$(LATEX) -pdf -silent $(TEX) >/dev/null 2>&1

watch-silent: $(PDF)
	$(LATEX) -pdf -pvc -interaction=nonstopmode -silent $(TEX) >/dev/null 2>&1

clean:
	$(LATEX) -c
]], file_name)

        local file = io.open(makefile_path, "w")
        file:write(makefile_content)
        file:close()
    end
	print("Makefile created for " .. file_name)
end

return M
