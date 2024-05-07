Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADD17BA1;
	Tue,  7 May 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103889; cv=none; b=H2azH4FsOyxU1OX/h87Ce4et/Nd9vvMKoS6Kih85IMnl/dWLhitvp9h9VC52o4Q0IkjP/Bjfp9It1TcV7pTb97H9qacMn75AsAOKwkogxNF+MU5uOzafD9VuhfLgkivlbgQYWIM8sXycOXKfrj69o2NrDv9bwQBRlRE4VDY4vAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103889; c=relaxed/simple;
	bh=Gogk1VdeqklvN8V+Xf671pTC95Wvzn4UGS93Wm7/U1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS+KIr6xpl+70iDVQWJoYyYXBp5nKfDPBbl89a8LE0OwnUMhMyo411jBb5w5hwZXfqWVR7VgEGg4bhAgIduT2JycV0xI2lefO/UQM7iaaSYl7LV0zsEt+9neU4j3Kp4nyH/HJgmXzhNqUAl50wcuu+GP+/+03inw2T1qQSMGwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce6zh//P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce6zh//P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002F0C2BBFC;
	Tue,  7 May 2024 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715103889;
	bh=Gogk1VdeqklvN8V+Xf671pTC95Wvzn4UGS93Wm7/U1Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ce6zh//PwJaXHIO4sEZXJeSoFQcJUUIIjo7Xwh+/KhL25ylW61NDQqxGUbVctU3VY
	 afEP5EFeyU8Damlq49jFg2ovH+9WqKD1oTJd7aOdUe1RYH1udtcVWTF8FgT2XEOiCi
	 UfZXIXRfx6KyUetdePENZ2XuwJssYokK7+ZLNrUB3kUo0++IZWk2cg+6Qrv9NoT+72
	 MX8Iu8dyyYph77peAObFKA4qW9RIPm/ulcIrxvPSsBC1BFkH5lJZ5m80u57IPVxlbx
	 Lk1vqX+rwAPgXwiJDl9uQM1T1FSuB061L2y90AkWzME4xuVdzF7BgMS0g4/65WcJFS
	 +SpfkndOqKX8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8446ACE14CC; Tue,  7 May 2024 10:44:48 -0700 (PDT)
Date: Tue, 7 May 2024 10:44:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpAsYJIfzYSKgdA@redhat.com>

On Tue, May 07, 2024 at 10:54:41AM -0400, Oleg Nesterov wrote:
> Hello,
> 
> I feel I don't really like this patch but I am travelling without my working
> laptop, can't read the source code ;) Quite possibly I am wrong, I'll return
> to this when I get back on May 10.

By the stricter data-race rules used in RCU code [1], this is a bug that
needs to be fixed.  This code is updating ->gp_count, which is read
locklessly, which in turn results in a data race.  The fix is to mark
the updates (as below) with WRITE_ONCE().

Or is there something in one or the other of these updates to ->gp_count
that excludes lockless readers?  (I am not seeing it, but you know this
code way better than I do!)

							Thanx, Paul

[1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing

> Oleg.
> 
> On 05/07, Uladzislau Rezki (Sony) wrote:
> >
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > The rcu_sync structure's ->gp_count field is updated under the protection
> > of ->rss_lock, but read locklessly, and KCSAN noted the data race.
> > This commit therefore uses WRITE_ONCE() to do this update to clearly
> > document its racy nature.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/sync.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> > index 86df878a2fee..6c2bd9001adc 100644
> > --- a/kernel/rcu/sync.c
> > +++ b/kernel/rcu/sync.c
> > @@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> >  		 * we are called at early boot time but this shouldn't happen.
> >  		 */
> >  	}
> > -	rsp->gp_count++;
> > +	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
> >  	spin_unlock_irq(&rsp->rss_lock);
> >
> >  	if (gp_state == GP_IDLE) {
> > @@ -151,11 +151,15 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> >   */
> >  void rcu_sync_exit(struct rcu_sync *rsp)
> >  {
> > +	int gpc;
> > +
> >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
> >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
> >
> >  	spin_lock_irq(&rsp->rss_lock);
> > -	if (!--rsp->gp_count) {
> > +	gpc = rsp->gp_count - 1;
> > +	WRITE_ONCE(rsp->gp_count, gpc);
> > +	if (!gpc) {
> >  		if (rsp->gp_state == GP_PASSED) {
> >  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
> >  			rcu_sync_call(rsp);
> > --
> > 2.39.2
> >
> 
