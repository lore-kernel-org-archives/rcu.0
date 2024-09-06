Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD1131BDD
	for <rcu@vger.kernel.org>; Fri,  6 Sep 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602667; cv=none; b=NOzoSbWsVX7WFCB8Tol1iHv0IzqCQKPjQGbdu49RC5Z4Nl6awLQxgf+ZaOPwjYZIBrsNxF1ABK5oZm4NXDBugUxTtT9mVybVmuAHbA6JY9zKy0Xf83FIu1jUOV/SyX+Yztntxzl33Ev7S9aZMOzSx1xZpedXKMKkzhXgna66Ihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602667; c=relaxed/simple;
	bh=YC4khrztnPky40e0LzsCVHDmdPwZVPzwcZ35zTDsVoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVEu9KpwSexmYHrv0zjLcq+1qfNgERe7adxS7Gtzm6q2BEj+mlXOFSvOzN0ElSiBt2EzkkGNlCqPbEeTZOK2+DwT5S/O1XhFsM2bMhhY0TEz6d8SwIwNgoLXIHzVcr22aZq9Wqy3JMXvlkUv97BVUIjzZfFxgaGc34eNr5YU74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgWkxfRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgWkxfRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F7C4CEC4;
	Fri,  6 Sep 2024 06:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725602666;
	bh=YC4khrztnPky40e0LzsCVHDmdPwZVPzwcZ35zTDsVoc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZgWkxfRaQYxMU/lqw/gPFvxh3Ft2yVEJWOlP6NdHF87YOQ20JSn+vJaG4qregaWnd
	 gqI2Jr6jLPVmhLnSyLwgc9k33h0QYI53NMzPgUTSkSt2gcPWotxmulTU3fQ4vkx6dz
	 tl9uotISIJVfGKM7Ss3VZx7/8Zk7m5SbWkP3jf+EhqrPez/wsFGtk71UW1jjXWJzTH
	 0oPNtuAb423VqeBwLViJyy8zt430cOxTCJfx8hGtucVXnYcdD0aWNo1BvzsDKqYhVi
	 MHVuF6JhFg6KQF0QO3V+JCrdtTxltBu9AfJCFspBadc5vG+Ed5uu3+1gTODH5UxM2g
	 6HQ1dBdNn/oZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AEF20CE0EFD; Thu,  5 Sep 2024 23:04:22 -0700 (PDT)
Date: Thu, 5 Sep 2024 23:04:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztn7PpfFiYDRBjWX@localhost.localdomain>

On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > > Yes, I'm preparing an update for the offending patch (which has one more
> > > > embarassing issue while I'm going through it again).
> > > 
> > > Very good, thank you!
> > 
> > So my proposal for a replacement patch is this (to replace the patch
> > of the same name in Neeraj tree):
> 
> FYI, the diffstat against the previous version of the same patch is as follows.
> The rationale being:
> 
> 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex
> 
> 2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
>    after the barrier's completion.
> 
> 3) This fixes another issue: rcuoc must be parked _before_
>    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
>    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
>    leaving the nocb locked forever.

Thank you!!!

Just to make sure that I understand, I apply this patch on top of
Neeraj's current set of branches to get the fix, correct?

							Thanx, Paul

> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 755ada098035..97b99cd06923 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1056,6 +1056,13 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  	/* Flush all callbacks from segcblist and bypass */
>  	rcu_barrier();
>  
> +	/*
> +	 * Make sure the rcuoc kthread isn't in the middle of a nocb locked
> +	 * sequence while offloading is deactivated, along with nocb locking.
> +	 */
> +	if (rdp->nocb_cb_kthread)
> +		kthread_park(rdp->nocb_cb_kthread);
> +
>  	rcu_nocb_lock_irqsave(rdp, flags);
>  	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>  	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
> @@ -1064,13 +1071,11 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
>  
>  	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> +
>  	if (rdp_gp->nocb_gp_kthread) {
>  		if (wake_gp)
>  			wake_up_process(rdp_gp->nocb_gp_kthread);
>  
> -		if (rdp->nocb_cb_kthread)
> -			kthread_park(rdp->nocb_cb_kthread);
> -
>  		swait_event_exclusive(rdp->nocb_state_wq,
>  				      rcu_nocb_rdp_deoffload_wait_cond(rdp));
>  	} else {
