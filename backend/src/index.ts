import "reflect-metadata";
import "./config/dependency-container";
import express from "express";
import "express-async-errors"
import "dotenv/config";
import {authRouter} from "./features/user/interface/routes/auth.routes";
import { errorHandler } from "./shared/middlewares/error.middleware";
import {taskRoutes} from "./features/tasks/interface/routes/tasks.routes";
import { setupSwagger } from "./shared/swagger/swagger";

const app = express();

app.use(express.json());
app.use("/auth", authRouter);
app.use("/tasks", taskRoutes);
app.use(errorHandler);



const PORT = process.env.PORT || 8000;
setupSwagger(app, PORT.toString());
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}!`);
});
