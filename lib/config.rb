module Tsumiki

  module Config
    module BuildTargetType
      OPAL  = 0 # Opalで実行
      CRUBY = 1 # CRuby
    end

    # ビルドターゲット
    BUILD_TARGET = BuildTargetType::OPAL
    # BUILD_TARGET = BuildTargetType::CRUBY
  end
  
end