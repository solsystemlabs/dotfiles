function start --description 'Runs commands inside projects'
    switch $argv[1]
        case 'd' or 'dev'
            g infra
            pnpm dev-infra
        case 'ds' or 'dev-server'
            g infra
            pnpm run dev-infra-server
        case 'lint'
            g infra
            nx lint infra
    case 'm' or 'mobile'
        g infra
        nx dev mobile
        case 'lint-all'
            g infra
            pnpm nx run-many --target=lint
        case '*'
            echo "Unknown command: $argv[1]"
            return 1
    end
end
