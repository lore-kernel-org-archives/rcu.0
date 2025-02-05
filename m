Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA188DF5C;
	Wed,  5 Feb 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785251; cv=none; b=eabSLnOH7BmfnATbrPXj9VFZVfuQJOuPWSLXbGnjFECHRIK6dewqYXXlNO0UwweINJGbnwP5LuIk1afYNjGdeqtTKhtSBKBr11iqZ6hTyFVQ74qGs+skPZXzVOCVR1AwIAs+M4mU7Gl3yGztRT14OXHi4+wOw7PnLfmjKnqkOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785251; c=relaxed/simple;
	bh=jlksgytH69leNLbI1Cv9xnprBTsFWuDeBH030+M3hV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uP/Wump/3zjVednKyRgYIgFUa8PIJhD4mofeWbInvnIyXh0XZrddz1pko6P5HHPbCBxWe+9FZZgO/7keo6wnPoZHfWzM0HgkMuqQDsj2GSbJQK199PxXPzGAw30GwcBo5ZQbXTG/TDVao2GVqfydw0grGOLKFEBPOiYc5B6HyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mm4rzdS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SqT2M3y3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mm4rzdS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SqT2M3y3"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738785247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMSAXj7fdF/3cpVVSi5y0V3ynqcVyw0ol5wvMXtAAYE=;
	b=mm4rzdS/mD5KTi/BfUcrgawqlXAX67aJn3ywCwn6PytYNmsIDMcWsZlj1CSVgsCvD+WxeJ
	ZmEDCZS8HUGmJudL7dIz5oqC5XAvOh0XLuCCovJYH5DLlbga0L5/eo1TjyVBy2AO9zGqGg
	oYNJziZASawxI22EstlJuwk8wRzvE89VGaXhxnfYAl4QavwwYJQqHmgoVDnfmmMI/9RviU
	b3Z9OrmoeQiRnIepJYrTux0DTQM/8bQr50O2HW8ZA1f+xXqZCnFzN55vI2dsmmFaRgz1i4
	vzc+7C8ZS7/UUteARh5Zds6GYfPoEZ4Nns6tPq8xTzuioEs+uZqbjYB5KiIyZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738785247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMSAXj7fdF/3cpVVSi5y0V3ynqcVyw0ol5wvMXtAAYE=;
	b=SqT2M3y3XwzprAbqqZAhd3w5JmpYKw8QJ7j+eMMIABaGjj5/cD+hMrH8gYgljVXix+9UjZ
	JWYNHkAUtww47HAA==
To: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
In-Reply-To: <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
Date: Wed, 05 Feb 2025 21:00:07 +0106
Message-ID: <84pljwi2w0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> This is caused by RCU falling behind a callback-flooding kthread that
>> invokes call_rcu() in a semi-tight loop.  Setting rcutree.kthread_prio=40
>> avoids the splat, but still gets the shutdown-time hang.  Retrying with
>> the default rcutree.kthread_prio=2 failed to reproduce the splat, but
>> it did reproduce the shutdown-time hang.
>> 
>> OK, maybe printk buffers are not being flushed?  A 100-millisecond sleep
>> at the end of of rcu_torture_cleanup() got all of rcutorture's output
>> flushed, but lost the subsequent shutdown-time console traffic.  The
>> pr_flush(HZ/10,1) seems more sensible, but this is private to printk().
>>
>> I would like to log the shutdown-time console traffic because RCU can
>> sometimes break things on that path.

pr_flush() was changed to private because there were no users. It would
not be a problem to make it available. Adding a pr_flush() to
rcu_torture_cleanup() would be an appropriate workaround for now (more
on this at the end).

> There is a call to kmsg_dump(KMSG_DUMP_SHUTDOWN) in kernel_power_off()
> that appears to be intended to dump out the printk() buffers,

It only dumps the buffers to the registered kmsg_dumpers. It is not
responsible for flushing console backlogs.

> but it
> does not seem to do so in kernels built with CONFIG_PREEMPT_RT=y.
> Does there need to be a pr_flush() call prior to the call to
> migrate_to_reboot_cpu()?  Or maybe even to do_kernel_power_off_prepare()
> or kernel_shutdown_prepare()?

With CONFIG_PREEMPT_RT=y, legacy consoles only print via a dedicated
kthread. Without a pr_flush() somewhere, there is basically no chance
that they will get backlogs flushed because noone is waitig for them.

The new console API (NBCON) provides support for "atomic consoles",
which _do_ flush by transitioning to synchronous printing during
shutdown/reboot. Unfortunately we still don't have any NBCON atomic
console implemented in the kernel. The 8250 UART will be our first
driver, most likely available in 6.15. (With the current PREEMPT_RT
patch applied, the 8250 NBCON atomic driver is used.)

Since only CONFIG_PREEMPT_RT=y has this issue, I am not sure if we want
to sprinkle pr_flush() calls on all sleepable shutdown/reboot paths,
although that is certainly one way to handle it. For your case, adding a
pr_flush() to rcu_torture_cleanup() and making pr_flush() non-private
would be an easy solution to avoid your problem.

John Ogness
