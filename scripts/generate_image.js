const { WebClient } = require("@slack/client");

module.exports = (robot) => {
  const token = robot?.adapter?.options?.token;
  const web = token ? new WebClient(token) : undefined;

  robot.respond(/generate\s*(.+)/i, (msg) => {
    const prompt = msg.match[1];
    msg.send("Sure, hold my 🍺...");
    msg
      .http("https://api.openai.com/v1/images/generations")
      .header("Content-type", "application/json")
      .header("Authorization", `Bearer ${process.env.OPENAI_API_KEY}`)
      .post(
        JSON.stringify({
          prompt,
          n: 1,
          size: "512x512",
          response_format: "b64_json",
        })
      )((err, res, body) => {
      if (err) {
        return msg.send(err.message || err);
      }

      const json = JSON.parse(body);
      const base64Data = json.data?.[0]?.b64_json;

      if (!base64Data) {
        msg.send("Sorry, I am going to have to ask you to give back my 🍺...");
        return msg.send(json.error.message || "Could not comply.");
      }

      const image = Buffer.from(base64Data, "base64");

      if (!web) {
        require("fs").writeFileSync(`${prompt.slice(0, 40)}.png`, image);
        return;
      }

      web.files
        .upload({
          file: image,
          filename: `${prompt.slice(0, 40)}.png`,
          channels: msg.message.rawMessage.channel,
          initial_comment: prompt,
        })
        .catch((err) => {
          console.error(err);
          msg.send(err.message || err);
        })
        .then((data) => console.log("File uploaded: ", data.file.name));
    });
  });
};
