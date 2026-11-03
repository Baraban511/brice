pragma Singleton
import Quickshell.Io

Process {
    running: false
    command: ["systemd-inhibit", "--what=idle:sleep", "--who=bell", "--why=bell is blocking inhibit", "--mode=block", "sleep", "infinity"]
    stdout: StdioCollector {
        onStreamFinished: console.log(this.text)
    }
}
