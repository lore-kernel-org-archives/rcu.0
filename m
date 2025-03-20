Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0B211C;
	Thu, 20 Mar 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480138; cv=none; b=GxkqWLTRslVgY6pvdl1zoUB5ejlADBsXyEbNfykj0uTClal9Y1zPOxK4nDQqXLmPvxC4sp+epT/SEftsRyw5DU0l6WZKzgEtmvDEFRYjekTUCfJ7KVpzJ4iiJDYiQt5SwwOl1no8bJTm6t0Hr0qf/Nf9P+dMZjfLkDLJEEUgIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480138; c=relaxed/simple;
	bh=Cz+zxwlHWKS5x56xzygGWm2d2rVex5Tzua/p3TZygNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atGH1x2jN6qkcwUSgKFItvateoCMMmzEMuOcE+iN3tcHuWGMb0hZ/KxTmry2DzBG8om1+VvgS1htvKofqTLoRsh6Hf4RzTN/3Rj7AJiSqiyJcvFzjKREpQLgeuJ+7ZkZZ5GXuc4KzT0Jx+xX3GHAf0cVbmJL9K2eGVvcTNH0v6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF8NrnC8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF8NrnC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68183C4CEE3;
	Thu, 20 Mar 2025 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480137;
	bh=Cz+zxwlHWKS5x56xzygGWm2d2rVex5Tzua/p3TZygNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mF8NrnC8NFk3YtJg+vy1xQfu5P1ZC5ZX5LrYIbZapDTHlVIHgZnyOIwtJkygagqYY
	 OKOPgk80Kh9K6mZQEpciByoqdWp/hGIDIt+Vw9NsrMmFZ3aMUqpHcUAS8j1SUY4xBX
	 sPoEHo21JBwuvhZhFrfr7Tugb8sY3UgL+T4DWGXiKHCPkI9dUR7+q6Cj4085H2GwML
	 plsSnPA6YKSp2CPOGdfoHFS1DxzGa0yQECpCW2d963EaWEmut6Zm3BhbsoLlCjkiLo
	 jTldBcg9Gp56d8O9fttzz2FnGLECk8cBOC/bMdkqsYrq883hbviaFqygBDzUiWm/BA
	 tjWaSB5csaeeQ==
Date: Thu, 20 Mar 2025 15:15:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Message-ID: <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
 <20250319193831.GA3791727@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319193831.GA3791727@joelnvbox>

Le Wed, Mar 19, 2025 at 03:38:31PM -0400, Joel Fernandes a écrit :
> On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
> > > The numbers used in rcu_seq_done_exact() lack some explanation behind
> > > their magic. Especially after the commit:
> > > 
> > >     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> > > 
> > > which reported a subtle issue where a new GP sequence snapshot was taken
> > > on the root node state while a grace period had already been started and
> > > reflected on the global state sequence but not yet on the root node
> > > sequence, making a polling user waiting on a wrong already started grace
> > > period that would ignore freshly online CPUs.
> > > 
> > > The fix involved taking the snaphot on the global state sequence and
> > > waiting on the root node sequence. And since a grace period is first
> > > started on the global state and only afterward reflected on the root
> > > node, a snapshot taken on the global state sequence might be two full
> > > grace periods ahead of the root node as in the following example:
> > > 
> > > rnp->gp_seq = rcu_state.gp_seq = 0
> > > 
> > >     CPU 0                                           CPU 1
> > >     -----                                           -----
> > >     // rcu_state.gp_seq = 1
> > >     rcu_seq_start(&rcu_state.gp_seq)
> > >                                                     // snap = 8
> > >                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
> > >                                                     // Two full GP differences
> > >                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
> > >     // rnp->gp_seq = 1
> > >     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> > > 
> > > Add a comment about those expectations and to clarify the magic within
> > > the relevant function.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > But it would of course be good to get reviews from the others.
> 
> I actually don't agree that the magic in the rcu_seq_done_exact() function about the
> ~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
> because the small lag can just as well survive with the rcu_seq_done()
> function in the above sequence right?
> 
> The rcu_seq_done_exact() function on the other hand is more about not being
> stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
> wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
> least ULONG_MAX/2 AFAIU.
> 
> So the only time this magic will matter is if you have a huge delta between
> what is being compared, not just 2 GPs.

You're right, and perhaps I should have made it more specific that my comment
only explains the magic "3" number here, in that if it were "2" instead, there
could be accidents with 2 full GPs difference (which is possible) spuriously
accounted as a wrap around.

Thanks.

> 
> Or, did I miss something?
> 
> (Also sorry about slow email responses this week as I had my presentation
> today and was busy preparing this week and attending other presentations at
> OSPM, I'll provide an update on that soon!).
> 
> thanks,
> 
>  - Joel
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > 
> > > ---
> > >  kernel/rcu/rcu.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index eed2951a4962..7acf1f36dd6c 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -157,6 +157,13 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
> > >   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> > >   * full update-side operation has occurred, but do not allow the
> > >   * (ULONG_MAX / 2) safety-factor/guard-band.
> > > + *
> > > + * The token returned by get_state_synchronize_rcu_full() is based on
> > > + * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
> > > + * against the root rnp->gp_seq. Since rcu_seq_start() is first called
> > > + * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
> > > + * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
> > > + * periods ahead of the root rnp->gp_seq.
> > >   */
> > >  static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> > >  {
> > > -- 
> > > 2.48.1
> > > 
