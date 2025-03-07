# Mod-10-Verification
This project focuses on verifying a Mod-10 counter design using the Universal Verification Methodology (UVM). The counter operates with a 4-bit output, counting from 0 to 9 and resetting to 0 upon reaching its terminal count. The verification environment includes essential UVM components like the driver, sequencer, monitor, and scoreboard to ensure thorough functional coverage.

The testbench generates a variety of stimulus scenarios, including reset, continuous counting, wrap-around behavior, and illegal states. The monitor captures output transitions, while the scoreboard checks expected results against the DUT’s responses. Functional and code coverage metrics are collected to guarantee design robustness, with assertions added to validate critical timing and state transitions.

By leveraging UVM, the verification ensures the Mod-10 counter adheres to design specifications, achieving comprehensive coverage and reliable validation of corner cases.
