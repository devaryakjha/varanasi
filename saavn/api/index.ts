import express from "express";

const app = express();

app.get("/", async (req, res) => {
  const baseUrl = new URL("/api.php", "https://www.jiosaavn.com");
  const formedURL = new URL(
    "/api.php" + req.url.replaceAll("/?", "?"),
    baseUrl
  );
  const reqHeaders = req.headers;
  const headers: HeadersInit = {
    DL: (reqHeaders["DL"] ||
      reqHeaders["dl"] ||
      reqHeaders["Dl"] ||
      reqHeaders["dL"] ||
      "english") as string,
    L: (reqHeaders["L"]?.toString() ||
      reqHeaders["l"]?.toString() ||
      "english,hindi,tamil,telugu,punjabi,marathi,bengali,kannada,malayalam,gujarati,rajasthani,odia,urdu,assamese") as string,
  };
  console.log(reqHeaders);
  const data = await fetch(formedURL, { headers }).then((res) => res.json());
  res.json(data);
});

app.listen(3001, () => console.log("Server ready on port 3000."));

export default app;
