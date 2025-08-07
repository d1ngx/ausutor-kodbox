# ausutor-kodbox

- [App_Central_Developer_Guide](https://downloadgb.asustor.com/developer/App_Central_Developer_Guide_4.2.2_20230712.pdf)
- [APKG_Utilities_2.0_0517.zip](https://downloadgb.asustor.com/developer/APKG_Utilities_2.0_0517.zip)
- [app_central](https://www.asustor.com/app_central/app_detail?id=1176)

```bash
$ tree kodbox -L 2
kodbox
├── CONTROL
│   ├── changes.txt
│   ├── config.json
│   ├── description.txt
│   ├── icon.png
│   ├── post-install.sh
│   └── pre-install.sh
├── README.md
└── www
    ├── app
    ├── Changelog.md
    ├── config
    ├── data
    ├── index.php
    ├── plugins
    └── static

$ sudo ./apkg-tools_py3.py create kodbox
```
