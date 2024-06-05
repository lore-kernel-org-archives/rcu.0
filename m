Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B182F2B;
	Wed,  5 Jun 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612964; cv=none; b=d25cY7NEPFgzmsWIp4kw5sEkMaLTJ5hMcjwbJrkBZbQ6GJARnvgMDciUqy824WWeypTcaA3cdzMb6Bm7lLyvFPwskHQ9ZZNBjgnq1Voj4hoI2l3ZonyazPhzoEYA6Mg+lD+7hyclW4cSv0x5stfx6Mm47yNTK0tRSJvPUrERNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612964; c=relaxed/simple;
	bh=/eZfIyfihyogUFjSawME/VcZ/BywkwBNTOKUunyvRAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLR0SXH5htRvVFgaHOYP12bZTpJphHQBq996T9BLiPlYEr79fULnBanMAKS5v5foG98uB3NesoZIug9pnVKMvdbbVOeESMucrYo5p1CTq/dDDYzy9Bq8S9cuU6/oJyBBB0vhtASDt4VkK033Dk/OufRQZtpLheRPP5O3tZbTE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed9oEX/I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed9oEX/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7035C2BD11;
	Wed,  5 Jun 2024 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612963;
	bh=/eZfIyfihyogUFjSawME/VcZ/BywkwBNTOKUunyvRAE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ed9oEX/IKoED3WZmFrayKOe+q3fNpHaDTLqpuzu6qrBvuLkxjBG7vcbi/ZiMDGxPQ
	 7BFnXSqy+hUNg+1Et8gJDFC64bA6TpGn7e/B7BNPXmIE68mm0udjMFUpw+fMqLznXy
	 m6xDztdqRgJSYNV6Nbzax+yk2oSGUPVl4Env/dqcG98gZtZZmwc3GD9g4N33EO8WXD
	 Rg862Y0RYImOF140+wHp7pZ3xc8N0oXJbkwllU7iXWitX1b4/abUnmiKEhFSNOTpdS
	 CNTr6AIiN06ltpAlmqfT6/R0VBTYNafwZni89RmMrCqD7vZxdx4GOlJaQ4q6tyg6pV
	 UAZRYWbweXfow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76A39CE0A73; Wed,  5 Jun 2024 11:42:43 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:42:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <def68906-9140-4d80-8676-654154559be9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org>
 <ZmCTvMVlOMFv0-zd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmCTvMVlOMFv0-zd@localhost.localdomain>

On Wed, Jun 05, 2024 at 06:35:08PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a écrit :
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > In the synchronize_rcu() common case, we will have less than
> > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > is pointless just to free the last injected wait head since at that point,
> > all the users have already been awakened.
> > 
> > Introduce a new counter to track this and prevent the wakeup in the
> > common case.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> >  kernel/rcu/tree.h |  1 +
> >  2 files changed, 31 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 6ba36d9c09bde..2fe08e6186b4d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> >  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> >  	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> >  		rcu_sr_normal_gp_cleanup_work),
> > +	.srs_cleanups_pending = ATOMIC_INIT(0),
> >  };
> >  
> >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >  	 * the done tail list manipulations are protected here.
> >  	 */
> >  	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > -	if (!done)
> > +	if (!done) {
> > +		/* See comments below. */
> > +		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> 
> This condition is not supposed to happen. If the work is scheduled,
> there has to be a wait_queue in rcu_state.srs_done_tail. And decrementing
> may make things worse.
> 
> So this should be:
> 
> if (WARN_ON_ONCE(!done))
>    return;

Or just this:

	WARN_ON_ONCE(!smp_load_acquire(&rcu_state.srs_done_tail));

Uladzislau, thoughts?  Is there some corner case where we really can
see that smp_load_acquire() hand back a NULL pointer, perhaps during boot?

							Thanx, Paul
