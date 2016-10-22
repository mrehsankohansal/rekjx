
local BASE_FOLDER = "/"
local folder = ""

local function download_file(extra, success, result)
    vardump(result)
    local file = ""
    local filename = ""
    if result.media.type == "photo" then
        file = result.id
        filename = "somepic.jpg"
    elseif result.media.type == "document" then
        file = result.id
        filename = result.media.caption
    elseif result.media.type == "audio" then
        filename = "somevoice.ogg"
        file = result.id
    else
        return
    end
    local url = BASE_URL .. '/getFile?file_id=' .. file
    local res = HTTPS.request(url)
    local jres = JSON.decode(res)
    if matches[2] then
        filename = matches[2]
    end

    local download = download_to_file("https://api.telegram.org/file/bot" .. bot_api_key .. "/" .. jres.result.file_path, filename)
end

function run(msg, matches)
    if is_sudo(msg) then
        receiver = get_receiver(msg)
        if matches[1]:lower() == 'cd' then
            if not matches[2] then
                return 'ظ‹ع؛â€”â€ڑ ط·آ´ط¸â€¦ط·آ§ ط·آ¯ط·آ± ط¸آ¾ط¸ث†ط·آ´ط¸â€، ط·آ§ط·آµط¸â€‍ط؛إ’ ط¸â€،ط·آ³ط·ع¾ط؛إ’ط·آ¯'
            else
                folder = matches[2]
                return 'ظ‹ع؛â€œâ€ڑ ط·آ´ط¸â€¦ط·آ§ ط·آ¯ط·آ± ط·آ§ط؛إ’ط¸â€  ط¸آ¾ط¸ث†ط·آ´ط¸â€، ط¸â€،ط·آ³ط·ع¾ط؛إ’ط·آ¯ : \n' .. BASE_FOLDER .. folder
            end
        end
        if matches[1]:lower() == 'ls' then
            local action = io.popen('ls "' .. BASE_FOLDER .. folder .. '"'):read("*all")
            send_large_msg(receiver, action)
        end
		if matches[1]:lower() == 'shell' then
            local action = io.popen( matches[2] ):read("*all")
            send_large_msg(receiver, action)
        end
        if matches[1]:lower() == 'mkdir' and matches[2] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && mkdir \'' .. matches[2] .. '\''):read("*all")
            return 'أ¢إ“â€‌أ¯آ¸عˆ ط¸آ¾ط¸ث†ط·آ´ط¸â€، ط·آ§ط؛إ’ط·آ¬ط·آ§ط·آ¯ ط·آ´ط·آ¯'
        end
        if matches[1]:lower() == 'rem' and matches[2] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && rm -f \'' .. matches[2] .. '\''):read("*all")
            return 'ظ‹ع؛ع‘آ« ط¸ظ¾ط·آ§ط؛إ’ط¸â€‍ ط·آ­ط·آ°ط¸ظ¾ ط·آ´ط·آ¯'
        end
        if matches[1]:lower() == 'cat' and matches[2] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && cat \'' .. matches[2] .. '\''):read("*all")
            send_large_msg(receiver, action)
        end
        if matches[1]:lower() == 'rmdir' and matches[2] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && rmdir \'' .. matches[2] .. '\''):read("*all")
            return 'أ¢â€Œإ’ ط¸آ¾ط¸ث†ط·آ´ط¸â€، ط·آ­ط·آ°ط¸ظ¾ ط·آ´ط·آ¯'
        end

        if matches[1]:lower() == 'touch' and matches[2] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && touch \'' .. matches[2] .. '\''):read("*all")
            return 'ط·آ§ط؛إ’ط·آ¬ط·آ§ط·آ¯ ط·آ´ط·آ¯'
        end
        if matches[1]:lower() == 'tofile' and matches[2] and matches[3] then
            local file = io.open(BASE_FOLDER .. folder .. matches[2], "w")
            file:write(matches[3])
            file:flush()
            file:close()
            send_large_msg(receiver, (''))
        end
        if matches[1]:lower() == 'vps' and matches[2] then
            local text = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && ' .. matches[2]:gsub('أ¢â‚¬â€‌', '--')):read('*all')
            send_large_msg(receiver, text)
        end
        if matches[1]:lower() == 'cp' and matches[2] and matches[3] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && cp -r \'' .. matches[2] .. '\' \'' .. matches[3] .. '\''):read("*all")
            return 'ظ‹ع؛â€‌ئ’ ط¸ظ¾ط·آ§ط؛إ’ط¸â€‍ ط¸â€¦ط¸ث†ط·آ±ط·آ¯ ط¸â€ ط·آ¸ط·آ± ط¹آ©ط¸آ¾ط؛إ’ ط·آ´ط·آ¯'
        end
        if matches[1]:lower() == 'mv' and matches[2] and matches[3] then
            local action = io.popen('cd "' .. BASE_FOLDER .. folder .. '" && mv \'' .. matches[2] .. '\' \'' .. matches[3] .. '\''):read("*all")
            return 'أ¢إ“â€ڑأ¯آ¸عˆ ط¸ظ¾ط·آ§ط؛إ’ط¸â€‍ ط¸â€¦ط¸ث†ط·آ±ط·آ¯ ط¸â€ ط·آ¸ط·آ± ط·آ§ط¸â€ ط·ع¾ط¸â€ڑط·آ§ط¸â€‍ ط؛إ’ط·آ§ط¸ظ¾ط·ع¾'
        end
        if matches[1]:lower() == 'upload' and matches[2] then
            if io.popen('find ' .. BASE_FOLDER .. folder .. matches[2]):read("*all") == '' then
                return matches[2] .. ' أ¢ظ¾â€°أ¯آ¸عˆ ط·آ¯ط·آ±ط·آ³ ط·آ³ط·آ±ط¸ث†ط·آ± ط¸â€¦ط¸ث†ط·آ¬ط¸ث†ط·آ¯ ط¸â€ ط؛إ’ط·آ³ط·ع¾'
            else
                send_document(receiver, BASE_FOLDER .. folder .. matches[2], ok_cb, false)
                return 'ط·آ¯ط·آ± ط·آ­ط·آ§ط¸â€‍ ط·آ§ط·آ±ط·آ³ط·آ§ط¸â€‍'
            end
        end
        if matches[1]:lower() == 'download' then
            if type(msg.reply_id) == "nil" then
                return 'ط؛إ’ط¹آ© ط¸ظ¾ط·آ§ط؛إ’ط¸â€‍ ط·آ±ط·آ§ ط·آ±ط؛إ’ط¸آ¾ط¸â€‍ط؛إ’ ط¹آ©ط¸â€ ط؛إ’ط·آ¯ ط·ع¾ط·آ§ ط¸â€¦ط¸â€  ط·آ¢ط¸â€  ط·آ±ط·آ§ ط·آ¯ط·آ§ط¸â€ ط¸â€‍ط¸ث†ط·آ¯ ط¹آ©ط¸â€ ط¸â€¦'
            else
                vardump(msg)
                get_message(msg.reply_id, download_file, false)
                return 'ط·آ¯ط·آ§ط¸â€ ط¸â€‍ط¸ث†ط·آ¯ ط·آ´ط·آ¯'
            end
        end
    else
        return 'ط¸ظ¾ط¸â€ڑط·آ· ط¸â€¦ط·آ®ط·آµط¸ث†ط·آµ ط·آ³ط¸ث†ط·آ¯ط¸ث† ط¸â€¦ط؛إ’ ط·آ¨ط·آ§ط·آ´ط·آ¯'
    end
end

return {
    description = "FILEMANAGER",
    usage =
    {
        "SUDO",
        "#cd [<directory>]: Sasha entra in <directory>, se non ط£آ¨ specificata torna alla cartella base.",
        "#ls: Sasha manda la lista di file e cartelle della directory corrente.",
        "#mkdir <directory>: Sasha crea <directory>.",
        "#rmdir <directory>: Sasha elimina <directory>.",
        "#rm <file>: Sasha elimina <file>.",
        "#cat <file>: Sasha manda il contenuto di <file>.",
        "#tofile <file> <text>: Sasha crea <file> con <text> come contenuto.",
        "#vps <command>: Sasha esegue <command>.",
        "#cp <file> <directory>: Sasha copia <file> in <directory>.",
        "#mv <file> <directory>: Sasha sposta <file> in <directory>.",
    },
    patterns =
    {
        "^[$#]([Cc][Dd])$",
        "^[$#]([Cc][Dd]) (.*)$",
		"^[$#]([Ss]hell) (.*)$",
        "^[$#]([Ll][Ss])$",
        "^[$#]([Mm][Kk][Dd][Ii][Rr]) (.*)$",
        "^[$#]([Rr][Mm][Dd][Ii][Rr]) (.*)$",
        "^[$#]([Rr][Ee][Mm]) (.*)$",
        "^[$#]([Cc][Aa][Tt]) (.*)$",
        "^[$#]([Vv][Pp][Ss]) (.*)$",
        "^[$#]([Cc][Pp]) (.*) (.*)$",
        "^[$#]([Mm][Vv]) (.*) (.*)$",
        "^[$#]([Uu][Pp][Ll][Oo][Aa][Dd]) (.*)$",
        "^[$#]([Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd]) (.*)",
        "^[$#]([Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd])"
    },
    run = run,
    min_rank = 5
}
