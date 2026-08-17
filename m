Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E243A80C;
	Mon, 17 Aug 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975943; cv=none; b=sediMufQA50Nu1/OaVpOPuZ0xfu+/vHX5kAU4cBiBpBbxOIXdWonGGgySrOgTwH8f1sTtZ51P1/IWGj6AzNYhHkxWk2CUjC5a5Av90BGUDXNOuXG5av52sPYHP/yx7Gw0vhqDBiPd3SN2jIaSPavei6gyvRHg5WYd5MWFNCFx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975943; c=relaxed/simple;
	bh=whLp4VQJ11W9FF8YH3UE9BW3zGvNgHZnLowXxnte3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAFBNjA9OKRT/8+SDun7YUhU7Lk3qD147+/4JEhSfC43HVswoG1J2trHK1USMb6E8p3qy7ef5wuqObR+Dl9KcL9c9rHqoWAlDTJYnCnyesSfu+FNN88GZe1AIhBUcjnVbsxWKvDrXK7rDZwLhVe0t0TpTUHI/kM/UIdhjSXYvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etaDw40h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etaDw40h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5021F000E9;
	Mon, 17 Aug 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975941;
	bh=fBAlu1r2lvk6SmvLzH3lcGNBXNN/owPNzuHBstahDAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=etaDw40hb4DjVCE5yLn969Pe/c187Eu50Rfd6V9iHj0BwMsvtJwA0J56MhnWHb2L2
	 2pg73vFhsgn0tUlbUGybnCBmzL+Gf2w8lsvs/l/6BI/Wn87AlL5h73xfAXIi8cPkn0
	 XBMprk/hRCIdhPKWMLuC/zF0SV4+inGLjXN75NpCirL+SrHU5ziWiOHIHi76vJxyo6
	 j8Jf/I+UNHzR9YactB8w2ZERCET0JJkbLcqp2lfq3aSI1MiV6ce+CI76w5uMnM4wig
	 IRMkDb8Gdkw/6rzICmZ5JCUL+itoEK0aYNdrTArESDATZZTVCPRgWi42W0PgYGbIbd
	 I2Tq0SiHD0trA==
Date: Mon, 17 Aug 2026 16:12:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP
 completion in rcu_core()
Message-ID: <aoMWwva-MkA-OHkp@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-11-puranjay@kernel.org>
 <al-DopVEIe2FvLnv@localhost.localdomain>
 <CANk7y0hado1yb9Gaeg0FVX45E96E3U_8d6gJTF0=s-pjwcQEpQ@mail.gmail.com>
 <amE7NrJRm0YDYroX@pavilion.home>
 <CANk7y0g24_wj+PUKSRdkrCqY2P1tQ=5JxbWYZbWsbTLhR0M9Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0g24_wj+PUKSRdkrCqY2P1tQ=5JxbWYZbWsbTLhR0M9Lw@mail.gmail.com>

Hi Puranjay,

Le Fri, Jul 24, 2026 at 03:54:20PM +0100, Puranjay Mohan a écrit :
> Hi Frederic.
> 
> I took your approach and created this commit with minor changes to your diff:
> 
> A few points I'd like a second opinion on. I kept the unordered
> poll_state_synchronize_rcu_full_unordered() for the advance check (the
> old rcu_core() block used the ordered variant): this looks safe
> because rcu_segcblist_advance() re-checks each segment with the
> ordered poll_state_synchronize_rcu_full() before moving callbacks to
> RCU_DONE_TAIL, so the check here is only a gate and the barriers still
> apply where callbacks are actually advanced, please confirm that
> reasoning.

I confirm!

> need_note_gp_changes() runs the callback-list poll on the
> lockless preamble for both callers, including offloaded rdps where
> __note_gp_changes() won't advance anything; I left it ungated since it
> only leads to a trylock, but it could take a
> !rcu_rdp_is_offloaded(rdp) guard.

May make sense to spare the trylock if it's offloaded &&
rdp->gpnum == rnp->gpnum && likely(!rdp->gpwrap).

> I also dropped the
> rcu_segcblist_is_enabled() guard the rcu_core() block had, relying on
> __note_gp_changes() already operating on the cblist unconditionally
> for non-offloaded rdps.

Ok, some more below:

> 
> -- >8 --
> 
> From c38c5f599d699e2c40d3459fdf3ef383a99c0097 Mon Sep 17 00:00:00 2001
> From: Puranjay Mohan <puranjay@kernel.org>
> Date: Fri, 24 Jul 2026 07:26:25 -0700
> Subject: [PATCH] rcu: Advance callbacks for expedited GP completion in
>  note_gp_changes()
> 
> When rcu_pending() triggers rcu_core(), the callback advancement path
> through note_gp_changes() -> __note_gp_changes() bails out when
> rdp->gp_seq == rnp->gp_seq (no normal GP change). Since expedited GPs do
> not update rnp->gp_seq, rcu_advance_cbs() is never reached from there and
> callbacks satisfied by an expedited GP would otherwise remain stuck in
> RCU_WAIT_TAIL until the next normal GP.
> 
> This is currently handled by a dedicated advancement block in rcu_core()
> that polls the callback list and advances under a trylock. But callback
> advancement no longer depends on the leaf-node grace-period delta; it is
> driven by the grace-period state stored in the callback list, which
> tracks both normal and expedited GPs. __note_gp_changes() is the natural
> home for it, and hosting it there lets every note_gp_changes() caller
> benefit from expedited completions rather than just rcu_core().
> 
> Move the advancement into __note_gp_changes(): trigger rcu_advance_cbs()
> whenever rcu_segcblist_nextgp() confirmed with
> poll_state_synchronize_rcu_full_unordered() reports a completed grace
> period, and add need_note_gp_changes() so the lockless preamble takes the
> lock for an expedited-only completion instead of short-circuiting on
> rdp->gp_seq == rnp->gp_seq. Remove the now-redundant rcu_core() block.
> 
> The quiescent-state bookkeeping stays keyed to an actual rnp->gp_seq
> change, so an expedited completion never clears a still-pending
> core_needs_qs and stalls the normal grace period.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/rcu/tree.c | 56 ++++++++++++++++++++++++-----------------------
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 21b6ce1dffb63..0e700d0ecf27e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1270,27 +1270,33 @@ static bool __note_gp_changes(struct rcu_node
> *rnp, struct rcu_data *rdp)
>  {
>         bool ret = false;
>         bool need_qs;
> +       struct rcu_gp_seq gp_state;
>         const bool offloaded = rcu_rdp_is_offloaded(rdp);
> +       bool completed = rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
> +                        unlikely(rdp->gpwrap);
> 
>         raw_lockdep_assert_held_rcu_node(rnp);
> 
> -       if (rdp->gp_seq == rnp->gp_seq)
> -               return false; /* Nothing to do. */
> -
>         /* Handle the ends of any preceding grace periods first. */
> -       if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
> -           unlikely(rdp->gpwrap)) {
> +       if (completed ||
> +           (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> +            poll_state_synchronize_rcu_full_unordered(&gp_state))) {
>                 if (!offloaded)
>                         ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
> -               rdp->core_needs_qs = false;
> -               trace_rcu_grace_period(rcu_state.name, rdp->gp_seq,
> TPS("cpuend"));
> -       } else {
> +               if (completed) {
> +                       rdp->core_needs_qs = false;
> +                       trace_rcu_grace_period(rcu_state.name,
> rdp->gp_seq, TPS("cpuend"));
> +               }
> +       } else if (rdp->gp_seq != rnp->gp_seq) {
>                 if (!offloaded)
>                         ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
>                 if (rdp->core_needs_qs)
>                         rdp->core_needs_qs = !!(rnp->qsmask & rdp->grpmask);
>         }
> 
> +       if (rdp->gp_seq == rnp->gp_seq)
> +               return ret; /* Nothing else to do. */

We still need to process the below block if rdp->gpwrap, because rnp->gp_seq
might have wrapped and equal again rdp->gp_seq.

> +
>         /* Now handle the beginnings of any new-to-this-CPU grace periods. */
>         if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
>             unlikely(rdp->gpwrap)) {

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
