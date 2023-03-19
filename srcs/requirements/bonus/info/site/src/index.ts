import express from "express";
import path from "path";
import bodyParser from 'body-parser';
import { curly } from 'node-libcurl';
import * as dotenv from "dotenv";

const app = express();
const port = 4242;

app.set('views', `${__dirname}/views`);
app.use(express.static(__dirname + '/public'));
app.set('view engine', 'ejs');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(bodyParser.urlencoded({ extended: true }));

let	isLog:boolean = false;
let login:string = 'thzeribi';
let	stud:any = null;

app.get("/", (req:any, res:any) => {
	if (stud && isLog)
		res.redirect('/info');
	else
		res.render('pages/index');
});

app.get("/info", (req:any, res:any) => {
	if (stud && isLog)
		res.render('pages/info', {
			user: stud
		});
	else
		res.redirect('/');
});

app.post('/info', async (req:any, res:any) => {
	if (req.body.login && req.body.login != login && isLog)
		await getData(req.body.login);
	res.redirect('/info');
});

app.post('/', async (req:any, res:any) => {
	if (req.body.password && req.body.password == process.env.INFO_PASSWORD)
	{
		isLog = true;
		await getData(login);
	}
	res.redirect('/info');
});

async function getData(_login:string)
{
	await curly.get(`${process.env.PROXY_URL}/users/${_login}`, {httpHeader: [`Authorization: ${process.env.PROXY_PASSWORD}`,]}).then(async (response:any) => {
		if (response.statusCode != 200) {
			login = 'norminet';
			await getData(login);
		} else
			stud = response.data;
	});
}


app.listen(port, () => {
	console.log(`server started at https://info.42.fr`);
});