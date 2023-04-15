
RPC.register('fa-phone:getDocuments', function(pSource, pType)
    local user = exports['fa-base']:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    local cid = char.id
    local p = promise.new()

    documents = {}
    local result = MySQL.query.await([[
        SELECT * FROM __documents WHERE owner = ? AND type = ?
    ]], {cid, pType})

    if result[1] then
        for k,v in pairs(result) do
            documents[v.id] = {
                id = v.id,
                owner = v.owner,
                title = v.title,
                text = v.text,
                type = v.type,
                isMyDocument = true
            }
        end
    end

    local resultShared = MySQL.query.await([[
        SELECT * FROM __documents WHERE type = ?
    ]], {pType})

    local employees = json.decode(resultShared[1].authorized) or {}
    for i,u in pairs(employees) do
        if tonumber(u.cid) == tonumber(char.id) then
            for k,v in pairs(resultShared) do
                if v.owner ~= tonumber(char.id) then
                documents[v.id] = {
                    id = v.id,
                    owner = v.owner,
                    title = v.title,
                    text = v.text,
                    type = v.type,
                    isMyDocument = false
                }
                end
            end
        end
    end

    p:resolve(documents)

    return Citizen.Await(p)
end)

RPC.register("fa-phone:sendDocumentEvent", function(pSource, pTarget, pDocumentID)
    TriggerClientEvent("fa-phone:sendDocumentEvent", pTarget, pDocumentID)
end)

RegisterNetEvent("fa-phone:checkForNonDocumentedLicenses", function(pCid)
    local sex = "sex"
    local resu = MySQL.query.await([[
        SELECT * FROM user_licenses WHERE status = ? AND cid = ?
    ]], {1, pCid})
    for k,v in pairs(resu) do
        local nilValue = MySQL.query.await([[
            SELECT * FROM __documents WHERE title = ?
        ]],{v.type .. " License"})
        if nilValue[1] then return end
        
        local char = MySQL.query.await([[
            SELECT * FROM characters WHERE id = ?
        ]], {tonumber(pCid)})

        if char[1].gender == 0 then
            sex = "Male"
        elseif char[1].gender == 1 then
            sex = "Female"
        end

        MySQL.query.await([[
            INSERT INTO __documents (owner,title,text,type,authorized,temporary) VALUES (?,?,?,?,?,?)
        ]], {char[1].id, v.type .. " License", "<p><span><strong><span style='font-size:15px;'>Issued to</span></strong><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: rgb(255, 255, 255);' class='mkdwnpre-fenced-box'><span class='markdown-fenced-box'>&nbsp;&nbsp;Name: " ..char[1].first_name.." " ..char[1].last_name.."&nbsp;&nbsp;</span></span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: rgb(255, 255, 255);' class='mkdwnpre-fenced-box'><span class='markdown-fenced-box'>&nbsp;&nbsp;ID: "..char[1].id.."&nbsp;&nbsp;</span></span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: rgb(255, 255, 255);' class='mkdwnpre-fenced-box'><span class='markdown-fenced-box'>&nbsp;&nbsp;Sex: "..sex.."&nbsp;&nbsp;</span></span><br><strong><span style='font-size:15px;'>Issued by</span></strong><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: rgb(255, 255, 255);' class='mkdwnpre-fenced-box'><span class='markdown-fenced-box'>&nbsp;&nbsp;Name: State Account&nbsp;&nbsp;</span></span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='color: rgb(255, 255, 255);' class='mkdwnpre-fenced-box'><span class='markdown-fenced-box'>&nbsp;&nbsp;Date: ".. os.date('%Y-%m-%d', os.time()).."&nbsp;&nbsp;</span></span></p>", "Licenses", "[]",0})
    end
end)

RPC.register("fa-phone:shareDocumentPermanent", function(pSource, dID, tCID)
    local doc = MySQL.query.await([[
        SELECT * FROM __documents WHERE id = ?
    ]], {dID})

    if doc[1] then
        local documentShare = json.decode(doc[1].authorized) or {}

        local newAuthorized = {
            ["cid"] = tCID
        }

        table.insert(documentShare, newAuthorized)

        local ec = json.encode(documentShare)


        MySQL.query.await([[
            UPDATE __documents SET authorized = ? WHERE id = ?
        ]], {ec, dID})
    end
end)

RPC.register("fa-phone:acceptDocumentReceiveRequest", function(pSource, pDocumentID)
    local p = promise.new()
    local doc = MySQL.query.await([[
        SELECT * FROM __documents WHERE id = ?
    ]], {pDocumentID})


    local docU = {}
    if doc[1] then
        for k,v in pairs(doc) do
            docU[#docU+1] = {
                id = v.id,
                owner = v.owner,
                title = v.title,
                text = v.text,
                type = v.type,
                isMyDocument = false
            }
        end
    end


    p:resolve(docU)

    return Citizen.Await(p)
end)

RPC.register('fa-phone:deleteDocument', function(pSource, pId)
    exports.oxmysql:execute("DELETE FROM __documents WHERE id = ?",{pId})
end)

RPC.register('fa-phone:updateDocument', function(pSource, pId, pTitle, pText)
    exports.oxmysql:execute("UPDATE __documents SET title = ? WHERE id = ?",{pTitle, pId})
    exports.oxmysql:execute("UPDATE __documents SET text = ? WHERE id = ?",{pText, pId})
end)

RPC.register("fa-phone:createDocument", function(pSource, pOwner, pTitle, pText, pType)
    MySQL.query.await([[
        INSERT INTO __documents (owner,title,text,type) VALUES (?,?,?,?)
    ]], {pOwner, pTitle, pText, pType})
end)