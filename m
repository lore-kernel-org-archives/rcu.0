Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCEC20E013;
	Wed, 16 Oct 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093253; cv=none; b=X/w9KDJrSvt1H+0362FqXEjrWQMhu4Gh2ogNHzJiRRoHYbmSxMczyM26oelRSzlKVz5qD97/2htlIy3Vb/0nqfI5fM+P5X4xK1F9AMltwuSAkWmpJWlpZUA7Oq4Ivr8049V8lXLY0X0c0Hh/jNZ0qMaggW298iWNtb+vzqSGCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093253; c=relaxed/simple;
	bh=satqrR7kjHJ0pob7EWE5Jxz00e+N19hNhHs8VVSD5t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm6iF1yWfACVAvbKlxNr6NmNtEssm2/4kzt2/mI96hvEcEL4+Ens154nTMgQpk7UtZ71Rg9N2WFwxnkjcHP8r0LsTPDoYZPS72WhYXaeiNzHWj+BthcBWDGKb5YRyVr4FzQxINwlu/MnCSNdhwMVWnItUXZKo5krBCTyzhfhuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8YYJSQS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJGPCg2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8YYJSQS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJGPCg2/"
Date: Wed, 16 Oct 2024 17:40:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729093250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6w6HVmg57NA0stD1XEyTQVlAkPaBhFNlecqvDS6xYA=;
	b=H8YYJSQSAHSVrIYtKUPEm3HjPhOgwMQXuwBryMYQfLNfAG9x/dNAXSEX+4qNnhq0f/l/ul
	IFaCnzaJeS++U+zHwm5S+9U8adJpuKS40mE1muaH3hhuDbsiLSTOPo1q2hXhFSzUOIfu2k
	F6RlPJa6vVnNAqEXvUncm7+NB5CwMAVnvME8Jkzaopfz8TAnDW0MmeDRYDMW6VDB7FqJVS
	9bqiK41v0LXsN+MuMimJsgHN70tnCUdGOFAu2VQh+4xvDAyywSRRQ768axAPMbQchO8qUR
	fkQ8QPnMdccfg9Z94dg3eGb/QeaEmReZODboScg760Sy05GW+ufz+X5CWVnwdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729093250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6w6HVmg57NA0stD1XEyTQVlAkPaBhFNlecqvDS6xYA=;
	b=lJGPCg2/YrEoBiaPcYBuESCXSWBubV7UsKpduIo7ZRwlaFyq2GC/UsJvxPQqGGbVqe9znG
	XSwrOZ4uAJtAzrDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [peterz-queue:sched/lazy] [sched, x86]  74d850cd4c:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <20241016154048.sdiJ85Zc@linutronix.de>
References: <202410151544.7d2292c6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202410151544.7d2292c6-lkp@intel.com>

On 2024-10-15 15:47:20 [+0800], kernel test robot wrote:
> Hello,
Hi,

it took me a while to reproduce this because it does not trigger without
the ltp userland and this is not downloaded properly so I had to
workaround it. However=E2=80=A6

> [   98.006999][  T543] busted-torture: rtc: 00000000639e821e ver: 6796 tf=
le: 0 rta: 6796 rtaf: 0 rtf: 6787 rtmbe: 1 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtb=
f: 0 rtb: 0 nt: 89 barrier: 0/0:0 read-exits: 64 nocb-toggles: 0:0
> [   98.017386][  T543] busted-torture: !!!=20
> [   98.017662][  T543] ------------[ cut here ]------------
> [   98.019330][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.=
c:2258 rcu_torture_stats_print+0x24c/0x610 [rcutorture]
> [   98.021831][  T543] Modules linked in: rcutorture torture
=E2=80=A6
> [   98.237025][  T543] ------------[ cut here ]------------
> [   98.238052][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.=
c:2263 rcu_torture_stats_print+0x373/0x610 [rcutorture]
> [   98.240000][  T543] Modules linked in: rcutorture torture
=E2=80=A6

It took me a while to figure out that this test is using
rcu_busted_torture_deferred_free() which in turn invokes the callback
before the grace period. Buh.
So it looks like LAZY preempt triggers this more reliably than the
normal preempt version=E2=80=A6

Sebastian
