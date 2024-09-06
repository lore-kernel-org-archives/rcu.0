Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56A14264A
	for <rcu@vger.kernel.org>; Fri,  6 Sep 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608939; cv=none; b=BCohjg7iqXqPpnkiSPgkgjBWV8LdCqIEOTyy8crtcb1KdP43Kgegl6yk9oRDlexq+Mucxwg3yu2E9dd01b5V+eDyzHHu/m///kRlDwLAeO/Us41+Kot50YiPdd31psE+PEh/dDNirLKxaM4t6PvziksgK1BBh0jlI6FHbrJi5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608939; c=relaxed/simple;
	bh=Y4a1TqnZqQU9vqZEHNh5Yj/+pLvOc8E7D0eiGGcHhRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEBkkhsGIVPppcm11RZqJJc4AkEvwYFzolLZib7iTMil9++v8V2VH83R0FTs3TZA9zyWtxaXgTQFZePQz59FB/i4v7j85Mx33gXJnZyXPlSL1aY1bffSLUkW3GH58uNQA1d/b/RDrmvFoBuV8DWwSG3JoeQCzZgJReslp47It38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv00wFqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv00wFqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62031C4CEC4;
	Fri,  6 Sep 2024 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725608938;
	bh=Y4a1TqnZqQU9vqZEHNh5Yj/+pLvOc8E7D0eiGGcHhRI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kv00wFqkgHSOaTeHbHfc7pO+LZzzsEi2r2ftWTc9McGbgmwYy8ZxIh4z0Aw6Nb/U5
	 nnfEsqDmWq/5O4tQ9RxV2ZCg5TCScTcRmep0J51TqmE/zp8qFL8hjWzOMlF8EqZ50D
	 onDTM4VDSSVbWovWMsX76XO5fP22aoqayMXEO5IQgOwpkpNaCF5KT/AtbGcWJsUVkE
	 sYV9zadUD2uJEcbvCu3ts5xIvk9cZ4gy9VGEc86Kbe0FkhTJEsrmJp+/ksHjg5Xyxw
	 3nPpOyK71OR53WZ+RwP6og2PkNTFu2ms6CQtYFCju/g1fpqVwfyG4+1P8oFCL4oxIO
	 8u11KbYhsM2lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 82B36CE0B78; Fri,  6 Sep 2024 00:48:54 -0700 (PDT)
Date: Fri, 6 Sep 2024 00:48:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <d9e29f78-8374-4910-8021-ab005915e2b4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
 <CAFwiDX83q+8fHLrOaLtrbE5q1UKB1BFLS+tGKWyzSKLvDKzFmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX83q+8fHLrOaLtrbE5q1UKB1BFLS+tGKWyzSKLvDKzFmA@mail.gmail.com>

On Fri, Sep 06, 2024 at 12:02:00PM +0530, Neeraj upadhyay wrote:
> On Fri, Sep 6, 2024 at 11:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> > > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > > > > Yes, I'm preparing an update for the offending patch (which has one more
> > > > > > embarassing issue while I'm going through it again).
> > > > >
> > > > > Very good, thank you!
> > > >
> > > > So my proposal for a replacement patch is this (to replace the patch
> > > > of the same name in Neeraj tree):
> > >
> > > FYI, the diffstat against the previous version of the same patch is as follows.
> > > The rationale being:
> > >
> > > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex
> > >
> > > 2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
> > >    after the barrier's completion.
> > >
> > > 3) This fixes another issue: rcuoc must be parked _before_
> > >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
> > >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
> > >    leaving the nocb locked forever.
> >
> > Thank you!!!
> >
> > Just to make sure that I understand, I apply this patch on top of
> > Neeraj's current set of branches to get the fix, correct?
> >
> 
> I have pushed this diff to branch next.06.09.24a of shared-rcu tree
> and started testing.
> Will squash this diff to the original commit later.
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next.06.09.24a&id=0fc7fc28b5afc3037ae4e1464013bc38c4b51c99

Thank you!  I fired off light testing which is unlikely to be conclusive.
But if it passes, I will do some longer and more focused tests.

							Thanx, Paul

> - Neeraj
> 
> >                                                         Thanx, Paul
> >
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 755ada098035..97b99cd06923 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -1056,6 +1056,13 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> > >       /* Flush all callbacks from segcblist and bypass */
> > >       rcu_barrier();
> > >
> > > +     /*
> > > +      * Make sure the rcuoc kthread isn't in the middle of a nocb locked
> > > +      * sequence while offloading is deactivated, along with nocb locking.
> > > +      */
> > > +     if (rdp->nocb_cb_kthread)
> > > +             kthread_park(rdp->nocb_cb_kthread);
> > > +
> > >       rcu_nocb_lock_irqsave(rdp, flags);
> > >       WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > >       WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> > > @@ -1064,13 +1071,11 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> > >       wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
> > >
> > >       mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> > > +
> > >       if (rdp_gp->nocb_gp_kthread) {
> > >               if (wake_gp)
> > >                       wake_up_process(rdp_gp->nocb_gp_kthread);
> > >
> > > -             if (rdp->nocb_cb_kthread)
> > > -                     kthread_park(rdp->nocb_cb_kthread);
> > > -
> > >               swait_event_exclusive(rdp->nocb_state_wq,
> > >                                     rcu_nocb_rdp_deoffload_wait_cond(rdp));
> > >       } else {
