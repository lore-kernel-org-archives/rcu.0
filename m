Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F12517AE;
	Wed, 19 Mar 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375683; cv=none; b=I4+LRY3YKPBecNI04oKV79/Q38Fx7I1KpJ96Q4RJHjtMQYb5CahVwl8CQ4fTCr52SQX+mii8lCAFytfdw5Kps8x3yDngX+imxmKVy0WgNQccsvPmt5pMYjsfFaQEKPudLyO7zjiruhW550Q+U+Ii26oaFnn5BXy6GTMW3uAdBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375683; c=relaxed/simple;
	bh=qeM55awdSQIcmvsC6TWOY/wM2uV1rYNmWGWKC6YRuf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp6lp76fwX1ycuG+QwWC5LIkOd2ex3U1Qje3P0PIAaaigLVtoli4UuNwAXnukVpziRc0ppfpEWkPbGCkuu7Trf+oIC4nKFhFuWggHSA2K1RWIVkq10AT2hOoERM3W/4qzjTBun6SinoWgQtVpUx6Nq/SbH7LjME0i4MUkLDkRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgG55gvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgG55gvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35E6C4CEEA;
	Wed, 19 Mar 2025 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375682;
	bh=qeM55awdSQIcmvsC6TWOY/wM2uV1rYNmWGWKC6YRuf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgG55gvfIg9uyV2ANU0eHDcBYeMJg35iHlF2sTxZm811XPmkETZoGNmpw+uaJasDN
	 AOLtvxwjFFQEIR2UASjCXS/SZ7VcuNfZ3UVuEgzXC2hASkx8iQqdZuI+eH4DMpBFMS
	 pOMh+atKL3lY8UQWnzXH8Wzsc1D9C+rLIWmVnH1Am2oJpCmOqgmnH3tyZE2ureM5sb
	 +5e685o5GJgydjxZV9v+CEsc7NJwmM6HbOY27Xtq3RtJz6Jq+ZGLP3gR6//icbp6nO
	 e5TZT7FbLLweoDVRWnFjjuydKePwG9youB4B09BOAtO7EjzGQZKVWqH6POxHxoWBCB
	 xVO3j1p2OVGzA==
Date: Wed, 19 Mar 2025 10:14:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 4/5] rcu/exp: Warn on QS requested on dying CPU
Message-ID: <Z9qK_QGK2UsJqLOR@p200300d06f3e98759ed3c196478e337b.dip0.t-ipconnect.de>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-5-frederic@kernel.org>
 <476d11c8-ff63-4abc-a894-b9dabf92df8b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <476d11c8-ff63-4abc-a894-b9dabf92df8b@paulmck-laptop>

Le Tue, Mar 18, 2025 at 10:21:48AM -0700, Paul E. McKenney a écrit :
> On Fri, Mar 14, 2025 at 03:36:41PM +0100, Frederic Weisbecker wrote:
> > It is not possible to send an IPI to a dying CPU that has passed the
> > CPUHP_TEARDOWN_CPU stage. Remaining unhandled IPIs are handled later at
> > CPUHP_AP_SMPCFD_DYING stage by stop machine. This is the last
> > opportunity for RCU exp handler to request an expedited quiescent state.
> > And the upcoming final context switch between stop machine and idle must
> > have reported the requested context switch.
> > 
> > Therefore, it should not be possible to observe a pending requested
> > expedited quiescent state when RCU finally stops watching the outgoing
> > CPU. Once IPIs aren't possible anymore, the QS for the target CPU will
> > be reported on its behalf by the RCU exp kworker.
> > 
> > Provide an assertion to verify those expectations.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> But what do we do if this assertion triggers?

It means there is likely something to fix because an IPI has been sent
and somehow the CPU missed it.

> And do we want it to take
> effect only in kernels built with CONFIG_PROVE_RCU?  Or is such a broken
> assumption bad enough to justify a splat in production kernels?
> 
> If the answer to the last question is "yes" (and you, not me, work for
> a distro, so it is your question to answer):

I think it's bad enough to deserve a real warning. Also this is a slow path.

> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!

> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/tree.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3fe68057d8b4..79dced5fb72e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4321,6 +4321,12 @@ void rcutree_report_cpu_dead(void)
> >  	 * may introduce a new READ-side while it is actually off the QS masks.
> >  	 */
> >  	lockdep_assert_irqs_disabled();
> > +	/*
> > +	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
> > +	 * The requested QS must have been reported on the last context switch
> > +	 * from stop machine to idle.
> > +	 */
> > +	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
> >  	// Do any dangling deferred wakeups.
> >  	do_nocb_deferred_wakeup(rdp);
> >  
> > -- 
> > 2.48.1
> > 
