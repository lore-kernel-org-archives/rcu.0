Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546C22617E;
	Thu,  6 Feb 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837119; cv=none; b=C2tZWAKFgINCy79olsYstDaRnSe/GCGLYgo1lzzn2vd4kKn9NRtB+VbxvW1iey7WpCxbo9aJqbz2sY9wTVW/KUm59pv4NcBjDwA5rPaS4jkFDS+VGSjmsSJ1/4b76Vt2jj8MlaGkrvNTutapoMf9ekH/8W1d0aAEfCENnedf87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837119; c=relaxed/simple;
	bh=sKgK4n742urQz6RPy5PwBIny4WYqbq8rW4TbqRRvwgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Jj5QNBXNu39rWIFnDd0DJjCZNkREiktQoxXVsR5cftBTMSyr6rY4kFoqeUL7G71B6cGbujQaUoARB9701Hy1OzUCgaksXaYx+dcuc0NwXPdxwderx5Aqm08lNAHfc54e3kSec3RPwD3EgdrFHj8lYAAdTsXzhqf7d3ukQYLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5ukKH/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5ukKH/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC889C4CEDD;
	Thu,  6 Feb 2025 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738837119;
	bh=sKgK4n742urQz6RPy5PwBIny4WYqbq8rW4TbqRRvwgI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=W5ukKH/fLA3MZYjxg3zXxNOZTIOqAgEN5SF6gxrQOd4I9UvMdS5v7a4wbPSmAervD
	 55gtaX2IkNdxYrSPa7C0KTUt30oC9V+h8s4tNGRDaHsbofEveCJ9pE8ri4pKYaoeKL
	 jxZjSkUYGqCn5QtRbNk3ALO9vYP/plk4zvRm+mkodZSuKXdlgfOgoNV+yb+4N7D5Fg
	 wO6OrNP6rCuCGWFcEUWpLtk2gSr8WkS5TtQYwZFkchGvKMqLTr0M6xgEsa5kjqUhOV
	 I4AxCB/nXh+cwc8Zf0NMcjdSn7PH0MUvVzRnVcdRnfi8uKBu9yE8EP66ub1CLDx72n
	 DkRghnzTJt8vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9233ACE0B74; Thu,  6 Feb 2025 02:18:38 -0800 (PST)
Date: Thu, 6 Feb 2025 02:18:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <1c5acc45-24b0-488d-9a93-8d9b187c013c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
 <20250206090249.G7TXOt0y@linutronix.de>
 <a6090e06-34af-4b71-a9b5-79d94005dc15@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6090e06-34af-4b71-a9b5-79d94005dc15@paulmck-laptop>

On Thu, Feb 06, 2025 at 01:59:00AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 06, 2025 at 10:02:49AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-02-05 15:50:14 [-0800], Paul E. McKenney wrote:
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index 4217a9f412b2..d658d7e81bef 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
> > >  extern bool nbcon_device_try_acquire(struct console *con);
> > >  extern void nbcon_device_release(struct console *con);
> > >  void nbcon_atomic_flush_unsafe(void);
> > > +bool pr_flush(int timeout_ms, bool reset_on_progress);
> > …
> > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > index a701000bab34..a84828d0757b 100644
> > > --- a/kernel/reboot.c
> > > +++ b/kernel/reboot.c
> > > @@ -704,6 +704,7 @@ void kernel_power_off(void)
> > >  	migrate_to_reboot_cpu();
> > >  	syscore_shutdown();
> > >  	pr_emerg("Power down\n");
> > > +	pr_flush(1000, 1);
> > 
> > this could be true instead 1 given that the type is bool
> 
> Good point, and this matches other usage.  Will fix on my next rebase.

And here is the updated commit.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 04ccc09a6eb9a50f79c0a0e46fd273b5131b24f1
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Feb 5 12:27:23 2025 -0800

    printk: Flush console log from kernel_power_off()
    
    Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
    and shutdown time, which hides shutdown-time RCU issues from rcutorture.
    Therefore, make pr_flush() public and invoke it after then last print
    in kernel_power_off().
    
    [ paulmck: Apply John Ogness feedback. ]
    [ paulmck: Appy Sebastian Andrzej Siewior feedback. ]
    [ paulmck: Apply kernel test robot feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: John Ogness <john.ogness@linutronix.de>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Sergey Senozhatsky <senozhatsky@chromium.org>

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..5b462029d03c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80910bc3470c..b9699eaacf19 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2461,7 +2461,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2474,7 +2473,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4466,7 +4464,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a701000bab34..3ba15b2c4066 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
