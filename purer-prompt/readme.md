# Purer

> Pretty one-line ZSH prompt based on [@sindresorhus](https://github.)'s [Pure](https://github.com/sindresorhus/pure)

![purer](https://cloud.githubusercontent.com/assets/583202/25418314/c3a29bfa-2a18-11e7-8a6f-4c0960ccadfc.png)

## Install

Can be installed with `npm` or [manually](https://github.com/sindresorhus/pure/blob/master/readme.md#manually). Requires Git 2.0.0+ and ZSH 5.2+.

```sh
$ npm install --global purer-prompt
```

Initialize the prompt system (if not so already) and choose `purer`:

```sh
# .zshrc
autoload -U promptinit; promptinit
prompt purer
```

See [Pure's readme](https://github.com/sindresorhus/pure/blob/master/readme.md#install) for more detailed instructions.

## Customization

Purer supports customization using [Pure's environment variables](https://github.com/sindresorhus/pure#options), plus:

### `PURE_PROMPT_SYMBOL_COLOR`

Defines the prompt symbol color. The default value is `magenta`; you can use any [colour name](https://wiki.archlinux.org/index.php/Zsh#Colors) or [numeric colour code](https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg) (see `zshzle(1)` section [Character Highlighting](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting).)


### `PURE_PROMPT_PATH_FORMATTING`

Defines how to display the path. Default value: `%c`. See [Prompt Expansion](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html) for more.

## License

Purer MIT © [David Furnes](http://dfurnes.com) <br/>
Pure MIT © [Sindre Sorhus](http://sindresorhus.com)
