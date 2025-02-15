Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA6748F;
	Sat, 15 Feb 2025 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615888; cv=none; b=exXeGeYEC8Y0spx6VezYXMMUDsCDN9IU3s+X5ZQzGaEGuRYgaNXzpCOtgb2M6S9r6mjJTF1STc+OUfWp21moR5M7WilHVNq99WSLzBSxHRnPaR91mYgGWVIvAYnRJhY/t/RE8fAOlFoygMVcj3QqPT3S2APjbRJTFSLEiHc1TIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615888; c=relaxed/simple;
	bh=/RsSP7B8uA1gZJ7yfQ4XHMRCEWhxwYKlCUFm4QKIbSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4krev6FHty7mLyuazWVeUAy/3zMyqVdXylo6I2rM8t6iP9lInZYRyn4NL/8I8XO6t9IlFTxlHEvE5HbTsVqWYtay/mD6CpJU34U/Hh2VmiCbNUR8EG97+n5j/haZijK3QJiyj8bpJRu8I4BCakoH5oBIt/+GZsZ1Dr9oLJEfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVipA2fc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVipA2fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C8DC4CEDF;
	Sat, 15 Feb 2025 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739615887;
	bh=/RsSP7B8uA1gZJ7yfQ4XHMRCEWhxwYKlCUFm4QKIbSo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iVipA2fcy3y+c/y0vQJVXUXk5IPqP5iJEolhDlt7isC+0/waWyVHFJzQXsCOTjlox
	 mwN6PvSdK13eIByyw8SG7clc28x1dBGJ/uBL68akvukB5S6GB+SbBK8He3o0dDhJMM
	 ZXZhEn0yD8DOx9XBx46XSwFcJQd+zC+WoGuJoqbxqCawUwsIAF6CQxrv6gWDMatYfp
	 IHKazSInnVFGn2wGvI5mAm/gXewqeGMw9Bywf3i7KL9uk9cFtd6x44ev5oeU5qnJhe
	 3GaIVZqJIH+wipohjAzURP8DNG+saNXi1p0J3pPlxWHjKmqo2aSzFI/AqT5lmnI7v0
	 8qsgHoIxa5OYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AF53CCE092A; Sat, 15 Feb 2025 02:38:04 -0800 (PST)
Date: Sat, 15 Feb 2025 02:38:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <610596cf-9836-473f-bcdc-15c69b7e0cd4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>
 <Z68yzBURiIr_7Lmy@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z68yzBURiIr_7Lmy@pavilion.home>

On Fri, Feb 14, 2025 at 01:10:52PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 14, 2025 at 01:01:56AM -0800, Paul E. McKenney a écrit :
> > On Fri, Feb 14, 2025 at 12:25:59AM +0100, Frederic Weisbecker wrote:
> > > A CPU coming online checks for an ongoing grace period and reports
> > > a quiescent state accordingly if needed. This special treatment that
> > > shortcuts the expedited IPI finds its origin as an optimization purpose
> > > on the following commit:
> > > 
> > > 	338b0f760e84 (rcu: Better hotplug handling for synchronize_sched_expedited()
> > > 
> > > The point is to avoid an IPI while waiting for a CPU to become online
> > > or failing to become offline.
> > > 
> > > However this is pointless and even error prone for several reasons:
> > > 
> > > * If the CPU has been seen offline in the first round scanning offline
> > >   and idle CPUs, no IPI is even tried and the quiescent state is
> > >   reported on behalf of the CPU.
> > > 
> > > * This means that if the IPI fails, the CPU just became offline. So
> > >   it's unlikely to become online right away, unless the cpu hotplug
> > >   operation failed and rolled back, which is a rare event that can
> > >   wait a jiffy for a new IPI to be issued.

But the expedited grace period might be preempted for an arbitrarily
long period, especially if a hypervisor is in play.  And we do drop
that lock midway through...

> > > * But then the "optimization" applying on failing CPU hotplug down only
> > >   applies to !PREEMPT_RCU.

Yes, definitely only non-preemptible RCU.

> > > * This force reports a quiescent state even if ->cpu_no_qs.b.exp is not
> > >   set. As a result it can race with remote QS reports on the same rdp.
> > >   Fortunately it happens to be OK but an accident is waiting to happen.

To your point, I did in fact incorrectly decide that this was a bug.  ;-)

> > > For all those reasons, remove this optimization that doesn't look worthy
> > > to keep around.
> > 
> > Thank you for digging into this!
> > 
> > When I ran tests that removed the call to sync_sched_exp_online_cleanup()
> > a few months ago, I got grace-period hangs [1].  Has something changed
> > to make this safe?
> 
> Hmm, but was it before or after "rcu: Fix get_state_synchronize_rcu_full()
> GP-start detection" ?

Before.  There was also some buggy debug code in play.  Also, to get the
failure, it was necessary to make TREE03 disable preemption, as stock
TREE03 has an empty sync_sched_exp_online_cleanup() function.

I am rerunning the test with a WARN_ON_ONCE() after the early exit from
the sync_sched_exp_online_cleanup().  Of course, lack of a failure does
not necessairly indicate

> And if after do we know why?

Here are some (possibly bogus) possibilities that came to mind:

1.	There is some coming-online race that deprives the incoming
	CPU of an IPI, but nevertheless marks that CPU as blocking the
	current grace period.

2.	Some strange scenario involves the CPU going offline for just a
	little bit, so that the IPI gets wasted on the outgoing due to
	neither of the "if" conditions in rcu_exp_handler() being true.
	The outgoing CPU just says "I need a QS", then leaves and
	comes back.  (The expedited grace period doesn't retry because
	it believes that it already sent that IPI.)

3.	Your ideas here!  ;-)

							Thanx, Paul
