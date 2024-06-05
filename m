Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CD1373;
	Wed,  5 Jun 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613083; cv=none; b=OUN2Y17zDMT110UMYAZJqXsw2OKO+j38oXySENYE+YJS77UmibE5ioDCZHqCvCxZkR+F935Bkh6e48FTOKCE9Zo50fU+G6gv7GhA72Q7F7fxxkveT2Nb2BOue+cXoBIDsVO62VgwgFGFJKPMZ/f7IhqEAOd130ntcp+fclsQAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613083; c=relaxed/simple;
	bh=0m5eIs/1rxlE59oOvJmnITWMmk/piq0bn0tD1cPS7UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0mY/6NzBKKaoKbXSRabDNd3IIbOnTGUTg3zdlPMNBqRhQVyjhuvKBKZLxQ5JCA5j/vcgl3JklYQNkDLq+Yv5gj31wPgeAbBoBwikyWc417zS35A0hG7rfhppDpnOb/piHmHfcIPODO/mZqVKBPYQy0mLcoqNYUw6G345u79WjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwaGHNCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwaGHNCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F17C2BD11;
	Wed,  5 Jun 2024 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613083;
	bh=0m5eIs/1rxlE59oOvJmnITWMmk/piq0bn0tD1cPS7UU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EwaGHNCwm6XPOsDFjuee+XjEYaDFzREHFUt4EBfTceIYALq+4ajRvgvURmnwqWJ53
	 GLnSHSb9CSIG6J8S2+e78/XCYq/F09t9ECVgzfDld4Ji9DGGV7yI/TZcmLefVT0eUJ
	 gleJrN7M1Pn1xrRjI9mHuY2EoxioWiomLSWyNus+7CEYFus7v95C9pxq2msfXidtUy
	 vdkoMDsoaebjq7CKvYIhretFbEpxZWfifxP4bfuh1nKDx586BObPk2mYotn1an+Sgt
	 TcoCN+E2KWDqmCnRC+jB2/uKZ+Fm6MV8DMJGEUPZeax3ePNfQ7KBKNqPPk00Wg3Q5Z
	 1xwuBWVceZWTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAD04CE0A73; Wed,  5 Jun 2024 11:44:42 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:44:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 1/6] rcu: Remove full ordering on second EQS snapshot
Message-ID: <26b85288-dd54-4ace-978d-39681de8fcad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-1-paulmck@kernel.org>
 <ZmBYOaQQQKapFGZo@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmBYOaQQQKapFGZo@localhost.localdomain>

On Wed, Jun 05, 2024 at 02:21:13PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 04, 2024 at 03:26:47PM -0700, Paul E. McKenney a écrit :
> > From: Frederic Weisbecker <frederic@kernel.org>
> > 
> > When the grace period kthread checks the extended quiescent state
> > counter of a CPU, full ordering is necessary to ensure that either:
> > 
> > * If the GP kthread observes the remote target in an extended quiescent
> >   state, then that target must observe all accesses prior to the current
> >   grace period, including the current grace period sequence number, once
> >   it exits that extended quiescent state. Also the GP kthread must
> >   observe all accesses performed by the target prior it entering in
> >   EQS.
> > 
> > or:
> > 
> > * If the GP kthread observes the remote target NOT in an extended
> >   quiescent state, then the target further entering in an extended
> >   quiescent state must observe all accesses prior to the current
> >   grace period, including the current grace period sequence number, once
> >   it enters that extended quiescent state. Also the GP kthread later
> >   observing that EQS must also observe all accesses performed by the
> >   target prior it entering in EQS.
> > 
> > This ordering is explicitly performed both on the first EQS snapshot
> > and on the second one as well through the combination of a preceding
> > full barrier followed by an acquire read. However the second snapshot's
> > full memory barrier is redundant and not needed to enforce the above
> > guarantees:
> > 
> >     GP kthread                  Remote target
> >     ----                        -----
> >     // Access prior GP
> >     WRITE_ONCE(A, 1)
> >     // first snapshot
> >     smp_mb()
> >     x = smp_load_acquire(EQS)
> >                                // Access prior GP
> >                                WRITE_ONCE(B, 1)
> >                                // EQS enter
> >                                // implied full barrier by atomic_add_return()
> >                                atomic_add_return(RCU_DYNTICKS_IDX, EQS)
> >                                // implied full barrier by atomic_add_return()
> >                                READ_ONCE(A)
> >     // second snapshot
> >     y = smp_load_acquire(EQS)
> >     z = READ_ONCE(B)
> > 
> > If the GP kthread above fails to observe the remote target in EQS
> > (x not in EQS), the remote target will observe A == 1 after further
> > entering in EQS. Then the second snapshot taken by the GP kthread only
> > need to be an acquire read in order to observe z == 1.
> > 
> > Therefore remove the needless full memory barrier on second snapshot.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 28c7031711a3f..f07b8bff4621b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -321,7 +321,7 @@ static bool rcu_dynticks_in_eqs(int snap)
> >   */
> >  static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
> >  {
> > -	return snap != rcu_dynticks_snap(rdp->cpu);
> > +	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
> 
> I guess I'm going to add a comment here to elaborate on the fact
> it relies on the ordering enforced before the first snapshot. Would
> you prefer a delta patch or an updated patch?

Either works, just tell me which you are doing when you submit the patch.
Either way, I will arrange for there to be a single combined commit.

							Thanx, Paul
