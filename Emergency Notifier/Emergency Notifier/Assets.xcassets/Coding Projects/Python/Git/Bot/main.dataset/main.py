import asyncio
import datetime
import os
from datetime import datetime
from itertools import cycle
from keep_alive import keep_alive

import discord
from discord.message import Message
import requests
from discord import channel
from discord.ext import commands, tasks
from discord.ext.commands import (Bot, CheckFailure, MissingPermissions, check,
                                  has_permissions)
from discord.ext.commands.bot import when_mentioned
from discord.utils import get

from cogs.Counter import SI, rolecheck
from settings_files import _global, keep_alive

client_id = "m0zqklrm3yxor5k2776556570b5jun"
client_secret = "25zt61smgh9tcb57kfimnzcxqvubhy"

async def create_ticket(user, guild, reason):
            everyone = guild.default_role

            channel = await guild.create_text_channel(f'Ticket-{user.name}')
            embed=discord.Embed(title=f"Ticket from {user.name}", description=f"{user.mention} has created a new support ticket", color=Light_Blue)
            embed.set_author(name=user.name, icon_url=user.avatar_url)
            embed.add_field(name="Reason:", value=reason, inline=True)
            embed.add_field(name="created at:", value=(datetime.now().strftime('%Y-%m-%d, %H:%M')), inline=True)
            embed.add_field(name="To close the ticket react with:", value=":x:", inline=False)
            embed.set_footer(text=client.user.name, icon_url=client.user.avatar_url)
            message = await channel.send(embed=embed)
            await message.pin()
            await channel.set_permissions(everyone, view_channel=False)
            await channel.set_permissions(user, view_channel=True)  
            await message.add_reaction('❌')
            def check(reaction, user): 
                return user != client.user and str(reaction.emoji) == '❌'
            try:
                reaction, user = await client.wait_for('reaction_add', timeout=None, check=check)
            except asyncio.TimeoutError:
                pass
            else:
                await channel.delete()



#conn = sqlite3.connect('serverinfo.db')

#c = conn.cursor()

DSICORD_BOT_TOKEN=_global.DISCORD_BOT_TOKEN

SERVERINFO = _global.SI
PARTYBEAST = _global.PB
                
                



##########################################################################################################################
# PREFIXES #
##########################################################################################################################
async def get_prefix(client, message):
    if message.guild is None:
                return "."
    else:
                conn = SERVERINFO
                c = conn.cursor()
                c.execute("SELECT * FROM servers WHERE server_id = ?", (message.guild.id,))
                x = c.fetchone()
                if x is None:
                    c.execute("INSERT INTO servers VALUES (?,?,?,?)", (message.guild.name, message.guild.id, '.', 0,))
                    conn.commit()
                    c.execute("SELECT * FROM servers WHERE server_id = ?", (message.guild.id,))
                    x = c.fetchone()
                y = x[2]
                return commands.when_mentioned_or(y)(client, message)

client = commands.Bot(command_prefix=get_prefix, intents = discord.Intents.all(), case_insensitive = True, help_command=None)

@client.before_invoke
async def _before_invoke(ctx):
    if isinstance(ctx.message.channel, discord.DMChannel) or isinstance(ctx.message.channel, discord.GroupChannel):
        raise commands.NoPrivateMessage("Commands cannot be used in private messages")

################
# Experimental #
################

@client.event
async def on_raw_reaction_add(payload):
            c = SERVERINFO
            z= c.execute("SELECT * FROM emoji WHERE server_id = ? AND message_id = ? AND reaction = ?", (int(payload.guild_id), int(payload.message_id), str(payload.emoji),)) 
            message_id = payload.message_id
            guild_id = payload.guild_id
            reaction = payload.emoji
            user_id = payload.user_id
            channel_id = payload.channel_id
            guild = discord.utils.find(lambda g : g.id == guild_id, client.guilds)
            user = discord.utils.find(lambda m : m.id == user_id, guild.members)
            channel = await client.fetch_channel(channel_id)
            message = await channel.fetch_message(message_id)
            if user == client.user:
                return
            c.execute("""SELECT * FROM emoji WHERE server_id = ? AND message_id = ? AND reaction = ?""", (int(guild_id), int(message_id), str(reaction),))
            x = z.fetchall()
            ab = _global.TI
            h = ab.cursor()
            h.execute("SELECT * FROM ticketmsg WHERE server_id = ? AND msg_id = ? AND emoji = ? AND channel_id = ?", (int(guild.id), int(message_id), str(reaction), int(channel_id),))
            g = h.fetchone()
            def check(msg):
                if isinstance(msg.channel, discord.DMChannel):
                    if msg.author.id == user_id:
                        return True
            if g is not None:  
                await user.send("Why would you like to create a ticket?")
                await asyncio.sleep(0.5)
                try:
                        message124 = await client.wait_for('message', check=check, timeout=60)
                        reason = message124.content
                        
                        await create_ticket(user, guild, reason)

                except asyncio.TimeoutError:
                        await user.send("You did not answer fast enough")


                return await message.remove_reaction(reaction, user)
            h.execute("SELECT * FROM closeticket WHERE server_id = ? AND msg_id = ? AND emoji = ?", (int(guild.id), int(message_id), str(reaction),))
            lm = h.fetchone()
            if lm is not None:
                await channel.delete()
           
            for item in x:
                role = discord.utils.get(guild.roles, id = item[1])
                if user != client.user:
                    if role not in user.roles:
                        await user.add_roles(role)
                        print(f"{user.name} was given {role.name}")
                    else:
                        await user.remove_roles(role)
                else:
                    return

@client.event
async def on_raw_reaction_remove(payload):
            c = SERVERINFO
            z= c.execute("SELECT * FROM emoji WHERE server_id = ? AND message_id = ? AND reaction = ?", (int(payload.guild_id), int(payload.message_id), str(payload.emoji),)) 
            message_id = payload.message_id
            guild_id = payload.guild_id
            reaction = payload.emoji
            user_id = payload.user_id
            guild = discord.utils.find(lambda g : g.id == guild_id, client.guilds)
            user = discord.utils.find(lambda m : m.id == user_id, guild.members)
            x = z.fetchall()
            for item in x:
                role = discord.utils.get(guild.roles, id = item[1])
                if role in user.roles:
                    if user != client.user:
                        await user.remove_roles(role)
                else:
                    if user != client.user:
                        await user.add_roles(role)

version = "Alpha"
client.launch_time = datetime.utcnow()

def membercount():
    members = 0
    for guild in client.guilds:
        for member in guild.members:
            members += 1
    return members

def uptime():
    delta_uptime = datetime.utcnow() - client.launch_time
    hours, remainder = divmod(int(delta_uptime.total_seconds()), 3600)
    minutes, seconds = divmod(remainder, 60)
    days, hours = divmod(hours, 24)
    x = f"{days}d, {hours}h, {minutes}m, {seconds}s"
    return x

@client.command()
async def botinfo(ctx):
    embed = discord.Embed(title="Bot Info", description=f"information about {client.user.name}", colour = 0x6f2dd2).set_thumbnail(url=client.user.avatar_url)
    embed.add_field(name="**Bot Name:**", value=client.user.name, inline= True)
    embed.add_field(name="**Made by:**", value="Glasses#2582", inline= True)
    embed.add_field(name="**Uptime:**", value=uptime(), inline= False)
    embed.add_field(name="**Server Count:**", value=len(client.guilds), inline= True)
    embed.add_field(name="**Member Count:**", value=membercount(), inline= True)
    embed.timestamp = datetime.utcnow()
    await ctx.send(embed=embed)
    
    
#################
# ON GUILD JOIN #
#################
@client.event
async def on_guild_join(guild): 
        c = SERVERINFO
        c.execute("INSERT INTO servers VALUES (?,?,?,?)", (guild.name, guild.id, '.', 0,))
        c.commit()
        print(f"A new guild ({guild.name}) has been joined")

###################
# levels # 

#  @client.event()
#  async def on_command_error(self, ctx, error):
##    if isinstance(error, commands.CommandOnCooldown):
#      await ctx.send(f"Still on cooldown try again after {int(error.retry_after)}s")

###################
# ON GUILD REMOVE #
###################
@client.event
async def on_guild_remove(guild):
            c = SERVERINFO
            d = PARTYBEAST
            f = _global.CO
            c.execute("DELETE FROM servers WHERE server_id = ?", (guild.id,))
            c.execute("DELETE FROM welcomeroles WHERE server_id = ?", (guild.id,))
            c.execute("DELETE FROM logs WHERE server_id = ?", (guild.id,))
            d.execute("DELETE FROM hub WHERE server_id = ?", (guild.id,))
            d.execute("DELETE FROM channels WHERE server_id = ?", (guild.id,))
            _global.LV.execute("DELETE FROM levelchannels WHERE server_id = ?", (guild.id,))
            _global.CO.execute("DELETE FROM counters WHERE server_id = ?", (guild.id,))
            _global.CO.execute("DELETE FROM counterstatus WHERE server_id = ?", (guild.id,))
            c.commit()
            d.commit()
            f.commit()
            print(f'guild {guild.name} has been removed and deleted')

#################
# CHANGE PREFIX #
#################

@client.command()
@commands.has_permissions(administrator=True)
async def changeprefix(ctx, prefix):
        c = SERVERINFO.cursor()
        c.execute("""UPDATE servers SET prefix = ?
                WHERE server_id = ?
        """, (prefix, ctx.guild.id,))
        SERVERINFO.commit()
        await ctx.send(f"Prefix has been changed to {prefix}")


###########
# Welcome #
###########


async def get_welcome_channel(member):
        c = _global.SI
        z = c.execute("SELECT * FROM servers WHERE server_id = ?", (member.guild.id,))
        c.execute("SELECT * FROM servers WHERE server_id = ?", (member.guild.id,))
        x = z.fetchone()
        return x[3]

@client.command(hidden=True)
@commands.has_permissions(administrator=True)
async def setwelcome(ctx, channel: discord.TextChannel):
        c = SERVERINFO
        await ctx.send(f"The welcome messages will now be sent to {channel.mention}")
        c.execute(f"""UPDATE servers SET welcome_id = ?
            WHERE server_id = ?    
        """, (channel.id, ctx.guild.id,))
        c.commit()


##############################################################################

#@client.listen('on_message')
#async def pingcheck(message):
#    if '@' in message.content:
#        users = message.mentions
#        print(f"{message.author} at {message.created_at} in {message.channel}:")
#        print(f"{message.content}")

##########################################

# welcomerole add
@client.command(aliases=['welcomerole', 'addrole', 'addwelcome'])
@commands.has_permissions(manage_roles=True)
async def joinrole(ctx, role: discord.Role):
        c = SERVERINFO  
        c.execute("INSERT INTO welcomeroles VALUES (?, ?, ?)", (ctx.guild.name, ctx.guild.id, role.id,))
        c.commit()
        await ctx.send(f"{role.name} will now be given once a member joins.")

# welcomerole remove
@client.command()
@commands.has_permissions(manage_roles=True)
async def removerole(ctx, role: discord.Role):
        c = SERVERINFO
        c.execute("DELETE FROM welcomeroles WHERE role_id = ?", (role.id,))
        c.commit()
        await ctx.send(f'{role.name} will no longer be given once people join')
    

async def get_welcome_roles(member):
            c = SERVERINFO
            z = c.execute("SELECT * FROM welcomeroles WHERE server_id = ?", (member.guild.id,))
            x = z.fetchall()
            try:
                for item in x:
                    role = discord.utils.get(member.guild.roles, id=item[2])
                    await member.add_roles(role)
                    print(f"{member.name} was given {role.name} in {member.guild.name}")
            except Exception as e:
                print(e)
                
        

### Color Variables ###
Orange = 0xFF5733
Red = 0xFF0000
Green = 0x00FF00
Yellow = 0xFFFF00
Blue = 0x0000FF
Light_Blue = 0x00FFFF
Grey = 0xA2C4C9
Black = 0x000000
### Other Variables ###
################################################################################
# START UP #
################################################################################
@client.event
async def on_ready():
                members = 0
                for guild in client.guilds:
                    for member in guild.members:
                        members += 1
                print(f"--------------\n- {client.user.name} is ready -\n- Servers: {len(client.guilds)} -\n- Alpha -\n- Members: {members} -\n- ping: {round(client.latency * 1000)}ms -\nConnected to:\n")
                server_number = 0
                for guild in client.guilds:
                        server_number += 1
                        print(f'{server_number}) {guild.name} ({len(guild.members)})')
                print("\n")

async def checkroles():
    await client.wait_until_ready()
    #bando = client.fetch_guild(724010627395354625)
    for guild in client.guilds:
        for member in guild.members:
            if len(member.roles) <= 1:
                await get_welcome_roles(member)
                await asyncio.sleep(2)

async def change_presence():
    await client.wait_until_ready()
    members = 0
    for guild in client.guilds:
        for member in guild.members:
            members += 1
    while not client.is_closed():
        await client.change_presence(activity=discord.Game(name=(f"with {members} members!")))
        await asyncio.sleep(60)
        await client.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name=f"over {len(client.guilds)} servers!",))
        await asyncio.sleep(60)
        await client.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name=f"You -.- | .help"))
        await asyncio.sleep(60)

                                    
#################################
# WELCOMES AND GOODBYE MESSAGES #
#################################

@client.event
async def on_member_join(member):
        try:
            print(f'{member} has joined {member.guild}')
            channel = client.get_channel(await get_welcome_channel(member))

            await get_welcome_roles(member)
            embed = discord.Embed(
                title=f"Everyone please welcome {member.name} to {member.guild}! The server now has {str(member.guild.member_count)} members.",
                description=member.mention,
                color=Green
            )
            
            embed.set_author(name="Welcome", icon_url=member.guild.icon_url)
            embed.set_thumbnail(url=member.avatar_url)
            embed.set_footer(text=client.user.name, icon_url=client.user.avatar_url)

            await channel.send(embed=embed)
        except:
            return

###################
# On member leave #
###################
@client.event
async def on_member_remove(member):
    try:
        print(f'{member} has left {member.guild}')
        channel = client.get_channel(await get_welcome_channel(member))
        embed = discord.Embed(
            title=f"{member.name} has just left {member.guild}. We have now dropped to {str(member.guild.member_count)} members.",
            description=member.mention,
            color=Red
        )
        embed.set_author(name="Goodbye", icon_url=member.guild.icon_url)
        embed.set_thumbnail(url=member.avatar_url)
        embed.set_footer(text=client.user.name, icon_url=client.user.avatar_url)
        await channel.send(embed=embed)
    except: return

_global.forceskip = client.get_command("_fs")

##########
# CHECKS #
##########

def is_it_me(ctx): 
    return ctx.author.id == 298364471087464448

################################################################################
# COGS #
################################################################################
# LOAD #
################################################################################

@client.command(hidden=True)
@commands.check(is_it_me)
async def load(ctx, extension):
  client.load_extension(f'cogs.{extension}')

################################################################################
# UNLOAD #
################################################################################

@client.command(hidden=True)
@commands.check(is_it_me)
async def unload(ctx, extension):
  client.unload_extension(f'cogs.{extension}')
  print(f'{extension} Cog was unloaded')

################################################################################
# RELOAD #
################################################################################

@client.command(hidden=True)
@commands.check(is_it_me)
async def reload(ctx, extension=None):
  if extension == None:
      for filename in os.listdir('./cogs'):
          if filename.endswith(".py"):
                client.unload_extension(f'cogs.{filename[:-3]}')
                client.load_extension(f'cogs.{filename[:-3]}')
      print('All Cogs were reloaded')
  else:   
    client.unload_extension(f'cogs.{extension}')
    client.load_extension(f'cogs.{extension}')
    print(f'{extension} Cog was reloaded')

#########################################################################################################################
# AUTO SET UP #
#########################################################################################################################

for filename in os.listdir('./cogs'):
          if filename.endswith(".py"):
                client.load_extension(f'cogs.{filename[:-3]}')

###################
# Errors #
###################
"""@client.event
async def on_command_error(ctx, error):
    if isinstance(error, commands.MissingPermissions):
        print(f'{ctx.author} is missing required permissions')
        name = input("what is your name")

        await ctx.send(f"You are missing the correct permissions")
    elif isinstance(error, commands.MissingRequiredArgument):
        await ctx.send("Please provide all required arguments")
    elif isinstance(error, commands.CheckFailure):
        await ctx.send("Check failed")
    elif isinstance(error, commands.CommandNotFound):
        await ctx.send("Command was not found")
    else:
        await ctx.send(error)"""

#################
# LOG LISTENERS #
#################


client.loop.create_task(checkroles())
client.loop.create_task(change_presence())
keep_alive()
client.run(DSICORD_BOT_TOKEN)
