/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

declare namespace FYX {
    class Events {
        static addHook(name: string, cb: (...args: any) => any): void;
        static start(): Promise<void>;
    }

    class Procedures {
        static register(name: string, cb: (src: number, ...args: any) => any): void;
        static execute(name: string, ...args: any): any;
    }
}