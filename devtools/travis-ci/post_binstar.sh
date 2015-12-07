echo $TRAVIS_PULL_REQUEST $TRAVIS_BRANCH

if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
    echo "This is a pull request. No deployment will be done."; exit 0
fi


if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    echo "No deployment on BRANCH='$TRAVIS_BRANCH'"; exit 0
fi

pwd
ls
ls $HOME/miniconda/conda-bld/linux-64

anaconda -t $ANACONDA_TOKEN  upload --force -u iModels -p mbuild-dev $HOME/miniconda/conda-bld/linux-64/mbuild-*
conda convert $HOME/miniconda/conda-bld/linux-64/mbuild-* -p all

anaconda -t $ANACONDA_TOKEN  upload --force -u iModels -p mbuild-dev linux-32/mbuild-*
anaconda -t $ANACONDA_TOKEN  upload --force -u iModels -p mbuild-dev win-32/mbuild-*
anaconda -t $ANACONDA_TOKEN  upload --force -u iModels -p mbuild-dev win-64/mbuild-*
anaconda -t $ANACONDA_TOKEN  upload --force -u iModels -p mbuild-dev osx-64/mbuild-*

if [[ "$python" != "2.7" ]]; then
    echo "No deploy on PYTHON_VERSION=${python}"; exit 0
fi
