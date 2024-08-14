Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD81B9B3C;
	Wed, 14 Aug 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652003; cv=none; b=eJNOOYZjBS/tstm489T7Se/IAcH49yR3M+tkZFAJPdUYuItOQpM/IpBsG1aw8LRp3SegRPS9oxKDreEwm8lEz8O0/Ic4K44q3U2g8ewHrQ6iBXzyH5a9XDeChucEi29Vvb+4/pVJ9ttHXI7Jn97vhJZVTTK4JxVyJ12ZG93DE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652003; c=relaxed/simple;
	bh=8TLQNOFxBRqk82caBG73gqzzPaLL9rUL9a4SwMQA6Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izJsGjDHG/QdSpZANtTQUhz1w4bY4mEpinHKvY5CFgS0gHksAdVvxUfP23+7LrwtBLhKffhkr5G3TaS7dhBZ5z/EoPAIx9ex2Ay+sr6GfABsdF6pFSZp00yW9BwgdaJzQ3Depyrqv4K3QMK0EeP87YuZxJasnsiqe5xL1zYchNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9LriaXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9LriaXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A98C4AF0A;
	Wed, 14 Aug 2024 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652003;
	bh=8TLQNOFxBRqk82caBG73gqzzPaLL9rUL9a4SwMQA6Lg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C9LriaXjE6UYtbLp14XkcrzQGfi8AJr7xUvFpSIj1lzFgoimVn/b60RSPHoWT9W9+
	 VE7qbxtH4E4jTsULNhFIDu9ow3vjDCHfiGHwTJl+M8kMvTZQm9N+8Bi0b5ryY67uR9
	 ktMQSHPLVE7bAmaqSE5TMkX6KlkGpn+aJH4NQsxXZwGmEfIE3b0416bq1lvx0hDfO+
	 h2nE3WmkpQ1kprrXuYnJNh55isDDPvGv4QxZ8MLpshdm95Pj408a/wOsIZ4X4MOgYC
	 uvSSIv9MDU529Mo1iSpt6UEz356h0DYU+46pXjm5m3Y5UwBxv7wcrkAk9eHrE29ieW
	 XHYXLDplp7DJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B63BCE0ACD; Wed, 14 Aug 2024 09:13:22 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:13:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH rcu 1/6] rcu/tasks: Check processor-ID assumptions
Message-ID: <af7db745-97c6-467d-9ed2-798ef8b686ba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
 <20240802003426.4134196-1-paulmck@kernel.org>
 <20240814121654.GA1412801@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121654.GA1412801@neeraj.linux>

On Wed, Aug 14, 2024 at 05:46:54PM +0530, Neeraj Upadhyay wrote:
> Hi Paul,
> 
> On Thu, Aug 01, 2024 at 05:34:21PM -0700, Paul E. McKenney wrote:
> > The current mapping of smp_processor_id() to a CPU processing Tasks-RCU
> > callbacks makes some assumptions about layout.  This commit therefore
> > adds a WARN_ON() to check these assumptions.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tasks.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index b6fcf744af75d..d473846a572aa 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -355,6 +355,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >  	rcu_read_lock();
> >  	ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
> >  	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
> > +	WARN_ON_ONCE(chosen_cpu >= nr_cpu_ids);
> 
> I have changed this s/nr_cpu_ids/rcu_task_cpu_ids/ , as there is a
> another commit 	fd70e9f1d85f "rcu-tasks: Fix access non-existent percpu
> rtpcp variable in rcu_tasks_need_gpcb()" which is included in the tree
> here [1]. Please let me know if something looks incorrect.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=next.14.08.24a

Good catch, looks good, and thank you!

							Thanx, Paul

> - Neeraj
> 
> >  	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
> >  	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
> >  		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
> > -- 
> > 2.40.1
> > 
