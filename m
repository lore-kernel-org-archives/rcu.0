Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27E1B9B32
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534499; cv=none; b=uyh5lu7kebN2+Fx+NSTgtS0CE0Osx46zhG0YHXRglq2GUIgJ49xV5g3KEnAGEiXXaXrHMGq22EIH5GM3XlWqid7mz6WpsqD19Dz6FP+hdQUm2F599m033KhnqyW7PLmB6W3KimOmi4sVG2jwR+CHdLt7J3eB5KqYaS8sSdsZRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534499; c=relaxed/simple;
	bh=wCcTY3PadjE02iojgpJ3us0hBoMDhEMjF0GIcw/2w2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2eYzt7SRSl7v+CD6rsTPcqAKNuNoz2JVZlR2g9he3lhR750HaTHLgJzscfbR+ANHL7vfJgmxuKG22rN/RRMNHg+WffAbpgrgNhLdHJOpu3hX+rxqltSAUSxaCzx7UBUzQJoKDi4JP/SDkoALiAfuWdNb8959tkXOpdkVTjE+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1RjTqnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1RjTqnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18ABC32786;
	Thu,  1 Aug 2024 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722534498;
	bh=wCcTY3PadjE02iojgpJ3us0hBoMDhEMjF0GIcw/2w2k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A1RjTqnY8GbwFw7spOGn+07+yghRSxgeA9yFVNCmrws/p7TGO/VPeKJyVLnGVoH6t
	 QEBKdMaUSg7YJTrEb0xKjOagEH6pKlM8g2Rm+BiChOogGxoGFUIghnU7ya6wl0FjGA
	 qayD2gJR3oWSobI6aED3Cug+xwojqt28za+nOQfW8ojCNcAaGxbFqvIpmYN1a/oJYM
	 btkbSalbgP8hZ0SWh3ZMAuLXusmcoSrwuliVw59YlVevtmXfe/iz1CGp5giVb2+W9w
	 264rzHIsYZFzEUP6muMVArCmEVaDfH9NsEnKQZwMcOPYAlGQNwzR0FD/jCBnLeEQnW
	 a+KVCxDa9KNgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46661CE08A5; Thu,  1 Aug 2024 10:48:18 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:48:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <fd5cedd3-d956-4a99-a50f-1fbc14fa208b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>

On Thu, Aug 01, 2024 at 12:32:52PM -0400, Olivier Langlois wrote:
> On Thu, 2024-08-01 at 08:28 -0700, Paul E. McKenney wrote:
> > These handle grace periods, each for a group of CPUs.  You should
> > have one
> > rcuog kthread for each group of roughly sqrt(nr_cpu_ids) that
> > contains at
> > least one offloaded CPU, in your case, sqrt(4), which is 2.  You
> > could
> > use the rcutree.rcu_nocb_gp_stride kernel boot parameter to override
> > this default, for example, you might want
> > rcutree.rcu_nocb_gp_stride=4
> > in your case.
> 
> oh, thanks. I will look into it to see it change anything to my
> situation and if it does, I will report it back here.
> 
> with your explanation, it makes more sense what I am seeing.
> 
> > > > I do have a
> > > >      31     3 rcuos/1
> > > > 
> > > > I am not familiar enough with rcu to know what rcuos is for.
> > 
> > This is the kthread that invokes the callbacks for CPU 1, assuming
> > you
> > have a non-preemptible kernel (otherwise rcuop/1 for historical
> > reasons
> > that seemed like a good idea at the time).  Do you also have an
> > rcuos/2?
> > (See the help text for CONFIG_RCU_NOCB_CPU.)
> 
> yes I do.
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
>      38     3 rcuog/2
>      39     3 rcuos/2
>      46     0 rcuos/3

This looks like you had either nohz_full=0-3 or rcu_nocbs=0-3, given
that you have rcuos kthreads for all four of your CPUs.  Or perhaps some
other setting that implied one or the other of these.

> and yes my kernel is built without CONFIG_PREEMPT. Since my system
> consists of 3 isolated cpus out of 4, I have figured that there was not
> much to preempt for the overhead coming along with the feature.
> 
> but here again, I am thankful for the cue... If all else fail, running
> the setup with CONFIG_PREEMPT enabled to see if it change anything,
> this might be something interesting to try.

To be honest, I am not sure that CONFIG_PREEMPT will help.  I was just
checking my understanding of your setup.  But it cannot hurt to try it.

> > > > the absence of of rcuog/1 is causing rcu_irq_work_resched() to
> > > > raise
> > > > an
> > > > interrupt every 2-3 seconds on cpu1.
> > 
> > Did you build with CONFIG_LAZY_RCU=y?
> 
> no. I was not even aware that it was existing. I left alone the default
> setting!

Worth a try, as this is what it is designed for.

> > Did you use something like taskset to confine the rcuog and rcuos
> > kthreads to CPUs 0 and 3 (you seem to have 4 CPUs)?
> 
> I have:
> tuna move -t rcu* -c 3
> 
> in some bash script launched at startup by systemctl.
> 
> I was a bit suspicious to some of these kernel threads still on CPU0...
> 
> I did try to move them manually with taskset ie:
> 
> 19     0 rcuos/0
> 
> $ sudo taskset -pc 3 19
> pid 19's current affinity list: 3
> pid 19's new affinity list: 3
> 
> so it appears that tuna does its job correctly. I guess that the
> setting is effective only when the scheduler has something to do with
> that task.

OK.

> > Might that interrupt be due to a call_rcu() on CPU 1?  If so, can the
> > work causing that call_rcu() be placed on some other CPU?
> > > > 
> I am really shooting in the dark with this glitch. I don't know for
> sure how to find out where these interrupts are originating from.
> 
> 2 threads from the same process are assigned to cpu1 and cpu2.
> 
> It is very satisfying to see zero interrupts occuring on cpu2!
> I have been struggling very hard for about a week to reach this state.
> 
> I have tried to find out what could be happening on cpu1 to see the IWI
> and LOC counts slowly grow on CPU1...
> 
> the only task running on CPU1 is my thread. I have enabled
> /sys/kernel/tracing/events/syscalls
> 
> the only 3 syscalls happening on this cpu are:
> 1. gettid()
> 2. futex()
> 
> from a glibc pthread_mutex used with a pthread_cond
> 
> 3. madvise(MADV_DONTNEED)
> (from tcmalloc, I think. I am even not sure if madvise(MADV_DONTNEED)
> can trigger RCU. some part of mm do but I could not tell if this
> specific call could)
> 
> all the memory allocation, I think is coming from openssl processing
> about 20 TCP data streams. (Network I/O is done on cpu0)
> 
> beside that, I use clock_gettime() to benchmark the execution time of a
> function of mine but it does not show up in the syscalls trace. I guess
> this has something to do with vDSO.
> 
> here are my measurements (in nanosecs):
> 
> avg:125.080, max:27188
> 
> The function is simple. A C++ virtual function + a 16 bytes
> Boost::atomic::load(std::memory_order::acquire) that is alone on a
> cacheline to avoid any chance of false sharing.
> (Boost support DWCAS. gcc std::atomic does not)
> 
> I think that the 27uSec monstruosity is because of those pesky
> interrupts... 

It is also worth using something like ftrace or bpftrace to trace
down what is instigating that extra interrupt, if you have not already
done so.  (Brendan Gregg's blog and other publications is a great source
of information on doing this sort of thing.)

There are also quite a few people who are much more experienced and
knowlegeable about reducing unwanted activity on worker CPUs than I am.
RCU I can help you with, usually, anyway.  ;-)

							Thanx, Paul
