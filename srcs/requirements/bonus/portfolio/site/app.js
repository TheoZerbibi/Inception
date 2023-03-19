const	express	= require('express');
const	app		= express();
const	port	= 1337;

app.use(express.static(__dirname + '/views'));
app.use(express.static(__dirname + '/public'));

app.get('/',function(req,res){
	res.sendFile('index.html');
});

app.listen(port, () => {
	console.log(`server started at https://portfolio.thzeribi.fr`);
});