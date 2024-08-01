Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF091B9B3A
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534970; cv=none; b=Q7sfEVlCbm5hph8usJDBrMEy0XuSp9vDOt0lcql6BoeEif9B8v8AuoSVN2/P907rDHBxdAextGDsZFFbS5WZEDoc6Ni/ORtvdKYVNFjp3Z+emZhmOCK3NzpSCuaN6xEFrHKSPINFwMn5UUnLr0m5gHSy3Nu3oeB1rjesYzonDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534970; c=relaxed/simple;
	bh=QFv8Y0Ke2Hbg615WA+ez1Jq4nhGm4J5VDw1Ug0c5kZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwQGLaIRMBHaoCjQWbsZ6RTsqGU95GeXfYxHeTx+NL7ppPvxoaCS+5l7rGRqwbVpo4z+DeRvM7tVlvEgPBYuVZbqzMrWhiyQOcxgWgKt7aJcnNM6gqcldRvB4P5sSiAFMT16jtFUNSlX3Nza2tbSXPnxNgZKOxFHplYjv9wBuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIrUsgC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIrUsgC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A46C4AF11;
	Thu,  1 Aug 2024 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722534970;
	bh=QFv8Y0Ke2Hbg615WA+ez1Jq4nhGm4J5VDw1Ug0c5kZ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rIrUsgC+Y9LpYWJP6OKRyWH78B5qrouG0Zj5RTdqScNfRmVqIYSbp4McM6ov3UfX4
	 4sW11vkPemMSjhjk0rmGXWWuG6rQ+UxUhXQiBlFbOckKgR3gMhZi+7icKtMyA/vW/D
	 Iyd7X3IhUKJzbMEhU4P7EIY14I8R8PrlvV6MTLUXpxJj0sbOppDq75bNUz/Jd3oY0L
	 Q6dVrNDG0cbqNvQPD9Tjg205Jm+B0Lfcyng+awy/2dlpV0bQNGzAPfJfZT7txlMMW9
	 KK9W9Px4sVTM9BUq52TeaaF98POshnkW95BWx3HSlFrF9NJASZgvmXg0hejaPCtb3F
	 Fea3cAigmSlQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC41FCE08A5; Thu,  1 Aug 2024 10:56:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:56:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>

On Thu, Aug 01, 2024 at 01:34:21PM -0400, Olivier Langlois wrote:
> On Thu, 2024-08-01 at 12:32 -0400, Olivier Langlois wrote:
> > > 
> > > This is the kthread that invokes the callbacks for CPU 1, assuming
> > > you
> > > have a non-preemptible kernel (otherwise rcuop/1 for historical
> > > reasons
> > > that seemed like a good idea at the time).  Do you also have an
> > > rcuos/2?
> > > (See the help text for CONFIG_RCU_NOCB_CPU.)
> > 
> > yes I do.
> > 
> > $ ps -eo pid,cpuid,comm | grep rcu
> >       4     0 kworker/R-rcu_gp
> >       8     0 kworker/0:0-rcu_gp
> >      14     0 rcu_tasks_rude_kthread
> >      15     0 rcu_tasks_trace_kthread
> >      17     3 rcu_sched
> >      18     3 rcuog/0
> >      19     0 rcuos/0
> >      20     0 rcu_exp_par_gp_kthread_worker/0
> >      21     3 rcu_exp_gp_kthread_worker
> >      31     3 rcuos/1
> >      38     3 rcuog/2
> >      39     3 rcuos/2
> >      46     0 rcuos/3
> > 
> > and yes my kernel is built without CONFIG_PREEMPT. Since my system
> > consists of 3 isolated cpus out of 4, I have figured that there was
> > not
> > much to preempt for the overhead coming along with the feature.
> > 
> > but here again, I am thankful for the cue... If all else fail,
> > running
> > the setup with CONFIG_PREEMPT enabled to see if it change anything,
> > this might be something interesting to try.
> 
> I have just set rcutree.rcu_nocb_gp_stride=4.
> 
> $ ps -eo pid,cpuid,comm | grep rcu
>       4     0 kworker/R-rcu_gp
>       8     0 kworker/0:0-rcu_gp
>      14     0 rcu_tasks_rude_kthread
>      15     0 rcu_tasks_trace_kthread
>      17     3 rcu_sched
>      18     3 rcuog/0
>      19     0 rcuos/0
>      20     0 rcu_exp_par_gp_kthread_worker/0
>      21     3 rcu_exp_gp_kthread_worker
>      31     3 rcuos/1
>      38     0 rcuos/2
>      45     0 rcuos/3
> 
> this different setting did not eliminate the sporadic IWI and LOC
> interrupts on CPU1
> 
> I think that I have misunderstood the explanation about the RCU kthread
> groups. I thought that this setting would add a rcuog process for CPU1.

This presentation might be helpful:

	https://www.youtube.com/watch?v=5yTf7u5J_kc

> you didn't seem concerned that rcuog was missing for cpu1.
> rcutree.rcu_nocb_gp_stride sets the group size (stride) and there is 1
> rcuog per group. I guess if I wanted to see a rcuog/1, I would need to
> set rcutree.rcu_nocb_gp_stride=1

The grace-period functions of the lead rcuos kthreads have been pushed
off into a smaller number of rcuog kthreads.  Which is why you do not
(repeat, *not*) have an rcuog kthread for each CPU.

> it is probably not best possible setting but it is easy and simple to
> try out to see if it fix my problem.

You probably do not want an rcuog kthread for each CPU, but it cannot
hurt to try it.

							Thanx, Paul
