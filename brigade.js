const { events, Job } = require("brigadier");

// Quick test to see if the files are actually mounted
events.on("exec", () => {
  (new Job("a", "alpine:3.6", ["ls -lah /src/mk-rsync"])).run().then(res => {
    console.log(res.toString())
  })
});

