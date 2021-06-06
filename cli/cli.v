import cli { Command, Flag }
import os

fn main() {
	mut app := Command{
		name: 'artnik'
		description: 'Experimental CLI tool'
		version: '1.0.0'
	}

	mut example_cmd := Command{
		name: 'cmd'
		description: 'Example command'
		usage: '<name>'
		required_args: 1
		pre_execute: example_pre_func
		execute: example_func
		post_execute: example_post_func
	}
	example_cmd.add_flag(Flag{
		flag: .string
		required: false
		name: 'parameter'
		abbrev: 'p'
		description: 'Example of parameter'
	})

	app.add_command(example_cmd)
	app.setup()
	app.parse(os.args)
}

fn example_func(cmd Command) ? {
	p := cmd.flags.get_string('parameter') or { '' }
	input := cmd.args[0]
	println('Input: $input')
	if p != '' {
		println('-parameter: $p')
	}
}

fn example_pre_func(app Command) ? {
	println('This is a function running before the main function')
}

fn example_post_func(app Command) ? {
	println('This is a function running after the main function')
}
