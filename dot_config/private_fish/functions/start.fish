function start --description 'Runs commands inside projects'
    switch $argv[1]
        case 'd' or 'dev'
            go infra
            pnpm dev-infra
        case 'ds' or 'dev-server'
            go infra
            pnpm run dev-infra-server
        case 'lint'
            go infra
            nx lint infra
    case 'm' or 'mobile'
        go infra
        nx dev mobile
        case 'lint-all'
            go infra
            pnpm nx run-many --target=lint
        case '*'
            echo "Unknown command: $argv[1]"
            return 1
    end
end
