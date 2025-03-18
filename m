Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12783211A33;
	Tue, 18 Mar 2025 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323059; cv=none; b=QoKkDICJQfUYgojMW4MycVaF5r6S2G0UT3IQvWKSLl4VFezP502RhFePCWrnb1girlCETPMinpjfoAVRlmoUK27lMq5jqKozwn3ru/HxQmpvaZJ9FJqQc3kTi8dzD3+ctfTYKjjSsyvYRmywfpoU+yO8AY7A2PST+Gogv1GNDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323059; c=relaxed/simple;
	bh=NQNyYuQ0gDwFBiLl4iNEd16gJk/XuNGSs7cGNUPV+v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFC8EN8+tVfMqhLhcsf7vmmKOhJEPybNvKovoTfH5z21LacPeZy8zGymHEPz2IecTggyXeqxr8J9na+03b+4XP3GhNKxAGOIGqxDxxXghwdlbYhwqSFUA3X1liYBQIB9chd9HVJhnLJXBkVFBld5kQ5B7SPZKVH7ivClqXtRRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqnikBan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqnikBan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EBDC4CEDD;
	Tue, 18 Mar 2025 18:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742323058;
	bh=NQNyYuQ0gDwFBiLl4iNEd16gJk/XuNGSs7cGNUPV+v8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nqnikBan2Fe3d5NWhuRT4/5yf7SnVtSfLTTx8VhHEMOGYTNr+pYvohz4qbGAb5aFH
	 sP0PaaBJL9aJ2dQqHu+GkxamNqIhurNtGSuhxvUMYUfd8FEdRLq3andnyvvUzMDUoO
	 rUv6b0GKZa0HocdNvxVkXqQjCtw3AOlmTPwUjdFM1okJiyk52Q2vFCdSo4+doTghF6
	 t4Ix8TCuJKaQA75NHeFq41BQ+tC9mEHXVC9Dlr3UXKQEp0Jw6keJVWObZsbjOzG5mr
	 Hi/nsr1G6IRx2mGQzp7WQSNL5CuC/KsoyHuq+LbXKctrme1GiuR1w9hoXu/gxABubr
	 R8wDoll1pppmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7401DCE0843; Tue, 18 Mar 2025 11:37:38 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:37:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Message-ID: <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318135619.4300-2-frederic@kernel.org>

On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
> The numbers used in rcu_seq_done_exact() lack some explanation behind
> their magic. Especially after the commit:
> 
>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> 
> which reported a subtle issue where a new GP sequence snapshot was taken
> on the root node state while a grace period had already been started and
> reflected on the global state sequence but not yet on the root node
> sequence, making a polling user waiting on a wrong already started grace
> period that would ignore freshly online CPUs.
> 
> The fix involved taking the snaphot on the global state sequence and
> waiting on the root node sequence. And since a grace period is first
> started on the global state and only afterward reflected on the root
> node, a snapshot taken on the global state sequence might be two full
> grace periods ahead of the root node as in the following example:
> 
> rnp->gp_seq = rcu_state.gp_seq = 0
> 
>     CPU 0                                           CPU 1
>     -----                                           -----
>     // rcu_state.gp_seq = 1
>     rcu_seq_start(&rcu_state.gp_seq)
>                                                     // snap = 8
>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
>                                                     // Two full GP differences
>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
>     // rnp->gp_seq = 1
>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> 
> Add a comment about those expectations and to clarify the magic within
> the relevant function.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

But it would of course be good to get reviews from the others.

> ---
>  kernel/rcu/rcu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eed2951a4962..7acf1f36dd6c 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -157,6 +157,13 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
>   * Given a snapshot from rcu_seq_snap(), determine whether or not a
>   * full update-side operation has occurred, but do not allow the
>   * (ULONG_MAX / 2) safety-factor/guard-band.
> + *
> + * The token returned by get_state_synchronize_rcu_full() is based on
> + * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
> + * against the root rnp->gp_seq. Since rcu_seq_start() is first called
> + * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
> + * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
> + * periods ahead of the root rnp->gp_seq.
>   */
>  static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
>  {
> -- 
> 2.48.1
> 
