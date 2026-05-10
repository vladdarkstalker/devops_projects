package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

func refreshTerminal1() {
	cmd := exec.Command("clear")
	cmd.Stdout = os.Stdout
	cmd.Run()
}

func refreshTerminal2() {
	fmt.Print("\033[H\033[2J")
}

func main() {

	for true {

		refreshTerminal2()

		fmt.Println(time.Now().Format(time.TimeOnly))

		// Total CPU usage
		// Total memory usage (Free vs Used including percentage)
		// Total disk usage (Free vs Used including percentage)
		// Top 5 processes by CPU usage
		// Top 5 processes by memory usage

		time.Sleep(1 * time.Second)
	}

}
