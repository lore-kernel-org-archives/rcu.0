Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707418A6BA;
	Wed,  5 Feb 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799416; cv=none; b=r3ICUH4i0zJoppdLFtJpxDcZRt8mHPTWa2NEeTIQkVYP4HoVll68t3kcYy1Mv3ta2Ao0az9shMTGEnqNbV0CqcQY7IoO2m+flkiwI3WGJ+2hKkvpX+hC5TiOTWEij8evO6IItQ1cVRJUw7uFuXv53cATQet94SHbuolS1YI90n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799416; c=relaxed/simple;
	bh=WWl2S5+EyGyEtfzriFh+vpNpc+S5JQxM9/r6w/9TgLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+VCnLMLKFPdTsTo9VXQRoHJ86OsF983JHkjlqtCghUYry64IFqXq+z/pe39Le6ohWhphzWlsQwKtUrJRW80PZxPsS+3a3c4QibsnDVGPta5scYnOYdBz+SeCbiWtrLM4g3bCjeRXEf1igzB/J+9CsFLBkonQVph+Z/iV7APXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXU4BkCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXU4BkCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8892AC4CED1;
	Wed,  5 Feb 2025 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738799414;
	bh=WWl2S5+EyGyEtfzriFh+vpNpc+S5JQxM9/r6w/9TgLE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cXU4BkCDbcgNWXv+x/lfkaByZWYXA39FkEEQfPHCgbHtHAzmngzxeNsk9x1GyKzxt
	 fl2aMmIGhfcjcbyY8Iy7iJQ1Y4XMxZuQZYFoxmNWqjLkud2JCfLadwHUECgOkjbW0s
	 0EPiXwLEIEaxIftxlSptVrXIS+peft0832awGlz3oQtL6KUqp1aV1eEe2i2PsVG25C
	 ssRLhMOFyRPOP73YTzjqVNJBleBE+sF4DBNrUMdsMUWyfwEw8/1Im/8KGRX729wOK2
	 dm5ULgdR0Vng2eL+tD0GF63QTkaVYYY9web/ZRbIJHxFuDVY4/1EX/TO56B+a0fQdU
	 ozzJDIGKD7pbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 27852CE071A; Wed,  5 Feb 2025 15:50:14 -0800 (PST)
Date: Wed, 5 Feb 2025 15:50:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84y0ykyqf6.fsf@jogness.linutronix.de>

On Wed, Feb 05, 2025 at 11:37:25PM +0106, John Ogness wrote:
> On 2025-02-05, John Ogness <john.ogness@linutronix.de> wrote:
> >> OK, so I don't need to add "if (IS_ENABLED(CONFIG_PREEMPT_RT))" to guard
> >> it, then?
> >
> > For !CONFIG_PREEMPT_RT, if there are legacy consoles registered,
> > pr_flush() will additionally perform a blocking lock on the
> > console_lock.
> 
> Sorry, I was just thinking about the flushing component of
> pr_flush(). Later in the function it takes the console_lock even for
> CONFIG_PREEMPT_RT. So please do _not_ have a guard.
> 
> pr_flush() should never hang on the console_lock during shutdown, but if
> does, that is something that will need to be debugged and fixed.
> 
> @pmladek: Looking forward to reading your input on this.

Here is an updated commit, hopefully applying your feedback correctly.

							Thanx, Paul

------------------------------------------------------------------------

commit 35679c18b062368855e183ee6712ca5c16145d8c
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Feb 5 12:27:23 2025 -0800

    printk: Flush console log from kernel_power_off()
    
    Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
    and shutdown time, which hides shutdown-time RCU issues from rcutorture.
    Therefore, make pr_flush() public and invoke it after then last print
    in kernel_power_off().
    
    [ paulmck: Apply John Ogness feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: John Ogness <john.ogness@linutronix.de>
    Cc: Sergey Senozhatsky <senozhatsky@chromium.org>

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..d658d7e81bef 100644
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
 
+static bool pr_flush(int timeout_ms, bool reset_on_progress)
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
index a701000bab34..a84828d0757b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, 1);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
