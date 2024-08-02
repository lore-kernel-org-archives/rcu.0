Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E391ABEB5
	for <rcu@vger.kernel.org>; Fri,  2 Aug 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643032; cv=none; b=nd/doNKDyqq8cTv6sDOtCxdr6wtsqu15VVOESMdv4RxbiknceMOGptZPOT1q2cU44iGlze2tlF4EX5+wgDvikbfXp5cgF40YoNmLy3VxkwRP/ze4U1rB+LAOHmdxKGk/BxOSTh26h+qss0vrWjPruZwB6Wsf5w6Yoqynnn/syrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643032; c=relaxed/simple;
	bh=EkLEiXkrP+cMleBVnBGxuDln80/CnERfS+C1yvwEdnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ45cR1QAGbleeoeuLH53yOwEtdYp61KGUpOY3c5eL0yD7tiv2FgsAD9W2stmR1UGFOEf5vmVCxc0oReZLRwfUG0D4pSvjE31dXkQAV6SxrZKZECdCfNyJUfk7zcdIAaTLCJJr3HsIxcQN+aTQCk/Y+arB/ZoB94GjofI41dOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKMaOENF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKMaOENF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E89C32782;
	Fri,  2 Aug 2024 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722643031;
	bh=EkLEiXkrP+cMleBVnBGxuDln80/CnERfS+C1yvwEdnQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XKMaOENFkDRf4UxOcFtjZzzp1AKq40nuzWzYRk8E7F6DrreAKlglq/Gdcr+7Qw/KS
	 Ij4k4iL/kTHT89k860Lk8YXNalHY3CAaM3c2zLVPDY9mARr1vZ7mpidyhP8k5NBtQJ
	 chhwBJTh9kbMHRxhsJbYCpnMRBmsyGLy2WCk4rUNpeUzczSHHUyZKfAwCpXg4YsiMo
	 btIlN+TRFHGTdhZBjq/A+mKa8W939dd1BAdlocQmEIrMhix3xt1QERQdpt6dCpnfbb
	 TpKDpPtITwVyabn6wDFVb4W8EF0Gfpr3cALNuEfXUDI1l8ekGwxCjrjjZhQ0IvpkhZ
	 PnXhXFbSB7ptA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 82573CE08FF; Fri,  2 Aug 2024 16:57:11 -0700 (PDT)
Date: Fri, 2 Aug 2024 16:57:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <2b9f8637-2d91-4981-980f-87e4aeb4c1b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
 <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
 <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>
 <383ce0ce-fe27-46a5-ac1e-2dd2ea2be4fe@paulmck-laptop>
 <a38775aa4f97b50844e482ab05a51b13a8f11aa5.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a38775aa4f97b50844e482ab05a51b13a8f11aa5.camel@trillion01.com>

On Fri, Aug 02, 2024 at 11:36:22AM -0400, Olivier Langlois wrote:
> On Fri, 2024-08-02 at 06:58 -0700, Paul E. McKenney wrote:
> > On Fri, Aug 02, 2024 at 09:46:03AM -0400, Olivier Langlois wrote:
> > > On Thu, 2024-08-01 at 20:01 -0700, Paul E. McKenney wrote:
> > > > 
> > > > Very good!!!
> > > > 
> > > > The do_nocb_deferred_wakeup_timer() is due to call_rcu() being
> > > > invoked
> > > > in a context where it might not be safe to do a wakeup().  RCU
> > > > doesn't
> > > > have a lot of choice in this situation, so the usual approach is
> > > > to
> > > > figure out what is invoking call_rcu() on your nohz_full CPUs and
> > > > to
> > > > make it run elsewhere.
> > > > 
> > > > I don't know what is happening with mix_interrupt_randomness().
> > > > 
> > > > 							Thanx,
> > > > Paul
> > > there few more that are popping out like:
> > > 
> > > tsc_sync_check_timer_fn
> > > mce_timer_fn
> > > 
> > > but those 2 + do_nocb_deferred_wakeup_timer are not immediately
> > > generating an interrupt. Only mix_interrupt_randomness does because
> > > it
> > > adds an already timed out timer. So the CPU is kicked on insertion.
> > > 
> > > I have quickly looked at drivers/char/random.c
> > > 
> > > and there is no obvious way to address this that I can think of
> > > without
> > > causing potential serious side-effects...
> > > 
> > > but I really find mysterious that only 1 of my nohz_full cpus is
> > > impacted this...
> > > 
> > > and imho, this does not sound like a good idea to include interrupt
> > > randomness of a nohz_full cpu...
> > > 
> > > I think that I am going to throw down the towel of reaching the
> > > goal of
> > > 100% interrupt free for now. The amount of efforts required to
> > > reach
> > > the goal vs the diminishing result I can get is not a good deal.
> > > For
> > > now, I am going to tolerate this 27uSec interrupt once every 2-3
> > > seconds...
> > > 
> > > but I find this challenge very fascinating and I'll start to follow
> > > Brendan Gregg's blog to learn more about the field.
> > > 
> > > thank you very much for your assistance. I am leaving with an
> > > impression that the rcu dev list is very helpful and friendly!
> > 
> > Are you doing system calls on your worker CPUs?  If so, one
> > straightforward way to get rid of this is to make your application
> > push
> > the system calls off to the housekeeping CPU.  Keep in mind that
> > system
> > calls often need to defer work of one sort or another.
> > 
> > The real-time guys would know more about this sort of thing.
> > 
> > 							Thanx, Paul
> very little.

They say that there are people who use this stuff to build real-time
applications that are used in production.

> I signal pthread condition variable
> that calls:
> 
> - gettid()
> - futex()
> 
> and madvise(MADV_DONTNEED)
> (I believe this comes from tcmalloc)
> 
> you are opening up my horizons and I think you are right. If the
> nohz_full thread does not enter the kernel, it cannot interfere with
> your nohz_full setup.

Exactly!

One approach is to have real-time threads used lockless shared-memory
mechanism to communicate asynchronously with non-real-time threads.
The Linux-kernel llist is one example of such a mechanism.

Many projects do all their allocation during initialization, thus
avoiding run-time issues from the memory allocator.  Some use memlock()
or memlockall() at initialization time to avoid page faults.

> I need to take a break from this project to take care of other stuff
> that I have neglected while being absorbed by this never-ending
> challenge... but I'll definitely return to it with this new angle of
> attack...
> 
> with the little amount of syscalls, it seems feasible to avoid them in
> one way or the other.
> 
> at some point, it might be much easier to avoid the kernel than trying
> to fight with it to do what you want it to do.

These things go on a syscall-by-syscall basis, and much depends on
your deadlines.  For example, if you had one-millisecond deadlines,
those 27-microsecond interrupts might not be a concern.  ;-)

> here is another sidenote. I am currently listening your talk about
> NO_HZ_FULL and I enjoy it very much!

Glad you like it, and thank you!

> this made me realize that you were right about the odd detail that my
> setup is having 4 rcuos... I do not understand neither why I end up
> with 4. This is your mention in your talk about CONFIG_RCU_NOCB_CPU_ALL
> (now CONFIG_RCU_NOCB_CPU_DEFAULT_ALL I believe). I thought that maybe,
> I had this define set unknowingly... no I don't
> 
> /proc $ zcat config.gz | grep RCU
> # RCU Subsystem
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_NEED_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> # CONFIG_RCU_LAZY is not set
> # end of RCU Subsystem
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> # RCU Debugging
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> # CONFIG_RCU_CPU_STALL_CPUTIME is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> 
> boot params:
> isolcpus=0,1,2 nohz_full=1,2 rcu_nocbs=1,2 rcutree.rcu_nocb_gp_stride=4
> irqaffinity=3
> 
> dmesg output:
> Aug 02 05:41:01 aws-dublin kernel: rcu: Hierarchical RCU
> implementation.
> Aug 02 05:41:01 aws-dublin kernel: rcu:         RCU restricting CPUs
> from NR_CPUS=128 to nr_cpu_ids=4.
> Aug 02 05:41:01 aws-dublin kernel: rcu: RCU calculated value of
> scheduler-enlistment delay is 10 jiffies.
> Aug 02 05:41:01 aws-dublin kernel: rcu: Adjusting geometry for
> rcu_fanout_leaf=16, nr_cpu_ids=4
> Aug 02 05:41:01 aws-dublin kernel: RCU Tasks Rude: Setting shift to 2
> and lim to 1 rcu_task_cb_adjust=1.
> Aug 02 05:41:01 aws-dublin kernel: RCU Tasks Trace: Setting shift to 2
> and lim to 1 rcu_task_cb_adjust=1.
> Aug 02 05:41:01 aws-dublin kernel: rcu:         Offload RCU callbacks
> from CPUs: 1-2.
> Aug 02 05:41:01 aws-dublin kernel: rcu: srcu_init: Setting srcu_struct
> sizes based on contention.
> Aug 02 05:41:01 aws-dublin kernel: rcu: Hierarchical SRCU
> implementation.
> Aug 02 05:41:01 aws-dublin kernel: rcu:         Max phase no-delay
> instances is 1000.
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
>      38     3 rcuos/2
>      45     0 rcuos/3
> 
> yesterday, I did hypothesize that maybe my isolcpus setting could
> explain why rcuos0 was present... but this cannot explain why rcuos/3
> is there too!
> 
> this is strange...

Frederic would know more, but I believe that these extra rcuos kthreads
are created in order to permit the rcu_nocbs status of a given CPU to
be changed at runtime.  This capability has not yet been exported to
user code, but it does exist within the kernel.  But you have to take
the CPU offline in order to change its rcu_nocbs state.

							Thanx, Paul
