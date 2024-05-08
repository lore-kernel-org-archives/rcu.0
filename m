Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF645577E;
	Wed,  8 May 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172947; cv=none; b=atS1B5wBuaSDo2lqIHsg2DWUs6cwEY0mAriYuOGoHHT8X7j2vVPBfwAZ2QUhMJNMINOG5pLDJZglsO2RHde58wg8caukSBjcaxmk9zcLZ05ajQwhQuHVF7sxXvTmx0D85SCAUvkt41REwRuEb3hft7nzCvWy+ulkrVK/S7bGCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172947; c=relaxed/simple;
	bh=HFjEV6bitERe7TiGEuLCCfdbBkzxSKIi/HLyB6z3Y38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNrME1sz7z1BaGw63RSD2c2wzQX6YYBZuWUAhhlD2uTQxsXc0puA/X1uT41JQiWHHsuZRffWGYbjdxClwCoUU5lQeJTe675jCUS/pgi20JZ2stG9PtCazyYqXUOAHZ7E9Ds9JdGR2tAaTKqPtcXkaAp25HfGsPNfS3enfTUus7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPMc4kPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPMc4kPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E7FC4AF17;
	Wed,  8 May 2024 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715172947;
	bh=HFjEV6bitERe7TiGEuLCCfdbBkzxSKIi/HLyB6z3Y38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPMc4kPrKIUE897oq43s3XFEpz2n3ycWxi0zvc9DYiOdRCTdo62ThwUuhhywj8g1b
	 WCtSTXwqNq9GoIf3iZd8V+N4XRp8EdKbXRo63BRuhTzJlxR2xKWAonPVp4if/6gmCd
	 CeHKj7nOamyHUIyx+tfCPxYowTgX4ufLg6n8s78MftECQZDlICoECPYOw2FkX/flY7
	 RXrg2khU1N0dN1H5ZP+Ll4YbAf/1S333GDxQeVLBnJStGL31Hj9Z1xIVioiVbmGmG1
	 1VQ1iCdQWkTVHsMA8IaXb7W2d8TKyaK5EU0UVVHgewDpAYkrCTpurDvEs+YLonKkmk
	 kgef35TYEvL7A==
Date: Wed, 8 May 2024 14:55:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 20/27] rcu: Rename struct rcu_data .dynticks_snap into
 .watching_snap
Message-ID: <Zjt2UOBu57DUWi3_@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-21-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-21-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:24AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the snapshot helpers are now prefix by
> "rcu_watching". Reflect that change into the storage variables for these
> snapshots.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  .../RCU/Design/Data-Structures/Data-Structures.rst          | 4 ++--
>  kernel/rcu/tree.c                                           | 6 +++---
>  kernel/rcu/tree.h                                           | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> index 5389cc49bea13..de76c624fe93e 100644
> --- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> +++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> @@ -921,10 +921,10 @@ This portion of the ``rcu_data`` structure is declared as follows:
>  
>  ::
>  
> -     1   int dynticks_snap;
> +     1   int watching_snap;
>       2   unsigned long dynticks_fqs;
>  
> -The ``->dynticks_snap`` field is used to take a snapshot of the
> +The ``->watching_snap`` field is used to take a snapshot of the
>  corresponding CPU's dyntick-idle state when forcing quiescent states,

Not sure if it's handled in forecoming patches but:

s/dyntick-idle/watching

>  and is therefore accessed from other CPUs. Finally, the
>  ``->dynticks_fqs`` field is used to count the number of times this CPU

Looks like this one is a leftover...

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d3f3a049904fc..73b95240a1a6c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -770,8 +770,8 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
>   */
>  static int dyntick_save_progress_counter(struct rcu_data *rdp)
>  {
> -	rdp->dynticks_snap = rcu_watching_snap(rdp->cpu);
> -	if (rcu_watching_in_eqs(rdp->dynticks_snap)) {
> +	rdp->watching_snap = rcu_watching_snap(rdp->cpu);
> +	if (rcu_watching_in_eqs(rdp->watching_snap)) {
>  		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
>  		rcu_gpnum_ovf(rdp->mynode, rdp);
>  		return 1;
> @@ -803,7 +803,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  	 * read-side critical section that started before the beginning
>  	 * of the current RCU grace period.
>  	 */
> -	if (rcu_watching_changed_since(rdp, rdp->dynticks_snap)) {
> +	if (rcu_watching_changed_since(rdp, rdp->watching_snap)) {
>  		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
>  		rcu_gpnum_ovf(rnp, rdp);
>  		return 1;
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index affcb92a358c3..ac153e365355d 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -206,7 +206,7 @@ struct rcu_data {
>  	long		blimit;		/* Upper limit on a processed batch */
>  
>  	/* 3) dynticks interface. */
> -	int dynticks_snap;		/* Per-GP tracking for dynticks. */
> +	int  watching_snap;		/* Per-GP tracking for dynticks. */

/* Per-GP tracking for watching */

Thanks.

>  	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
>  	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
>  	bool rcu_forced_tick;		/* Forced tick to provide QS. */
> -- 
> 2.43.0
> 
