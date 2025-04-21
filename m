Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88363EC5;
	Mon, 21 Apr 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260372; cv=none; b=vChKNT1Z7iwV1JLG7QU6g2Ewki51une+XMglEXijVYmc5FrVnmwrOgzcOBEG2IfeFUzfYtuCCBTG9MDhYjlFWmPI7Q2F0rI+2Ytytb1e1FJN6iODYEgrifgRPJuRPYbWqXdGGmyW2R+ssD5l7l3bKjkB94kD/MVxH4+h5SLmwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260372; c=relaxed/simple;
	bh=TDErpoqiN6MvKYSOjzQPf0lbnU5uGlEhpTjMaQeHHpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7n11tAep3OVXHqC0OcR8L0YLoSYA7YgK09c46JwCs2npoVtnkIs/n2x1OWanmv+9TEAuHGQzgO0l9pN7qJ1aphW5/HU2XdR0GgHrv+l4nly/Xb+3nfDBjkBeA1l4vGDhagd/w9aTCQkXlBgN5eZLxyp34NudAoVgdScCnReTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7a2ouVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7a2ouVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47DBC4CEE4;
	Mon, 21 Apr 2025 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745260372;
	bh=TDErpoqiN6MvKYSOjzQPf0lbnU5uGlEhpTjMaQeHHpw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F7a2ouVpgfzYzX3MpMeY4mUersxAkJEmujyLoWRd/lsAnv82lO+i7XhVxzvIAsurK
	 +YNuUK86eZuLo3fsIhtw4UfVUzUpmk/FWgWzQTyNOkZv3dccgYyNqsUnDbZ/fBlQMP
	 fFbOsfABkq8OoUZtA2LNLyzA6Zj/d1V7Arf2nPwDH56awXd/6idJAL0DpuwtiJfBTJ
	 zAZR+5ffO5naox1xY/lEzEU0YB9PDXTEzk2Js+2drzrY29qyikMokmT4Hu75pQ94ZF
	 1YeM9uVLvP5YUYr7i5nWsMZgt7INEl7twU6yXlG7KBku8ylcfNnysqygBMlD57COr3
	 eqRa8ze6FeeIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88E7CCE0855; Mon, 21 Apr 2025 11:32:51 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:32:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] rcutorture: Perform more frequent testing of ->gpwrap
Message-ID: <6e1d8bbb-41b6-4e5f-878a-c35a7405444b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250421174717.3332525-1-joelagnelf@nvidia.com>
 <cdc20491-a0a8-4dfd-9326-797bb0de0f90@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc20491-a0a8-4dfd-9326-797bb0de0f90@nvidia.com>

On Mon, Apr 21, 2025 at 01:53:17PM -0400, Joel Fernandes wrote:
> On 4/21/2025 1:47 PM, Joel Fernandes wrote:
> > Currently, the ->gpwrap is not tested (at all per my testing) due to the
> > requirement of a large delta between a CPU's rdp->gp_seq and its node's
> > rnp->gpseq.
> > 
> > This results in no testing of ->gpwrap being set. This patch by default
> > adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> > between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> > configurable, including the active time for the setting and a full
> > testing cycle.
> > 
> > By default, the first 25 minutes of a test will have the _default_
> > behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> > we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> > this is reasonable since we at least add a little bit of testing for
> > usecases where ->gpwrap is set.
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> > v4->v5
> >  - Added gpwrap_lag torture param to turn off entire test.
> >  - replaced references to 'ovf' with 'gpwrap lag'.
> > 
> > Will move this to my rcu/torture-for-6.16 and update my rcu/for-next branches.
> >  
> >  .../admin-guide/kernel-parameters.txt         |  5 ++
> >  kernel/rcu/rcu.h                              |  4 ++
> >  kernel/rcu/rcutorture.c                       | 72 ++++++++++++++++++-
> >  kernel/rcu/tree.c                             | 34 ++++++++-
> >  kernel/rcu/tree.h                             |  1 +
> >  5 files changed, 113 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 76e538c77e31..e1d11b6595fd 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5657,6 +5657,11 @@
> >  			are zero, rcutorture acts as if is interpreted
> >  			they are all non-zero.
> >  
> > +	rcutorture.gpwrap_lag= [KNL]
> > +			Enable grace-period wrap lag testing. Setting
> > +			to false prevents the gpwrap lag test from
> > +			running.
> > +
> FYI, I added docs for the additional params here as well:

Even better, thank you!

> +       rcutorture.gpwrap_lag= [KNL]
> +                       Enable grace-period wrap lag testing. Setting
> +                       to false prevents the gpwrap lag test from
> +                       running.
> +
> +       rcutorture.gpwrap_lag_gps= [KNL]
> +                       Set the value for grace-period wrap lag during
> +                       active lag testing periods. This controls how many
> +                       grace periods differences we tolerate between
> +                       rdp and rnp's gp_seq before setting overflow flag.

I suggest adding the default, as well as the default when no testing
is taking place.

							Thanx, Paul

> +       rcutorture.gpwrap_lag_cycle_mins= [KNL]
> +                       Set the total cycle duration for gpwrap lag
> +                       testing in minutes. This is the total time for
> +                       one complete cycle of active and inactive
> +                       testing periods. Default is 30 minutes.
> +
> +       rcutorture.gpwrap_lag_active_mins= [KNL]
> +                       Set the duration for which gpwrap lag is active
> +                       within each cycle, in minutes. During this time,
> +                       the grace-period wrap lag will be set to the
> +                       value specified by gpwrap_lag_gps. Default is
> +                       5 minutes.
> +
> 
> 
> Will push this to my rcu/torture-for-6.16 and also update my rcu/for-next branch.
> 
>  - Joel
> 
> 
