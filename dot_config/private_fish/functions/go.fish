function go -d "Quick directory navigation function"
    switch $argv[1]
        case "bm"
            cd ~/memory-builder
        case "home"
            cd ~
    end
end
