Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507774;
	b=HJVZOZol038DB14bVUYP+b/xe+vF+CyNAFuq+us7C5RTOuDgy2P3fu+NggNnKI+Pi1Ok
	 iD7rpbllJemJj3HxwnIhoXpeYJiy6KZOekmvmcYCrBg89/XIR2pEW9JuLN1OYADIpjzf8
	 4gj1HkNeF6FmwVt8sAPBSVbNM0MeMr78UxxW5dxeCK8EACHeHu8BS8cCvm3sQCIvErw/B
	 tZpMkm3FzeCJavDdiPCahzdLw26jdNyMln21NKXp5Pya28aU0KB7eYWJ1Da3UAmzrnz1v
	 6TK2ceoy9ac+JxHcIIhrZ6n/KWjQp7SpaLJnqvNt86lQBXA+ZcrlK8rlKKXVYGAgPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=d02aero8/VUysXf+14hzl2XCPyXHdagUTgMG3cILv9g=;
	b=FAqU/VzKSK8SWnh9J+RkOwPmC/6Ix2Mql4vG2sB286pA5IklAgtScA2gGeD3qVwFvDLs
	 x0jLILJq1bdeGjkDvmuEVkWQaUdDv24SoQEUpm9bPJsz26pfNBr7kzVrn6ZfN9QQIZ3x2
	 D5VAojISm6NlkSqVLZYfMeXtXjcCTmQYJWw14PcHfz7i8kVjhh+UrF0JbhiYZeVNFx7C6
	 1PODn78YCbOSgGxpxs7/XxB2L7DYVHdjVjabSBp81Xmy+Jy5luA9KMAJHNQVGUtv3bdPd
	 wy6ziU+A3KuT0eWGLKOlVxj/Tl8a5nLusG8NFt62uMwGRuH7TQIKyv6v2BGWGx7RiNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1XVZZlq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0AD606A31D
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1XVZZlq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A9E1F000C4;
	Tue, 20 Oct 2026 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507773;
	bh=d02aero8/VUysXf+14hzl2XCPyXHdagUTgMG3cILv9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S1XVZZlqE/RcaZO5Y1lyA8UP1aQkGECgD5fmHESz1JlVuW3dtj4Uxvz4wFuP2oVXp
	 VmY0PoIfrwnqtpY7g+VgCDhfs1mBv7QEVESbNAClXC4SsZc+CPiDyuAQH7JuR+FoLx
	 kWI5X6Yd0rooTrzl5pYvKveGtzT8X/SXRlpmpd1i5bDqC46blgPD0LuP5ymxrwC5Pu
	 6lb49UzhrvlON9TaTIgntIg/dsxE77S+GNbIuO+OU3irRYFwGkiVNQ5v+bUqijObUc
	 MtNZNtrkgVuxsFOiQbGC44BctXeGl+fmCCdcgJzLi7ZyISzbRwopaQEVrSnB3IPK1A
	 LHbXwHoNvTdKg==
Date: Tue, 20 Oct 2026 16:49:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>
Subject: Re: [PATCH] rcu: Move expedited-GP callback advancement into
 __note_gp_changes()
Message-ID: <atd_e4lj_pukYvro@localhost.localdomain>
References: <20261016102843.2782262-1-puranjay@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016102843.2782262-1-puranjay@kernel.org>

Le Fri, Oct 16, 2026 at 03:28:42AM -0700, Puranjay Mohan a écrit :
> Commit ec5ee5417b002 ("rcu: Advance callbacks for expedited GP
> completion in rcu_core()") advances callbacks whose grace period was an
> expedited one from a dedicated block in rcu_core().  That block is
> needed because __note_gp_changes() returns early when
> rdp->gp_seq == rnp->gp_seq, and expedited grace periods do not change
> rnp->gp_seq.
> 
> The advancement depends only on the grace-period state kept in the
> callback list, which covers both normal and expedited grace periods, so
> it can be done in __note_gp_changes() instead.  Move it there.  This is
> mostly a relocation, with the following differences:
> 
> - rcu_cbs_gp_done() combines rcu_segcblist_nextgp() with
>   poll_state_synchronize_rcu_full_unordered(), and returns false for
>   offloaded CPUs, as the removed block did.  need_note_gp_changes() uses
>   it so that the lockless check in note_gp_changes() takes the leaf
>   rcu_node lock for such a completion, and rcu_pending() now calls
>   need_note_gp_changes() instead of open-coding the same tests.
> 
> - The removed block gated on poll_state_synchronize_rcu_full(), which
>   executes smp_mb() on every rcu_core() with pending callbacks.  The
>   gate is now the unordered variant from fde2b18817e4f.  Which callbacks
>   become ready is still decided by rcu_segcblist_advance(), which uses
>   the ordered poll.
> 
> - note_gp_changes() has one other caller, the qhimark path of
>   call_rcu_core(), which now also advances callbacks on an expedited
>   completion.  __note_gp_changes() is also called by rcu_gp_init(),
>   where an expedited completion now takes rcu_advance_cbs() instead of
>   rcu_accelerate_cbs(), which it ends with anyway.  In rcu_gp_cleanup(),
>   the leaf rcu_node's ->gp_seq has just advanced, so the existing
>   completed-grace-period path is taken as before.
> 
> - An expedited-only completion (rdp->gp_seq == rnp->gp_seq and ->gpwrap
>   clear) returns before touching core_needs_qs, cpu_no_qs, rdp->gp_seq
>   or gp_seq_needed.
> 
> One behavior change is not related to expedited grace periods.  With
> ->gpwrap set and rdp->gp_seq == rnp->gp_seq, the early return skipped
> the code that clears ->gpwrap and recomputes core_needs_qs from
> rnp->qsmask.  That case is now processed.  It exists at boot:
> rcu_data is statically initialized with .gpwrap = true, and
> rcutree_prepare_cpu() sets rdp->gp_seq from rnp->gp_seq without
> clearing it.  Until the first grace period starts, ->gpwrap therefore
> stays set and the ->gpwrap test in rcu_pending() reports work pending.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/tree.c | 105 ++++++++++++++++++++++++++++------------------
>  1 file changed, 64 insertions(+), 41 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index aea3aef7397ec..c224a8bc8aa6b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -163,6 +163,7 @@ static void rcu_report_exp_rdp(struct rcu_data *rdp);
>  static void rcu_report_qs_rdp(struct rcu_data *rdp);
>  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
> +static bool poll_state_synchronize_rcu_full_unordered(struct rcu_gp_seq *gsp);
>  static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
>  static bool rcu_init_invoked(void);
>  static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
> @@ -1260,30 +1261,63 @@ static void rcu_strict_gp_check_qs(void)
>  	}
>  }
>  
> +/*
> + * Has a grace period (normal or expedited) that this CPU's pending callbacks
> + * are waiting on completed?  Offloaded CPUs are handled by their rcuog
> + * kthreads, so always say "no" for them.  This is a racy, memory-ordering-free
> + * hint: the ordered check is done by rcu_segcblist_advance() when the
> + * callbacks are actually advanced.  The hint can also be true for callbacks
> + * that have not yet been assigned a grace period, because the stale
> + * ->gp_seq[RCU_WAIT_TAIL] then looks completed.  That is harmless, as the
> + * resulting rcu_advance_cbs() assigns them one.
> + */
> +static bool rcu_cbs_gp_done(struct rcu_data *rdp)
> +{
> +	struct rcu_gp_seq gp_state;
> +
> +	return !rcu_rdp_is_offloaded(rdp) &&
> +	       rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> +	       poll_state_synchronize_rcu_full_unordered(&gp_state);
> +}
> +
>  /*
>   * Update CPU-local rcu_data state to record the beginnings and ends of
>   * grace periods.  The caller must hold the ->lock of the leaf rcu_node
>   * structure corresponding to the current CPU, and must have irqs disabled.
> - * Returns true if the grace-period kthread needs to be awakened.
> + * Also advances callbacks whose grace period was an expedited one, which
> + * does not change ->gp_seq.  Returns true if the grace-period kthread
> + * needs to be awakened.
>   */
>  static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
>  {
>  	bool ret = false;
>  	bool need_qs;
> +	bool cbs_done;
>  	const bool offloaded = rcu_rdp_is_offloaded(rdp);
> +	// ->gpwrap means ->gp_seq cannot be trusted, even if it now equals ours.
> +	const bool gp_changed = rdp->gp_seq != rnp->gp_seq || unlikely(rdp->gpwrap);
> +	const bool completed = rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
> +			       unlikely(rdp->gpwrap);
>  
>  	raw_lockdep_assert_held_rcu_node(rnp);
>  
> -	if (rdp->gp_seq == rnp->gp_seq)
> +	/*
> +	 * Expedited grace periods do not change ->gp_seq, but they can still
> +	 * make callbacks ready to invoke.  The callback list tracks both
> +	 * normal and expedited grace periods, so use it to detect that case.
> +	 */
> +	cbs_done = !completed && rcu_cbs_gp_done(rdp);

Why the "!completed" here? rcu_cbs_gp_done() should be enough.

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks a lot!

-- 
Frederic Weisbecker
SUSE Labs
