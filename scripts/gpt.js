const messageHistory = [];

module.exports = (robot) => {
  robot.respond(/gpt\s*(.+)/i, (msg) => {
    const prompt = msg.match[1];
    messageHistory.push({ role: "user", content: prompt });

    msg
      .http("https://api.openai.com/v1/chat/completions")
      .header("Content-type", "application/json")
      .header("Authorization", `Bearer ${process.env.OPENAI_API_KEY}`)
      .post(
        JSON.stringify({
          model: "gpt-4-1106-preview",
          messages: [
            {
              role: "system",
              content:
                'You are a nerdy chatbot named "hubot", and you will answer correctly and seriously, but also include something humorous and perhaps sarcastic in each reply. You also like goats a bit.',
            },
            ...messageHistory,
          ],
          temperature: 1,
          // max_tokens: 4096,
          top_p: 1,
          frequency_penalty: 0,
          presence_penalty: 0,
        })
      )((err, res, body) => {
      if (err) {
        return msg.send(err.message || err);
      }

      let json;
      try {
        json = JSON.parse(body);
      } catch (error) {
        msg.send("Expected JSON but got this instead???👇");
        return msg.send(body);
      }

      const tokensUsed = json.usage?.total_tokens;

      if (tokensUsed > 16384 || messageHistory.length > 10) {
        messageHistory.shift();
      }

      const responseMessage = json.choices?.[0]?.message;

      if (!responseMessage || !responseMessage.content) {
        messageHistory.pop();
        console.log(body);
        return msg.send("Sorry, something went wrong.");
      }

      messageHistory.push(responseMessage);
      msg.send(responseMessage.content);
    });
  });
};
