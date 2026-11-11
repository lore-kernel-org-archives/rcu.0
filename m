Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418238;
	b=IZgKg27ou7b2IGEEhWcImYnal9wBzptodvuJRIxgzzQ4M1bdcYIQ8txuCSVhPnorGQtd
	 d8gH5tXU0IcQJfNwHo0d1xnsQ/f1EV4VVpfYHoGsBFen1dAW2vTTqgZK297Y0K4Tbuu8n
	 S1JrASzajcTW8EQu2+kJtaU2iSbRIw1mMA7d7z+1BIXbEEWuSQiYRvujCdAx3pKt6Cgfl
	 FwWoCr/N/whmXLKmSuSxtdV9EgJuBqvuU83GYWHiEBQXHTj5mW8bnR/O6o88zGjGjz1PT
	 pv4kDWQfGL0d++pnIEu+rHUGWyvgVXdpqHTaN+mGxb40fhYgKNdPrAEPUNGkMviIBgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418238;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8pteISZo4JGnjEYYdv5X/rO0NwT3i1wKYr/LELsdGIE=;
	b=s3THXoIAJs/0SX5OWYiNUqYYspk7cl865JyPn79MmP+YNpCGrQFaP7uJHWsPDV24KUZK
	 SS0hDJELMk4LR4VGmB4hMqqg0JmwVaPXpyks7iZFK4hJi1fVR/9v+56IHZfGduEvPzEm0
	 9ZHJym+0v79EdwtiBmlmkyIyziAQhHolQRxr2LVYLF6ciNkmOMaFgQ/fjhkazl8/gDuYO
	 Hgnqje72YD1gSKdGYKalN+YbbI+qSJOsn5/QjKrzW6Pmk56fzXi+cdwszk7kuCChqIdF6
	 gefL+2zOAWcxL98ELAy9wLh2412eK3vWTL5Sfl8G2EAvJVp58cNwJ+/OQBRaj0WatVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHGW0Gp7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80249606A31C;
	Wed, 11 Nov 2026 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHGW0Gp7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226971F00A05;
	Wed, 11 Nov 2026 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418238;
	bh=8pteISZo4JGnjEYYdv5X/rO0NwT3i1wKYr/LELsdGIE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jHGW0Gp7FwCUKCnNuQ1C2BG/P3iuwP9SasaZCl1IzO/H/s20mRXtEtN74YxBwzaGc
	 CsWff9u7suZPOX5CM1D18TDvD9XbpH3UnCwch17MZ/lVkpLvfAL25LCpA5oQscfd5O
	 QHLvCNwJWg1J0RpP5azpsUZZDo1+p06I/g7Z7pas5PEZuAnmPskMrx0rfffvDgDOfS
	 Z9o2075EajDu7gA3u3OxEtdZGv3jDlsxf2/IKSWhFHwxSCmPjSfH4oKAXmppgai+Cl
	 ISBkqyR8fZPV0/O6n5em0Zc1uZQLca0G/HJh9z3h9KsyQQnbfJt2Xu21SkeFuDLJ9O
	 /6HEVX6i3rSjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA5ADCE0840; Wed, 11 Nov 2026 09:30:37 -0800 (PST)
Date: Wed, 11 Nov 2026 09:30:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <3e7f1b45-7163-4abd-b686-a17f137ecab9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
 <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
 <20261110080942.QxKXirzI@linutronix.de>
 <e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop>
 <20261111154319.2Iu5wbqr@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111154319.2Iu5wbqr@linutronix.de>

On Wed, Nov 11, 2026 at 04:43:19PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-10 10:48:31 [-0800], Paul E. McKenney wrote:
> > Unfortunately, my overnight run of TREE03, which does do RCU priority
> > boosting and has for some years, fails with the splat shown at the end
> > of this email.  Things go rapidly downhill from there.
> > 
> > For reference, I used this command on a 16-hardware-thread x86
> > laptop:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 9h --configs TREE03 --bootargs "rcutorture.test_boost=2" --trust-make
> > 
> > The "rcutorture.test_boost=2" is redundant but I was lazy.
> 
> I identified the issue. The hotplug notifier runs too early. This is
> only an issue if the CPU goes up because during "init" the notifier is
> run while CPU is marked active.

I hesitate to disable CPU hotplug during RCU priority boosting...  Yes,
one could argue that real-time workloads shouldn't be doing CPU hotplug.
Except that others seem to be working towards making CPU hotplug more
friendly to real-time situations.

But what fix did you have in mind?

> I remember you have a test where the VM/system has X CPUs but you boot
> with maxcpus=Y where Y < X. In that case the throttler is only disabled
> on the Y CPUs. If the remaining CPUs are then enabled at runtime then
> the fair_server remains enabled/ can't be disabled from the hotplug
> notifier.

That is TREE01, and you are right, that might be even more challenging
than the TREE03 scenario called out earlier.

I am OK disabling rcutorture testing of RCU priority boosting on TREE01.
In fact, there is already a commit headed towards the v7.4 merge window
that does just that:

1e924ea92887 ("rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios")

> >> this makes things easier.
> >
> >Don't worry, it won't happen again.  ;-)
> 
> However. I could make sure that the fair_server is not enabled on init
> if the rcu_throttler is built-in. This would make it easier again.

At this point, anything that would work and be reasonably robust against
future scheduler changes would be very welcome!  ;-)

							Thanx, Paul
