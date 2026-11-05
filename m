Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908183;
	b=Zhvmye7YqttiHvYUZDtvvWWxtjaklsY7XC+JmRFVZzeoVYtwZZQkN52ineCRUCtHdWLA
	 fbzv5cHE+Y0Zz0MI2A0isbqGLzZ0dR6zyHfCaJcr6nN1fVAbdmQwo4biHoPkSXGrpJJEC
	 f2FOPH90D8R4TdbKA9zSA9Mtkz2/DDcwMMv9SYNqyvhY9D1SGAHcrMWNXDym4NZn5vX1n
	 tNcmuCO7JZSMIG+F/yFvAI5IW6H9ccKwGM1nMAZpGYb6Ny3nBNc5/JS8ZHJEvMqz9k/ze
	 uUnBs50PdTXW+0j+s4EdDPhvaX7nMQxPJuehCvoJH7gxLTawxpPINPlHFtCJlWNF9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908183;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=L9s0dPurC/mWcPoEUfzuoBLGDzu/1nrQmyy2MaeW0Tc=;
	b=fXuWzv0PKm5W1dzkjaDlqmMDB6eBfveitCjLsAaOWtI7szhkjfSJiW0ZuWaGIyNQVnXB
	 NDBZra34zZ8edbH8tkYiqUGpChg+5NzP84mgc4OiOAL8XojGjsIlBV0GkVfxgO75vjZ1v
	 M7UEC0F6NyaBYLdNCI0tOoOsDhjaqZ0B1cx1T6IPQ93ADM9eklVY0v1Pku16Pg04IWbvM
	 sh3y5Hq6rPaeKRGYUV91dqfQWrqoY8nJFPD/4ZCDnOxHAN6y42TcoAE1S2KCxx9h9EI9P
	 JHRMOq+XJF93u8j6H1twTYrfqgaYMNDtQwDtBpuh0fE4W7H4+VmLGCRFeXrQSluV7Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aHTzqIP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACC6072C68;
	Thu,  5 Nov 2026 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHTzqIP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308661F008A7;
	Thu,  5 Nov 2026 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908183;
	bh=L9s0dPurC/mWcPoEUfzuoBLGDzu/1nrQmyy2MaeW0Tc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=aHTzqIP/OZuqnjwgHNA/Iiv3j91h6cZdeFEJuo2E0xlLpbuDOoJtuWMKJybUiEKu2
	 zpd8YvFc66ymdFJ8v6tkLaq7axwCFAnY8B1yCLTdyipK2/bQTbYfgmfNTUcbkeDTlu
	 bgVriNsP1C5ljg+VIb3Yd1B4Ef/ao2WvaIzO57qH6cLZf1Rc0WvaUBVSNUUWyr20mY
	 sAVecU0wg9I9mPOb8H2tkmMBgOo514WMaLzQQ7v6fa+52dErI2/KQmVm6PLXh0bs1P
	 urfmorkC/89YV7yXHd45x0e9wlIBM95pgRLMGl1JcwjrVPpAgZWjGUGR5QvwkerPfr
	 BJIupAnUd5YKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E64D4CE0B58; Thu,  5 Nov 2026 11:49:42 -0800 (PST)
Date: Thu, 5 Nov 2026 11:49:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <dd8977da-411d-44c2-9117-812813089801@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <20261105191654.S8OPV16j@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105191654.S8OPV16j@linutronix.de>

On Thu, Nov 05, 2026 at 08:16:54PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-05 18:52:47 [+0000], Joel Fernandes wrote:
> > 
> > 
> > > On Nov 5, 2026, at 1:36 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Thu, Nov 05, 2026 at 05:51:13PM +0100, Sebastian Andrzej Siewior wrote:
> > >> Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
> > >> tests") added the ability to disable RT throttling while rcutorture was
> > >> run.
> > >> 
> > >> Since v6.12 the DL fair_server takes control of throttling and this
> > >> interface no longer serves this purpose. That sysctl control still
> > >> exists but serves a different cause.
> > >> 
> > >> There is no in-kernel interface to provide this feature, one needs to
> > >> echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
> > >> 
> > >> Since sysctl_sched_rt_runtime does not do what it once did, remove it
> > >> from rcutorture.
> > >> 
> > >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > Thank you, but ouch...  Does this mean that there is no longer any useful
> > > in-kernel way to test RCU priority boosting?
> 
> The DL server is per-CPU so you would need to check each one if
> throttling is enabled. But RCU priority boosting is independent. If the
> test requires SCHED_FIFO priorities and disabling throttling to ensure
> progress we would have to add something assuming userland can't handle
> this…

Just to restate, the current tests run a CPU-bound kthread at real-time
priority for some tens of seconds (controlled by the test_boost_duration
module parameter) in order to see if RCU priority boosting correctly
boosts the readers higher than that priority.  If there is any throttling
of any of those CPU-bound kthreads in the meantime, we get a false
negative, that is, RCU priority boosting appears to be working when it
might not be.

> > There should be a way to disable DL server. Adding Andreas to check if
> > there is a way. But I am wondering if the prio boost tests are
> > working, then is the DL server throttling broken? ;-)

Looking forward to Andreas's info!

Inability to disable throttling would not result in test failure, but
instead potentially undeserved test success.  ;-)

> As I wrote in the commit message,
> | for i in $(find /sys/kernel/debug/sched/fair_server -name runtime); do
> |         echo 0 > $i; done
> 
> would do the job from userland. But we don't have an in-kernel
> interface (yes, I am bit confused if is 0 or -1, I lean towards 0 now).
> The server _is_ throttling, this works. I will try check tomorrow how
> rcutorture behaves. The difference is that throttling is per-CPU and not
> global so it might not have *that* big of an impact.

In theory, it is possible to extend rcutorture's mkinitrd.sh script to
create the /sys/kernel/debug directory and to mount debugfs on it, and
then implementing the above bash for loop in C, but in practice that is
feeling very hacky at the moment.  :-(

							Thanx, Paul
