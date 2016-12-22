# LambdaPythonPackager

The AWS Lambda service is a great platform for hosting event driven software but it can be a bit tricky to package
Python projects for deployment.  Normally you would create a Zip file and copy your code into it.  Things get a [bit 
more involved](http://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html) if you 
want to use an external dependency.  If you're lucky you just need to use `pip` or `virtualenv` and move files around. 
If you're unlucky you see something like this:

![Lambda dependency error message](https://github.com/drie/LambdaPythonPackager/raw/master/images/execution_fail.png "Lambda dependency fail")

This sort of thing is especially common if your dependencies rely on compiled binaries which differ between your local 
machine and the Lambda environment (e.g. your using Ubuntu or OSX).

## The Solution

LambdaPythonPackager is a Docker Repository which uses a [LambdaLike environment](https://hub.docker.com/r/drie/lambdalike) 
to build your code.  This makes build much more deterministic and cuts down on surprises when moving from local development 
to production.

## Usage

The repo takes a project directory via `stdin` in `tar` format and outputs the build artifact to `stdout`.  It detects the 
Python dependencies if `requirements.txt` exists in the top level of your directory.  Likewise it will install packages using 
`yum` from `yum.txt`.

## Example

```
ben@drie:~/projects/python_lambda$ tar c . | sudo docker run --rm -i drie/lambdapythonpackager > output.zip
```

If your code is in Git, you can also use `git archive` to build a specific version.

```
ben@drie:~/projects/python_lambda$ git archive HEAD | sudo docker run --rm -i drie/lambdapythonpackager > output.zip
```

## Warning
This project is not endorsed by Amazon or [@jeffbar](https://twitter.com/jeffbarr) in any respect (but it would be awesome if it where).
