# Tsumiki

コンポーネント指向UI開発のためのDSL

```
require "tsumiki"

Tsumiki::Page.create { |state|
  label text: "hello world!"
}
```

[TODOアプリ作成例](https://github.com/nozzm/tsumiki-rails-todo-sample)