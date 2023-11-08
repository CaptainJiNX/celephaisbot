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
          model: "dall-e-3",
          prompt,
          n: 1,
          size: "1024x1024",
          quality: "hd",
          response_format: "b64_json",
        })
      )((err, res, body) => {
      const sorry =
        "Sorry, I am going to have to ask you to give back my 🍺...";

      if (err) {
        msg.send(sorry);
        return msg.send(err.message || err);
      }

      let json;
      try {
        json = JSON.parse(body);
      } catch (error) {
        msg.send(sorry);
        msg.send("Expected JSON but got this instead???👇");
        return msg.send(body);
      }

      const base64Data = json.data?.[0]?.b64_json;

      if (!base64Data) {
        msg.send(sorry);
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
