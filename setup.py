from setuptools import setup, find_packages

setup(
    name='sinless',
    version='0.1',
    packages=find_packages(),
    package_dir={"": "src"},
    license='none',
    description='An example python package with functions simulating depositing and withdrawing cash from a bank account',
    long_description=open('README.md').read(),
    install_requires=[],
    url='REPOSITORY_URL',
    author='AUTHOR_NAME',
    author_email='AUTHOR_EMAIL'
)