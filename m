Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697024EF61;
	Wed, 19 Mar 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377362; cv=none; b=l8iUoJwDl0+fQqFy/ytfkOVkVkt/Ydg5q5DaZZFkOBI4Arti+DgZv2rZjeP0NwK8Ni4/h/2X2K/fQhyrw6DbZFMh+x5gWZioE8+0rWZh+qfcbcuRF7w7p6TwoRVst71Sz1avAxbTH3jkVJ7AuYftKVSLH47WNif92grAMhINgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377362; c=relaxed/simple;
	bh=5I7bLoOhUjRhAJe8JO3sETL0P3mTf5N8nwcK5TmVJWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm7k2t4yP3HMZOsAgOluVT95jDhSr9IqEgxJmTzz8jIIlTqhyST2YQqm7ligmU0gt1y82AFpcf88Vjp5cvkYV0PT3rtZILe9apSYnrVRAIfhg6RRCOgTwfVADNDTMGwohcvUMGtHnIoIc2jN5KJ6nZkZQicivdIwh9z9KBW19Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5j0ISZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5j0ISZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55843C4CEE9;
	Wed, 19 Mar 2025 09:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742377362;
	bh=5I7bLoOhUjRhAJe8JO3sETL0P3mTf5N8nwcK5TmVJWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5j0ISZltmtpxki7VwE01BSYWj+ZWaUr8gDeVO7j1j5q7GLnCPRCcsBTPQzcs/dxz
	 Y6mNrjdLvrPKcTehpUjRMeQlmaYlpSXm+xHYx1iSNvErLYqb19URtFlRlZW2ajjt12
	 cEKf9n2LEcTnpiVNUsRjhHt4X+WUIwgrbihKVo0Apz9jO+QGKsoa6zILLJvpwefpll
	 7HtTaFzaUXlZloJhAgkLR5Zjo7XsneOMjJsSfe/nqdD+LRCfVLL4uYdz3fctkDhg/d
	 EMgmJZADTQmq8r4MDjVChPKFglkdStfxHlLGxZU8z0u8Vjlbd8Ga+E+UG091zPeXpW
	 Zcd42ML+4ZI6g==
Date: Wed, 19 Mar 2025 10:42:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within
 hotplug IPI's blindspot
Message-ID: <Z9qRjkX4T-Jja5-w@p200300d06f3e98759ed3c196478e337b.dip0.t-ipconnect.de>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-6-frederic@kernel.org>
 <bf7a3b05-4218-42aa-b936-8fc86435db15@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf7a3b05-4218-42aa-b936-8fc86435db15@paulmck-laptop>

Le Tue, Mar 18, 2025 at 10:22:33AM -0700, Paul E. McKenney a écrit :
> On Fri, Mar 14, 2025 at 03:36:42PM +0100, Frederic Weisbecker wrote:
> > A CPU within hotplug operations can make the RCU exp kworker lagging if:
> > 
> > * The dying CPU is running after CPUHP_TEARDOWN_CPU but before
> >   rcutree_report_cpu_dead(). It is too late to send an IPI but RCU is
> >   still watching the CPU. Therefore the exp kworker can only wait for
> >   the target to reach rcutree_report_cpu_dead().
> > 
> > * The booting CPU is running after rcutree_report_cpu_starting() but
> >   before set_cpu_online(). RCU is watching the CPU but it is too early
> >   to be able to send an IPI. Therefore the exp kworker can only wait
> >   until it observes the CPU as officially online.
> > 
> > Such a lag is expected to be very short. However #VMEXIT and other
> > hazards can stay on the way. Report long delays, 10 jiffies is
> > considered a high threshold already.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Same CONFIG_PROVE_RCU question, same conditional:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

I don't have a strong opinion whether to keep this warning unconditional.
Perhaps this can depend on CONFIG_PROVE_RCU.

Thanks.

> 
> > ---
> >  kernel/rcu/tree_exp.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 6058a734090c..87a44423927d 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -406,8 +406,18 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> >  	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
> >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  		unsigned long mask = rdp->grpmask;
> > +		int nr_retries = 0;
> >  
> >  retry_ipi:
> > +		/*
> > +		 * In case of retrying, CPU either is lagging:
> > +		 *
> > +		 * - between CPUHP_TEARDOWN_CPU and rcutree_report_cpu_dead()
> > +		 * or:
> > +		 * - between rcutree_report_cpu_starting() and set_cpu_online()
> > +		 */
> > +		WARN_ON_ONCE(nr_retries++ > 10);
> > +
> >  		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
> >  			mask_ofl_test |= mask;
> >  			continue;
> > -- 
> > 2.48.1
> > 
