function g --description 'Quick directory navigation'
    switch $argv[1]
        case "in" or "infra"
            cd ~/PycharmProjects/infra-frontend
        case "home"
            cd ~
        case "d"
            cd ~/Desktop
        case "fish"
            cd ~/.config/fish/
        case "nvim"
            cd ~/.config/nvim/
        case '*'
            echo "Unknown destination: $argv[1]"
            return 1
    end
end
