Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906220;
	b=FppQCLKef4JuzJi+Xl8LMCUEAmKTLYmY7f1kB9BT3uMvP6ZQUXaMSFTHWFhmFwG2VlEz
	 UH03IV9fEFNut22gpTUdo+AGxAi4YiZnLLqgbrfkBfpvh0GrBuj2o79ZKPMXSuXvImoJh
	 /UPJJJFcWYzPA32IitLWMNCrhuq++HkZ5JPiW9Ni1rqg9m/gnLy+9ifNBaFNEGP54WNJj
	 fiAYAEwrpozHYzv7EwcwH0CyBZYjNLFdsmPWZVi5SwqxaehysW+gLLVb0m0ckqiXokvci
	 LZFsjIZAgJV+D7j/QlViAS+UR9YetxbWIzfwODegQkgXUyZxysvcSv5YmooQJVc0Iwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906220;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=/QPRq8NRdoTQFGsCttss1QamdhdZEmRH+UBHc2dmMxI=;
	b=s9SaXqTRdQGv8Xjet7LQBwvUbfZb9OSXU6dNxWyfZhdMSQ38sMG2G7db87UD2jQxFHTY
	 szEQjFvyXd0CYzVDa1cPFulHriMxQDo2lmzsvdakc1kp32T2GcS7NAa0uFHi830a59zln
	 RjWX36uaDjP7y/KcM/C0BX+jAq8P6vNWi2rgdROaDaJblKm+swyVh+uYBArkJoIVnQU0F
	 HcVXGQgefrjzWva6CEKkRJwAPYwg4qQ+jPsQ/vBCjlMwgCIYDT2NSm3iColUGUKqAASZY
	 pHSt0m91LS8TdKn9rWWjwVZ88QMzkc8SvZTCJ58sx680SJ21bOHXRY1B3OGn5rTkkaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oVB9n8E3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/yFTPmVg";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3C606A328
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 19:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F3C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oVB9n8E3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/yFTPmVg
Date: Thu, 5 Nov 2026 20:16:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793906216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QPRq8NRdoTQFGsCttss1QamdhdZEmRH+UBHc2dmMxI=;
	b=oVB9n8E3qldcRTT58qnt8sZrL1ajwomPmBEQ0ja2tbswcXsRN7BxM1VdLagYs6EPoQEiRv
	FlLf/QYgmJWInW4IDOj0C6RUqh9myaw7DrShZd6CohruwvBX0fEMqxu9Vhr9O4+eTsmgGN
	qWQinBoEEUJD0CIboPj4vV0tGhwaZwyUc/MCvg19yBs1CuEoNrvH/AhglJhawmBG4GqYc6
	2xvGZIDyMVcFywC1myxJKVxaFRXnI6BYK2r/0Q/8rSOCr3/Nbjy69iIA8L/ZHs3PdsKHSs
	OqXXNmnM+/knVwnnjK2ObzU9mIdJfBNAERPEKpSRVml1RVeQ5UXVwBzSufHsHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793906216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QPRq8NRdoTQFGsCttss1QamdhdZEmRH+UBHc2dmMxI=;
	b=/yFTPmVg+cEiCzcRd/5sSrqXlLnNnXKxFstl5QgEP1tBbREFFM5PRLceKPqdlvTa1Fh99w
	BVQ6p2xBc8IoRgAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
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
Message-ID: <20261105191654.S8OPV16j@linutronix.de>
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>

On 2026-11-05 18:52:47 [+0000], Joel Fernandes wrote:
>=20
>=20
> > On Nov 5, 2026, at 1:36=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> >=20
> > =EF=BB=BFOn Thu, Nov 05, 2026 at 05:51:13PM +0100, Sebastian Andrzej Si=
ewior wrote:
> >> Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
> >> tests") added the ability to disable RT throttling while rcutorture was
> >> run.
> >>=20
> >> Since v6.12 the DL fair_server takes control of throttling and this
> >> interface no longer serves this purpose. That sysctl control still
> >> exists but serves a different cause.
> >>=20
> >> There is no in-kernel interface to provide this feature, one needs to
> >> echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
> >>=20
> >> Since sysctl_sched_rt_runtime does not do what it once did, remove it
> >> from rcutorture.
> >>=20
> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >=20
> > Thank you, but ouch...  Does this mean that there is no longer any usef=
ul
> > in-kernel way to test RCU priority boosting?

The DL server is per-CPU so you would need to check each one if
throttling is enabled. But RCU priority boosting is independent. If the
test requires SCHED_FIFO priorities and disabling throttling to ensure
progress we would have to add something assuming userland can't handle
this=E2=80=A6

> There should be a way to disable DL server. Adding Andreas to check if
> there is a way. But I am wondering if the prio boost tests are
> working, then is the DL server throttling broken? ;-)

As I wrote in the commit message,
| for i in $(find /sys/kernel/debug/sched/fair_server -name runtime); do
|         echo 0 > $i; done

would do the job from userland. But we don't have an in-kernel
interface (yes, I am bit confused if is 0 or -1, I lean towards 0 now).
The server _is_ throttling, this works. I will try check tomorrow how
rcutorture behaves. The difference is that throttling is per-CPU and not
global so it might not have *that* big of an impact.

> Thanks

Sebastian
