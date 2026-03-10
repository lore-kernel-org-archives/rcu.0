Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBE391E5A;
	Tue, 10 Mar 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151885; cv=none; b=s4AhDk9dPBIPL7WvP5koQO4vDr+cnuUaMYT0ajHcjWojcTUkA2sf8Cqdu5Z+Qlr4xnQP5emWszLi+DMZ+VaSm8rY49iir2O/KRRAKApO77+DHzrooLkFzv84MJ4MOk3TwxVUTYt3SBjO/3cnn4//4nK24CbqCK3kmaXHHDYC1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151885; c=relaxed/simple;
	bh=D4XasxjdtMt0GlxfVbMvPaarC8pjWZP2eZno0eC++AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3ngMPjsDm1EADzNtfQLNSTByQVev/t+LeWp0mQMPMgmJFHBYaxxYfQHZpwYKwB6CSJMcCxBGkKYot5rKPT1+m9/0akSwJHBa85yWOxobqbdnK32WH0GvDvOR016hNzca2L8A+AqcfUyUQv7UiLJWCG5p1xp5BmCDF1H2/Y+o8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+CuXnWl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+CuXnWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31243C19425;
	Tue, 10 Mar 2026 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773151884;
	bh=D4XasxjdtMt0GlxfVbMvPaarC8pjWZP2eZno0eC++AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+CuXnWl2jnYMApTYpq9IOgvM+3wz4Vvf2pY8Rm6zl1Iv7r9B98hutw5bJXkYq5OY
	 aYGbcgfgXOQdzHwZd+8lLKZbKJ8NmfuTuusyW6x7iItWPpXqvuNOU23LEraR/P2t2k
	 zooG1obfPJeTgRw4uqhnD88PRVN1aYMvDWbdPsrcbQ+dkjKYUo9bU45MO+cDcUBDos
	 2DynN78YnuYhLwnqPkU9jKLLCgVCp2QGDhzE+p/rgIi7WaUxP2nHDj4W2qoTdf8CbU
	 jIQguRjZw14QilGUNGMweoawxlgGyNGpeZ4Qk9awdjBQYlMOBz0bqFnEOA9EtWSJIQ
	 mafOuJkiGN5Tg==
Date: Tue, 10 Mar 2026 15:11:21 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E.McKenney" <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <abAmiX85PFNq2Ua-@localhost.localdomain>
References: <20260302100404.2624503-1-urezki@gmail.com>
 <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>
 <aaliA7sc4Nnu_i_C@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaliA7sc4Nnu_i_C@milan>

Le Thu, Mar 05, 2026 at 11:59:15AM +0100, Uladzislau Rezki a écrit :
> On Tue, Mar 03, 2026 at 03:45:58PM -0500, Joel Fernandes wrote:
> > On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:
> > 
> > >  * The latch is cleared only when the pending requests are fully
> > >    drained(nr == 0);
> > 
> > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > +{
> > > +	long nr;
> > > +
> > > +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > > +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > > +
> > > +	/* Latch: only when flooded and if unlatched. */
> > > +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> > > +}
> > 
> > I think there is a stuck-latch race here. Once llist_add() places the
> > entry in srs_next, the GP kthread can pick it up and fire
> > rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
> > in-flight completion drains count to zero in that window, the unlatch
> > cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
> > then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:
> > 
> >   CPU 0 (add_req, count just hit 64)       GP kthread
> >   ----------------------------------       ----------
> >   llist_add()    <-- entry now in srs_next
> >   inc_return()   --> nr = 64
> >   [preempted]
> >                                             rcu_sr_normal_complete() x64:
> >                                               dec_return -> count: 64..1..0
> >                                               count==0:
> >                                               cmpxchg(latched, 1, 0)
> >                                                 --> FAILS (latched still 0)
> >   [resumes]
> >   cmpxchg(latched, 0, 1) --> latched = 1
> > 
> >   Final state: count=0, latched=1  -->  STUCK LATCH
> > 
> > All subsequent synchronize_rcu() callers see latched==1 and take the
> > fallback path (not counted). With no new SR-normal callers,
> > rcu_sr_normal_complete() is never reached again, so the unlatch
> > cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.
> > 
> > This requires preemption for a full GP duration between llist_add() and
> > the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
> > systems.
> > 
> > The fix: move the cmpxchg *before* llist_add(), so the entry is not
> > visible to the GP kthread until after the latch is already set.
> > 
> > That should fix it, thoughts?
> > 
> Yes and thank you!
> 
> We can improve it even more by removing atomic_cmpxchg() in
> the rcu_sr_normal_add_req() function, because only one context
> sees the (nr == RCU_SR_NORMAL_LATCH_THR) condition:
> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 86dc88a70fd0..72b340940e11 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1640,7 +1640,7 @@ static struct workqueue_struct *sync_wq;
>  
>  /* Number of in-flight synchronize_rcu() calls queued on srs_next. */
>  static atomic_long_t rcu_sr_normal_count;
> -static atomic_t rcu_sr_normal_latched;
> +static int rcu_sr_normal_latched; /* 0/1 */
>  
>  static void rcu_sr_normal_complete(struct llist_node *node)
>  {
> @@ -1662,7 +1662,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  	 * drained and if it has been latched.
>  	 */
>  	if (nr == 0)
> -		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
>  }
>  
>  static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> @@ -1808,14 +1808,22 @@ static bool rcu_sr_normal_gp_init(void)
>  
>  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>  {
> -	long nr;
> +	/*
> +	 * Increment before publish to avoid a complete
> +	 * vs enqueue race on latch.
> +	 */
> +	long nr = atomic_long_inc_return(&rcu_sr_normal_count);
>  
> -	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> -	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> +	/*
> +	 * Latch on threshold crossing. (nr == RCU_SR_NORMAL_LATCH_THR)
> +	 * can be true only for one context, avoiding contention on the
> +	 * write path.
> +	 */
> +	if (nr == RCU_SR_NORMAL_LATCH_THR)
> +		WRITE_ONCE(rcu_sr_normal_latched, 1);

Isn't it still racy?

rcu_sr_normal_add_req                                   rcu_sr_normal_complete
---------------------                                   ----------------------
                                                        nr = atomic_long_dec_return(&rcu_sr_normal_count);
                                                        // nr == 0
                                                        ======= PREEMPTION =======
// 64 tasks doing synchronize_rcu()
rcu_sr_normal_add_req()
   WRITE_ONCE(rcu_sr_normal_latched, 1);
                                                        cmpxchg(&rcu_sr_normal_latched, 1, 0);


Also more generally there is nothing that orders the WRITE_ONCE() with the
cmpxchg.

Is it possible to remove rcu_sr_normal_latched and simply deal with comparisons
between rcu_sr_normal_count and RCU_SR_NORMAL_LATCH_THR?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
