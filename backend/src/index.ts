import "reflect-metadata";
import "./config/dependency-container";
import express from "express";
import "express-async-errors"
import "dotenv/config";
import {authRouter} from "./features/user/interface/routes/auth.routes";
import { errorHandler } from "./shared/middlewares/error.middleware";
import {taskRoutes} from "./features/tasks/intreface/routes/tasks.routes";

const app = express();

app.use(express.json());
app.use("/auth", authRouter);
app.use("/tasks", taskRoutes);
app.use(errorHandler);

app.listen(8000, () => {
    console.log('Server is running on port 8000!!!!!!');
});
