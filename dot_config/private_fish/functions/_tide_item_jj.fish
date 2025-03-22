function _tide_item_jj
    set -l change_id (jj log --no-graph -r @ -T "change_id.shortest(8)" 2>/dev/null)
    if test -n "$change_id"
        echo -n "$change_id"
    end
end


