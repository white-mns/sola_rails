class ApplicationController < ActionController::Base
    def placeholder_set
        @placeholder = {}
        @placeholder["Number"] = "例）1~10/50~100"
        @placeholder["Text"]   = "例）武器/\"防具\""
        @placeholder["Name"]   = "例）太郎/\"次郎\""
        @placeholder["Skill"]  = "例）スラッシュ/\"ラッシュ\""
        @placeholder["Artifact"]   = "例）賢者の石/演習用核爆弾"
    end
end
