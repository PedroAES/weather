const app = require("express")({logger: true});
const cors = require("cors");

app.use(cors());
app.use(require("./routes/weather"))

app.listen(3001, function(){
  console.log("Server running on port 3001")
})