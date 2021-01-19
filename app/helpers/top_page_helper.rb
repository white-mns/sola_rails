module TopPageHelper
    def top_date_text(updated_at, uploaded)
        if !updated_at then return "---" end
        
        text = updated_at.to_s(:jp_date_hour)

        if updated_at.to_s(:jp_date) == uploaded.to_s(:jp_date) then
            text += "時頃のデータまで反映しています"
        else
            text += "時のデータに更新中です…"
        end

        text
    end
end
