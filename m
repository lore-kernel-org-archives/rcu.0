Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1F2F2C6C;
	Fri, 11 Jul 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259273; cv=none; b=OzCBhtbZwBuyvgoAeZDip175YMTsQ83BEX//yl55PkJAioO+0GWzm8fLOfMKD6KpCk1fN9Ac8VjfNqugAEbODRdverXBITnjjwRJRv2lYrCepPfHM2bqOTqTWkwkUEd33OU3A/9XE9eBawXZymRazjN0xdq8PfwjseaDqHoUwXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259273; c=relaxed/simple;
	bh=WXHDkLxeBuUVPCGJg8eX8a1HjZWeMU13tn+M9FkD3eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqesMcfPcBackJfbHS3+v1kKLMG3CJLexSViA+Z+4hvYFwjDu2hdVvH1VVBbFS7vEVUOg2N9eVPvM+IAfGOsZilfPX8q4sKFm/rWSUL8MctQRl23uLnesDMZFHVOJ5fdRA4znRT/UUMehzv8W+A5Jn+IQf6VhOcDa4BlMFkhxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnDhrpue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnDhrpue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A0EC4CEED;
	Fri, 11 Jul 2025 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752259272;
	bh=WXHDkLxeBuUVPCGJg8eX8a1HjZWeMU13tn+M9FkD3eo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gnDhrpuemNSedot6Jm1hktyNQyYCoq++bcczEbVwwp9HaGp/+XqbLTimn1p1Rkfzs
	 iRVXvl+HCtvokDTjW7H5poutg07x9VKAkGxVkPc/xX/11OalLxgQFrDlfmoBD1Coeg
	 Qq3U9LLsX3D98y/t5SSifrnrCZLOY6+mE8Xyx64/ByGduR2IC9v4WJSWiaIlwvwbaq
	 +Eb3vyAabcpcLxR32I1DHulQi/qv2K1zCOn7y6220zwfUrJmUCfWdaD8QFEe+ANtWx
	 BI4i49mu5luqZfknDIU65Qi7cacXJzEe3OR+FJTpOIRJXAIUm6szDizMYUanu7xS5W
	 iYcqG0Y7ZglSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59982CE0CB7; Fri, 11 Jul 2025 11:41:12 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:41:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state
 during unlock
Message-ID: <6400b843-33b7-44fe-97dc-7a8c737ac6cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-4-joelagnelf@nvidia.com>
 <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
 <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>
 <c25c1084-ef70-409b-b38f-84c69e08e562@paulmck-laptop>
 <3d1217a9-2d22-4808-adca-0fdf78278a36@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1217a9-2d22-4808-adca-0fdf78278a36@nvidia.com>

On Fri, Jul 11, 2025 at 02:19:47PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/11/2025 1:18 PM, Paul E. McKenney wrote:
> > On Fri, Jul 11, 2025 at 12:30:08PM -0400, Joel Fernandes wrote:
> >>
> >>
> >> On 7/10/2025 8:00 PM, Paul E. McKenney wrote:
> >>> On Tue, Jul 08, 2025 at 10:22:21AM -0400, Joel Fernandes wrote:
> >>>> The check for irqs_were_disabled is redundant in
> >>>> rcu_unlock_needs_exp_handling() as the caller already checks for this.
> >>>> This includes the boost case as well. Just remove the redundant check.
> >>>
> >>> But in the very last "if" statement in the context of the last hunk of
> >>> this patch, isn't it instead checking for !irqs_were_disabled?
> >>>
> >>> Or is there something that I am missing that makes this work out OK?
> >>
> >> You are right, after going over all the cases I introduced a behavioral change.
> >>
> >> Say, irqs_were_disabled was false. And say we are RCU-boosted. needs_exp might
> >> return true now, but previously it was returning false. Further say, we are not
> >> in hardirq.
> >>
> >> New code will raise softirq, old code would go to the ELSE and just set:
> >>                 set_tsk_need_resched(current);
> >> set_preempt_need_resched();
> >>
> >> But preempt_bh_were_disabled that's why we're here.
> >>
> >> So we need to only set resched and not raise softirq, because the preempt enable
> >> would reschedule.
> >>
> >> Sorry I missed this, but unless this behavior is correct or needs further work,
> >> lets drop this patch. Thanks and kudos on the catch!
> > 
> > Not a problem!
> > 
> > You can use cbmc to check these sorts of transformations, as described
> > here: https://paulmck.livejournal.com/38997.html
> 
> Much appreciated! Does the tool automatically create stubs for dependent
> structures or is that upto the CBMC user? I see in your example in the blog you
> did create an rcu_node :). I wonder if for large number of dependencies on the
> code base, how it does in terms of overhead for the user.

You do need to create the stubs.  But you also have the option of
simplifying the code, for example, by removing structure fields that
you are not using and providing static instances of the needed structures.

> But perhaps for simpler examples (such as perhaps the above), manually mocking
> data structures and dependent code is reasonable?

That is what I do.  ;-)

> We'd have to stub irq_work and raise_softirq and functions too and also the
> CONFIG option values.

Agreed.  But in this case, we only need to know whether or not they
were called, so a very simple stub suffices.

You can also speed things up by replacing the Kconfig options with
variables, thus allowing full exploration in one run.  And dispensing
with the dazzling implementation of IS_ENABLED().  ;-)

							Thanx, Paul
