# Opalは先にrequire
require "opal"

# --- load setting
require_relative "lib/config.rb"

if Tsumiki::Config::BUILD_TARGET == Tsumiki::Config::BuildTargetType::OPAL
  # opal 関連require
  require "opal-parser" # for instance_eval (String)
  require "native"
elsif Tsumiki::Config::BUILD_TARGET == Tsumiki::Config::BuildTargetType::CRUBY
  require "pp" # デバッグ用
end

# --- internal
require_relative "lib/helper/event.rb"
require_relative "lib/render/vdom_render.rb"
require_relative "lib/style/style_manager.rb"
require_relative "lib/listener/listener.rb"
require_relative "lib/component/page.rb"

# --- additional
require_relative "components/components.rb"