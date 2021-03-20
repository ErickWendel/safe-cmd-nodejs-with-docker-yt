
import http from 'http'
import { exec, spawn } from 'child_process'

const port = process.env.PORT || 3000

async function runCommandWithExec(cmd) {

    const p = new Promise((resolve, reject) => {
        exec(cmd, (err, res) => err ? reject(err) : resolve(res))
    })

    const response = (await p).split('\n').filter(i => !!i)

    return response
}

async function runCommandWithSpawn(cmd) {
    const [command, ...args] = cmd.split(/\s/).filter(i => !!i)

    for await (const result of spawn(command, args, {
        cwd: './documents',
        // uid: uid,
        // gid: gid,
    }).stdout) {
        return result.toString().split('\n')
    }
}

async function runCommandWithDocker(cmd) {
    
    const nodeScript = `
        async function runIt() {
            const {spawn} = require('child_process');
            for await (const result of spawn('${cmd}', {shell: true, cwd: './documents'}).stdout) {
                return result.toString();
            }
        }
        runIt().then(console.log).catch(console.err)
    `

    const dockerCommand = `
    docker run --rm \
        -v "$PWD"/documents:/documents \
        node:14-alpine node -e "${nodeScript}"
    `

    const { stdout, stderr } = spawn(dockerCommand, { shell: true })
    for await (const result of stdout) {
        return result.toString().split('\n').filter(i => !!i)
    }
}


http.createServer(async (req, res) => {
    const path = req.url.replace(/\W/, '')

    const routes = {
        exec: runCommandWithExec,
        spawn: runCommandWithSpawn,
        docker: runCommandWithDocker,
    }

    for await (const data of req) {

        const { command } = JSON.parse(data)

        const response = await routes[path](command)
        res.write(JSON.stringify(response))

        res.end()
    }



}).listen(port, () => console.log('running!', port))