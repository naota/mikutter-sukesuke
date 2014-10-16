# -*- coding: utf-8 -*-

Plugin.create(:sukesuke) do
  UserConfig[:sukesuke_suke] ||= 30
  UserConfig[:sukesuke_back] ||= 30

  settings "すけすけmikutterちゃん" do
    adjustment("何秒ですけすけにする?", :sukesuke_suke, 1, 43200)
    adjustment("何秒でもとに戻す?", :sukesuke_back, 1, 43200)
  end

  def main
    Reserver.new(1) {
      window = Plugin.filtering(:gui_get_gtk_widget, Plugin::GUI::Window.instance(:default)).first
      sukesuke(window)
      main
    }
  end

  def sukesuke(window)
    if window
      opacity = window.opacity
      if window.window.get_image(0,0,1,1)
        opacity -= 1 / UserConfig[:sukesuke_suke].to_f
      else
        opacity += 1 / UserConfig[:sukesuke_back].to_f
      end
      window.opacity = (opacity < 0 ? 0 : (opacity > 1 ? 1 : opacity))
    end
  end

  main
end
