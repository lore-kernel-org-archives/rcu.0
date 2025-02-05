Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83523CE;
	Wed,  5 Feb 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790531; cv=none; b=VubE8QTu5PzihMUBkYcDKdl3jxUr1OEqcuOwTHtyzHEOcmTB9jbvZWDGQjLHn3Ufh0sFnUK6wyShlx8TslVhupzdao7XLU+rNFh+Zq/thtYXnmLQMO+UtLazv369Jujr+3fpkg43kBw1mJx4oK6FQW7ew4qx7zzQEJf1ID9Eb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790531; c=relaxed/simple;
	bh=6UaFJ5dfXDsR86TEFbbJhO5+Tyug7OFwGGuIi56ZwVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dVCIvgKEyODXT88Ja2gG5Tj0JjpsSjf7YrG19/ITW7vUAa+1o6ZqPaBC8TTIQK3jdpjGeBfr2sE18BI7Zka9bdHpOhH0ji7dKC6lwr1Jnhrr7ioUAoaapGakbd/Rha3fmB+fBgjpZkXQZhiRVEoua7TL6/a8LrKivGON601vv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMv2d5oc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIJPJ0nA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMv2d5oc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIJPJ0nA"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738790527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/HAxvUTiJawdWe3C8a9yYvj7IQz7aWvPm5qvpIh5KI=;
	b=UMv2d5ocRKG7Avi5xa5iV+eOVdYG6RUjbyXBhYe/tQuWBn29m0QVnCVVzzYVw+uoiA3SVT
	NMQ+9dEwTz64G3qM9J4WKRHcJ7hOJyJ8hPoccPHGOlDq9uNY4eeDvJv0IfbX47B704pwhI
	ckat09iDdRbwovwC5Lo4GZSn3TIRp5LL7ZAf5mi/KTqtVwrQCjKwBh5/RDxwdMG86F95Ge
	fS3PLUSoJ3r/EJ/6IKGhfJ369BahGQ1k13oRLLHqDujVrPWqiQbS4YY3FDSLc+7UsKdAjL
	bhISojgoqdZyhF9cb6n7Nomk9NRs9oWoNJX38ToRBK+J7VxtIBR/TMJeEid8cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738790527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/HAxvUTiJawdWe3C8a9yYvj7IQz7aWvPm5qvpIh5KI=;
	b=pIJPJ0nADSN3rHUQSS9DVGmXy4gxYetpvYjDxXgLXZGT1fIEeHpHq9uVbbM68xKIUuwgTt
	sso/tX7hvAfIiICg==
To: paulmck@kernel.org, Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
In-Reply-To: <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
Date: Wed, 05 Feb 2025 22:28:06 +0106
Message-ID: <84ed0c1401.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> Would it make sense to put a call to pr_flush() at the beginning of the
>> kernel_power_off() function?  I suspect that would take care of much
>> more than just rcutorture.
>> 
>> Or maybe after the pr_emerg("Power down\n"), since that is normally
>> the last thing that shows up on rcutorture's console logs.

Yes, after the pr_emerg("Power down\n"), as in your patch below.

> And that does the trick!  I specified 500ms, but maybe -1 would be
> better?  You tell me!  ;-)

I probably would have chosen 1000ms, but if the kthread has made no
forward progress after a few max timeslices, it probably is dead or will
not be scheduled anyway.

If there is no backlog, pr_flush() returns immediately.

I recommend _not_ using timeout_ms=-1 here, in case the kthread cannot
be scheduled (for whatever reason).

> ------------------------------------------------------------------------
>
> commit 172b692a79ec5801eab57cb55d2f9c398f244c62
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Feb 5 12:27:23 2025 -0800
>
>     printk: Flush console log from kernel_power_off()
>     
>     Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
>     and shutdown time, which hides shutdown-time RCU issues from rcutorture.
>     Therefore, make pr_flush() public and invoke it after then last print
>     in kernel_power_off().
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Petr Mladek <pmladek@suse.com>
>     Cc: Steven Rostedt <rostedt@goodmis.org>
>     Cc: John Ogness <john.ogness@linutronix.de>
>     Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 4217a9f412b2..b3e88ff1ecc3 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -806,4 +806,6 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
>  #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
>  	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
>  
> +
> +bool pr_flush(int timeout_ms, bool reset_on_progress);

This will fail to link for !CONFIG_PRINTK.

In kernel/printk/printk.c currently there is:

#ifdef CONFIG_PRINTK
static bool pr_flush(int timeout_ms, bool reset_on_progress);
#else
static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
#endif

This would need to move to include/linux/printk.h

There you will find an existing CONFIG_PRINTK if/else block to move
those to.

>  #endif
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 80910bc3470c..e0c6e5a99897 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2461,7 +2461,7 @@ asmlinkage __visible int _printk(const char *fmt, ...)
>  }
>  EXPORT_SYMBOL(_printk);
>  
> -static bool pr_flush(int timeout_ms, bool reset_on_progress);
> +bool pr_flush(int timeout_ms, bool reset_on_progress);
>  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
>  
>  #else /* CONFIG_PRINTK */
> @@ -4466,7 +4466,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>   * Context: Process context. May sleep while acquiring console lock.
>   * Return: true if all usable printers are caught up.
>   */
> -static bool pr_flush(int timeout_ms, bool reset_on_progress)
> +bool pr_flush(int timeout_ms, bool reset_on_progress)
>  {
>  	return __pr_flush(NULL, timeout_ms, reset_on_progress);
>  }
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a701000bab34..3448e6ae3556 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -704,6 +704,7 @@ void kernel_power_off(void)
>  	migrate_to_reboot_cpu();
>  	syscore_shutdown();
>  	pr_emerg("Power down\n");
> +	pr_flush(500, 1);

I would have chosen:

	pr_flush(1000, true);

but I really don't have an argument either way.

>  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_power_off();
>  }

John Ogness
