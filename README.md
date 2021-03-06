# Import

**Import** is a command line application that (fakely) import products from different sources using different file formats.
Import supports only json and yaml file formats for now, more comming soon...

## Installation

First make sure you have [Erlang](https://github.com/erlang/otp) installed
```
apt-get install erlang
```
Clone this git repository
```
git clone https://github.com/jubarbie/import
```
That's it. Check usage section to read more about how to use

## Usage
Go inside import directory that you just cloned
```
cd path/to/import
./import source path/to/file.[json|yaml]
```
You can also [add import directory to you $PATH](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path) to be able to run it from anywhere using
```
import source path/to/file.[json|yaml]
```

## Running tests
Here you'll need to [install Elixir](https://elixir-lang.org/install.html)
Then go into import directory
```
cd path/to/import
```
From here simply run
```
mix test
```

## Notes
It was my first application using Elixir. I'm even more excited about this language now and the possibilities it offers

You can find my code in lib/ and test/ as you might know.
I've been writing unit tests during my last internship but I'm still not very familiar with it, even though it seemed easier with Elixir

If I had more time I would have managed errors better, in particular regarding file parsing and I would have written more unit tests

I tried to make the products importation as flexible as possible using a "mock" (check [lib/product.ex](https://github.com/jubarbie/import/blob/master/lib/product.ex)) that describe how every sources is formating its data.
