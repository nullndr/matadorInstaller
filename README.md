# matadorInstall

# What if I already have a Remix project with BullMQ?

in order to simply install [Matador](https://github.com/nullndr/Matador) in your [Remix](https://remix.run) project, run:

```bash
$ curl https://raw.githubusercontent.com/nullndr/matadorInstaller/main/copy.sh | \
    sh -s -- "/my/remix/project"
```

Matador will be copied in `/my/remix/project/app/routes/matador`, `/my/remix/project/app/routes/matador.tsx` and
`/my/remix/project/app/lib/matador`.

### But wait a sec, I do not use the app folder!!

Not a problem, you can provide the folder as the second argument of the script:

```bash
$ curl https://raw.githubusercontent.com/nullndr/matadorInstaller/main/copy.sh | \
    sh -s -- "/my/remix/project" "root"
```

Matador will be copied in `/my/remix/project/root/routes/matador`, `/my/remix/project/root/routes/matador.tsx` and
`/my/remix/project/root/lib/matador`.
