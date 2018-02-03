# mk-rsync: Minikube RSYNC service

**EXPERIMENTAL:** This is a work in progress.

This is a simple tool to expose host content in a minikube cluster using rsync.

It sets up an rsync server that can serve out some of the contents of your host
system.

My purpose for writing this is to make it possible to run Brigade scripts in
minikube that operate on files on my host file system. Obviously, this is the sort
of thing that you only want to do in highly trusted environments (e.g. your
workstation) and _not_ in a production cluster.

## Setting Up Minikube

Install and configure Minikube in the usual way. Then, to expose one of your
host volumes to the service, run this command on the host:

```console
$ minikube mount $HOME/Code:/mnt/share
```

Note that `$HOME/Code` is the local path, and you can change this to whatever you
want. But `/mnt/share` is the directory where mk-rsync expects to find the files.
Don't change that part.

You might want to detach when you run the above command (append ` &` to the end)
or else the mount will run in the foreground.

## Installing the Helm Chart

Clone this project and CD into the source directory, then install the chart:

```console
$ helm install charts/rsync
```

Now you will have a service and a deployment running your rsync service.

## Using the Brigade rsync-sidecar

When you create a Brigade project that uses a local path, you need to set the
sidecar appropriately and also set the repository to a local path:

```yaml
project: "code/brigade"
repository: Go/src/github.com/Azure/brigade
cloneURL: Go/src/github.com/Azure/brigade
vcsSidecar: "technosophos/rsync:latest"

#... the rest of the stuff
```

Most important above are the values of `cloneURL` and `vcsSidecar`:

- `cloneURL` is a relative path from the value you used in `minikube mount` above
  to the directory or file you want cloned.
- `vcsSidecar` is `technosophos/rsync:latest`, which is the sidecar created from
  this project.

Once you have installed a project with the above, brigade commands run against
the project will make a copy of the filesystem from the local tree into each
job. Note that because you are working on _copies_, you cannot change the files
on the local filesystem. So you can do fairly destructive things with gross
impudence.

## Notes

- Want to exclude some things from being copied? Use a `.cvsignore` file and party
  like it's 1995.
- Mixing this with the github gateway could have really weird side effects. Fortunately,
  it's also ridiculously hard. So... don't try it on anything you care about.
- You can only run one mk-rsync instance per namespace, and you cannot cross
  namespaces with the same mk-rsync. This is because service discovery is used
  to find the rsync service.
