extern crate rand;

use std::cmp::Ordering;
use rand::Rng;
use std::io;

fn main() {
    let mut guess = String::new();
    io::stdin().read_line(&mut guess).expect("Failed to Read line");
    println!("You guessed: {}!", guess);
}
