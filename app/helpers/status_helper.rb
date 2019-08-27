module StatusHelper
    def equips_text(equips)
        if !equips then return end

        equips.each do |equip|
            haml_concat equip.artifact.name
            haml_tag :br
        end
    end
end
