Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10C208D0;
	Thu, 10 Sep 2026 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999193; cv=none; b=XPMvpS2UvfzyhXl6bXWZL+4TMjTMgKAoRGyierjne55nk9Mrw9DT/v6ygpa1Mmoc0TdmWpt23obfIJzSaextOoekqi63Bz49Q/Lb8IAFocKp87jLXc5J1khgIC0ANiitzOoQuEkNuoH9tbqqOiQZqqHtnrZJllmOB1LYq/sfKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999193; c=relaxed/simple;
	bh=jl2hWYH055SQOZ724PY/pw8PwXqomzoV2dLz7Zn5Mvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGM473U4sHRkN0JbhlVrMoI7rlMA8UHvvZ5gFeZ/tyPom5W2vMexpu2pphVMlCaf7yYJYadqNryaU6g+nHhDEVMp1UyO0hBzld8TeZV8OWjXT8FzM8NDs+3627RcZXs2VJJZ4SdbM2nVU1z4lCXyyackc4sFVuzTSX/gXLvhFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN/AExS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN/AExS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EC1F000FF;
	Thu, 10 Sep 2026 00:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999191;
	bh=E2Pp+C3dtVXZ0/LU/m4Xex2Q3hKRP4eDXPU886amlTU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mN/AExS5pZo5agxJjkbPNkEA7WIvyAGkd48Oxn970cQNYP4oa+cqmwBlIeprVL6rJ
	 CJbmdyJ9VLMdDIXf/wweWou1aW7nuQOvk3uMtwIHjCEjre/+c3Dqh70uYrKrlPxxZT
	 dtYg1sygTg+P+tLQvHhSnyp3c1ib+XwcY8GVUVAcpUIkXuH6mzbc6s0fUtq56vPAPq
	 +ftwhu241fd3WsLzkmbgzTwgJzDzVp4TnEa6iRALJ2U6l8Kav0hJRCvRuIkVSlbSck
	 h6qLI9hecjuzuMu5deeHjgCRW56yBG0vzSZU+styfVQmyF7w4PAq+IT4sr8IFzXkFg
	 /2GHRIuMdCX4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E41D4CE0869; Wed,  9 Sep 2026 17:13:10 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:13:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in
 srcu_gp_end()
Message-ID: <8d5c8d6f-6788-43bc-b5e3-c8bca8e984be@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cb71412b-a688-4c70-9365-3f6bd40c9244@paulmck-laptop>
 <20260909024515.2429893-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909024515.2429893-1-kunwu.chan@gmail.com>

On Wed, Sep 09, 2026 at 10:45:14AM +0800, Kunwu Chan wrote:
> On Tue, 8 Sep 2026 16:38:19 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Sep 07, 2026 at 03:58:23PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > 
> > > The transition-to-big code path in srcu_gp_end() calls
> > > init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in the
> > > atomic context reachable from synchronize_srcu_atomic().  Atomic SRCU
> > > has no use for the srcu_node combining tree: it has neither callbacks
> > > nor srcu_barrier() operations, and its grace periods are serialized
> > > by ->srcu_atomic_gp_flag instead.
> > > 
> > > Skip this transition entirely for atomic SRCU, which is also defense
> > > in depth against any path that might wrongly set ->srcu_size_state for
> > > an atomic srcu_struct.
> > > 
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Again, given that we have this commit, is this patch needed?
> > 
> > 4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")
> > 
> > And again, if so, please tell me what I am missing.
> 
> Yes, this is a separate transition path. That commit suppresses the 
> initialization-time transition, while this patch prevents the transition 
> from srcu_gp_end(), which can otherwise call 
> init_srcu_struct_nodes(..., GFP_KERNEL) for an atomic SRCU.
> 
> So this is defense in depth for the atomic path.

Fair point.  But is there any additional pathway other than the
SRCU_SIZING_IS_TORTURE() check at the end of srcu_torture_stats_print()?

							Thanx, Paul

> Thanks,
> KunWu
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/srcutree.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 01f224a56b41..74acd5645d4c 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
> > >  		raw_spin_unlock_irq_rcu_node(sup);
> > >  	}
> > >  
> > > -	/* Transition to big if needed. */
> > > -	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> > > +	/* Transition to big if needed, but never for atomic SRCU. */
> > > +	if (!is_atomic && ss_state != SRCU_SIZE_SMALL &&
> > > +	    ss_state != SRCU_SIZE_BIG) {
> > >  		if (ss_state == SRCU_SIZE_ALLOC)
> > >  			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > >  		else
> > > -- 
> > > 2.43.0
> > > 
> > 
> 
> Sent using hkml (https://github.com/sjp38/hackermail)
