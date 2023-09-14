import { Request, Response } from "express";
import { QueryTypes } from "sequelize";
import Database from "../../db/database";
import * as RoutesData from '../../data/mortality_ncov/routes.json';
import { config } from "../../config/db.config";
import { IDFilter } from "../../models/IDFilter.model";
import { IDRoute } from "../../models/IDRoute.model";
import * as fs from 'fs';
import * as path from 'path';

interface IMainRepository {
    readPostData(req: Request): Promise<any[]>;
}

class MainRepository implements IMainRepository {
    db = new Database(config.DB);
    private retrievedData: any;

    async readPostData(req: Request): Promise<any[]> {
        let url = req.url;
        let TargetRoute: IDRoute = new IDRoute("", "", "");
        let route_filter_query: string = ``;
        let filterInstance = new IDFilter(req.body);

        //#region Compile filters
        if (filterInstance.filter_facility != "-1") {
            if (route_filter_query != ``) {
                route_filter_query += ' AND '
            }

            // A.FacilityID
            route_filter_query += ` A.FacilityID = '` + filterInstance.filter_facility + `' `;
        }

        if ((filterInstance.filter_date_range_start != "-1") && (filterInstance.filter_date_range_end != "-1")) {
            if (route_filter_query != ``) {
                route_filter_query += ' AND '
            }

            // D.Date
            route_filter_query += ` (D.Date BETWEEN '` + filterInstance.filter_date_range_start + `' AND '` + filterInstance.filter_date_range_end + `')`;
        }

        if (filterInstance.filter_year != "-1") {
            if (route_filter_query != ``) {
                route_filter_query += ' AND '
            }

            // D.Year
            route_filter_query += ` D.Year = '` + filterInstance.filter_year + `' `;
        }

        if ((filterInstance.filter_epi_week_start != "-1") && (filterInstance.filter_epi_week_end != "-1")) {
            if (route_filter_query != ``) {
                route_filter_query += ' AND '
            }

            // A.EpiWeek
            route_filter_query += ` (A.EpiWeek BETWEEN ` + filterInstance.filter_epi_week_start + ` AND ` + filterInstance.filter_epi_week_end + `) `;
        }

        if (route_filter_query != ``) {
            route_filter_query = ` WHERE (` + route_filter_query + `) `;
        }
        //#endregion

        //#region Seek target route
        for (let i = 0; i < RoutesData.routes.length; i++) {
            if (RoutesData.routes[i].url == url) {
                TargetRoute = new IDRoute(
                    RoutesData.routes[i].title,
                    RoutesData.routes[i].url,
                    RoutesData.routes[i].file);
                break;
            }
        }
        //#endregion

        //#region Read target query file
        if (TargetRoute.file != "") {
            TargetRoute.query = await this.readQuery(TargetRoute);
        }
        //#endregion

        return await this.executeQuery(TargetRoute, route_filter_query);
    }

    async readQuery(RouteInstance: IDRoute) {
        try {
            return fs.readFileSync(path.join("build/src/data/mortality_ncov/queries/", RouteInstance.file), 'utf8');
        } catch (error) {
            return "File not found";
        }
    }

    async executeQuery(RouteInstance: IDRoute, filter_query: string): Promise<any[]> {
        if (RouteInstance.query != "") {
            RouteInstance.query = RouteInstance.query.replace("--{{WHERE}}--", filter_query);

            this.retrievedData = await this.db.sequelize?.query<any[]>(RouteInstance.query, {
                type: QueryTypes.SELECT,
            });
        } else {
            this.retrievedData = [{
                "message": "Unhandled request --> " + RouteInstance.url
            }];
        }

        return this.retrievedData;
    }
}

export default new MainRepository