Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955F226522;
	Thu,  6 Feb 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835941; cv=none; b=kyJNyqOSlW4Y3vdbFM5pfQKhIe2tPKIPAwDE6jiVdWiY89C7xhWy9mChTx6UPGWTPdcMqrpvD1Xzah+teJ2FDSsn7CySikhQAf3Vo62nZA09U2vCo3A/z8J4w5h7UcxFiG06NhX7WYKh06bTC4+qa/RGBGnJJ9uczTJtWTRnMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835941; c=relaxed/simple;
	bh=+pCwVkUxh1c4QtxylWPTynxOfoxiyt0sFQ8MWyRjBMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVWpCpEOS+73A2Zx++GTPtwgCDREZT02RCtkN88Ckxe85zsq96epOPYxjXMkTupdXEDlwT5tli90eRPqG1U6hbwASEZagjc3E3HcqexEQDgnV6YsmCAxU0JCKQClnGmG9epCjZHeajYcnAfTjEPpjVfIEfPFBy7hrOqCr+Yw5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDzeH9GC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDzeH9GC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D447AC4CEDD;
	Thu,  6 Feb 2025 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835940;
	bh=+pCwVkUxh1c4QtxylWPTynxOfoxiyt0sFQ8MWyRjBMQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JDzeH9GCxH+zutCAFqJdQhZ8eQZMk/pyLFhOQ6EEuGk8wGWsfAeZ7gW65O7GDkhxU
	 q/5o17Z0cY+8xZAPQUYz/vfGvpKqjp5W1AZ0lipLFFsuENvHmcHUDWO1AohzXNjTlT
	 iaiwBv5FoFW6+kag6xjlz7iWRxVQKeOtmOPQl2HaxTpvcyJIOHISIHXbZMa4Mk1hls
	 s5IWYLJXtCs8/8pLbE0q87Fp+kioAuTkMcC9aaVmuOI/DXBp3HVlWgYrOy5ej/u05I
	 pJL1DE560XLYEJNLIlEafiVuUpAjiDQZrrkJ7+kPmm3OixE9K+i30Vhlkn2F1VuHqf
	 fm1FaaVTevNWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92964CE0809; Thu,  6 Feb 2025 01:59:00 -0800 (PST)
Date: Thu, 6 Feb 2025 01:59:00 -0800
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
Message-ID: <a6090e06-34af-4b71-a9b5-79d94005dc15@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
 <20250206090249.G7TXOt0y@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206090249.G7TXOt0y@linutronix.de>

On Thu, Feb 06, 2025 at 10:02:49AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-05 15:50:14 [-0800], Paul E. McKenney wrote:
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 4217a9f412b2..d658d7e81bef 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
> >  extern bool nbcon_device_try_acquire(struct console *con);
> >  extern void nbcon_device_release(struct console *con);
> >  void nbcon_atomic_flush_unsafe(void);
> > +bool pr_flush(int timeout_ms, bool reset_on_progress);
> …
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index a701000bab34..a84828d0757b 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -704,6 +704,7 @@ void kernel_power_off(void)
> >  	migrate_to_reboot_cpu();
> >  	syscore_shutdown();
> >  	pr_emerg("Power down\n");
> > +	pr_flush(1000, 1);
> 
> this could be true instead 1 given that the type is bool

Good point, and this matches other usage.  Will fix on my next rebase.

							Thanx, Paul

> >  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
> >  	machine_power_off();
> >  }
> 
> Sebastian
