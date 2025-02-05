Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51721883F;
	Wed,  5 Feb 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787476; cv=none; b=kFJkyEIIDsF9BNsNwSzAibvvuKVu2HU6KQo7XhTEsO1GUBUXHq65xmIgsGKvh58HlzpC1cAZRZgtVRO4BIryB/6Flj3TmPA0RVQTgD/M+/e29wj7qgheJeRWlv5pX3FRa+8s1xP0dNt+Gai2oC8RnE309EBrIdaDvTtuNMK9xAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787476; c=relaxed/simple;
	bh=sBCDLZxgrvdW5cHy3pkhAPZA2H6GmnUnJYHhI2qDNcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQOJKGScV0/T8nJ4jJ0VpYq+cLcQm3lPcRCwa1KArLfdgT9M3AWWUdZKiKLocbAOSoaYekuFxDL4hSddcGENK5TwGwl6kzeqCpp8+6bGiRDBP9Wy09eEjCv6aNinIHfmcBkDI99tiKVFJVXsmblstKEhYHpDPwsNbqHTtjjE948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHNol0j0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHNol0j0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B96C4CEDD;
	Wed,  5 Feb 2025 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738787475;
	bh=sBCDLZxgrvdW5cHy3pkhAPZA2H6GmnUnJYHhI2qDNcc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GHNol0j0Jlaw94FrNxsxajXLhuXhKKDmYH4GzE/ubqPADhc5TZAaVlU7hLsOwfGP9
	 cJGWR/BS73fdWIcOISpWLDZaBnTw/cn4N7ZjeVvy+xy2LVgiyNtpHjApo4oTnJmb3u
	 agSNDQHCieESv8WA/o9HTSEffpX+fGzgEXhLxDMXtS/Lt7T5XivK0oQR6LcZ8YCi4w
	 O0H6UtjYUn/Ajmmx4JFnmHT1Y9PtUncLsK8thlRo1VuvcD1S9IkItXTHwMjZW2weqR
	 88OT616SDNisTn9+zs438hfqt6dL3ShDgft63EfdIyex6taH22+W44lUQ22dHVBDzr
	 X/MWS2Om6qK1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A112CE0749; Wed,  5 Feb 2025 12:31:15 -0800 (PST)
Date: Wed, 5 Feb 2025 12:31:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>

On Wed, Feb 05, 2025 at 12:10:53PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 05, 2025 at 09:00:07PM +0106, John Ogness wrote:
> > On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >> This is caused by RCU falling behind a callback-flooding kthread that
> > >> invokes call_rcu() in a semi-tight loop.  Setting rcutree.kthread_prio=40
> > >> avoids the splat, but still gets the shutdown-time hang.  Retrying with
> > >> the default rcutree.kthread_prio=2 failed to reproduce the splat, but
> > >> it did reproduce the shutdown-time hang.
> > >> 
> > >> OK, maybe printk buffers are not being flushed?  A 100-millisecond sleep
> > >> at the end of of rcu_torture_cleanup() got all of rcutorture's output
> > >> flushed, but lost the subsequent shutdown-time console traffic.  The
> > >> pr_flush(HZ/10,1) seems more sensible, but this is private to printk().
> > >>
> > >> I would like to log the shutdown-time console traffic because RCU can
> > >> sometimes break things on that path.
> > 
> > pr_flush() was changed to private because there were no users. It would
> > not be a problem to make it available. Adding a pr_flush() to
> > rcu_torture_cleanup() would be an appropriate workaround for now (more
> > on this at the end).
> 
> Ah, got it.
> 
> > > There is a call to kmsg_dump(KMSG_DUMP_SHUTDOWN) in kernel_power_off()
> > > that appears to be intended to dump out the printk() buffers,
> > 
> > It only dumps the buffers to the registered kmsg_dumpers. It is not
> > responsible for flushing console backlogs.
> 
> That would explain its not doing much for me.  ;-)
> 
> > > but it
> > > does not seem to do so in kernels built with CONFIG_PREEMPT_RT=y.
> > > Does there need to be a pr_flush() call prior to the call to
> > > migrate_to_reboot_cpu()?  Or maybe even to do_kernel_power_off_prepare()
> > > or kernel_shutdown_prepare()?
> > 
> > With CONFIG_PREEMPT_RT=y, legacy consoles only print via a dedicated
> > kthread. Without a pr_flush() somewhere, there is basically no chance
> > that they will get backlogs flushed because noone is waitig for them.
> > 
> > The new console API (NBCON) provides support for "atomic consoles",
> > which _do_ flush by transitioning to synchronous printing during
> > shutdown/reboot. Unfortunately we still don't have any NBCON atomic
> > console implemented in the kernel. The 8250 UART will be our first
> > driver, most likely available in 6.15. (With the current PREEMPT_RT
> > patch applied, the 8250 NBCON atomic driver is used.)
> > 
> > Since only CONFIG_PREEMPT_RT=y has this issue, I am not sure if we want
> > to sprinkle pr_flush() calls on all sleepable shutdown/reboot paths,
> > although that is certainly one way to handle it. For your case, adding a
> > pr_flush() to rcu_torture_cleanup() and making pr_flush() non-private
> > would be an easy solution to avoid your problem.
> 
> Would it make sense to put a call to pr_flush() at the beginning of the
> kernel_power_off() function?  I suspect that would take care of much
> more than just rcutorture.
> 
> Or maybe after the pr_emerg("Power down\n"), since that is normally
> the last thing that shows up on rcutorture's console logs.
> 
> I will give that a shot and see what happens.  ;-)

And that does the trick!  I specified 500ms, but maybe -1 would be
better?  You tell me!  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 172b692a79ec5801eab57cb55d2f9c398f244c62
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Feb 5 12:27:23 2025 -0800

    printk: Flush console log from kernel_power_off()
    
    Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
    and shutdown time, which hides shutdown-time RCU issues from rcutorture.
    Therefore, make pr_flush() public and invoke it after then last print
    in kernel_power_off().
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: John Ogness <john.ogness@linutronix.de>
    Cc: Sergey Senozhatsky <senozhatsky@chromium.org>

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..b3e88ff1ecc3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -806,4 +806,6 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
 
+
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80910bc3470c..e0c6e5a99897 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2461,7 +2461,7 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -4466,7 +4466,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a701000bab34..3448e6ae3556 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(500, 1);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
