Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2C1B0106
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526129; cv=none; b=SkxnG4bG1QCXP/ilDSV86nyeilRpZ0NXhJUaa1u6zAqgoOcpt3wkxR4M4KiHpEwZg6EAW4tNYTMxjSTCYIWY4TddRI/sD84jCejIZuMrTJ/WebOk9bWvYxLB9DplSMLnxV6txVHHysOWAs3cYuAGNd+rxXBag3/mKjBD7I3eM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526129; c=relaxed/simple;
	bh=yYzeQ/x/pmRvSd7sVZDbOOF7S935c2LjkrTducM5ys8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPtdsJADKrefyp40kD/zA6W4PTgXKnCcTScDYzSbiMSl7Rz6yz9rPf5f6+GLBviE4ziHAFM/ENbA4/2xKNqDtqkUqkxEwufcsqj5RI9yeP/9Bv/ZOFh+gVLuI1pMa3pAeNRc5nIFurubZ7kxyeMnCHFFRgenSyQKtDE9o6bd+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFB9JEEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFB9JEEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07C4C32786;
	Thu,  1 Aug 2024 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526128;
	bh=yYzeQ/x/pmRvSd7sVZDbOOF7S935c2LjkrTducM5ys8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KFB9JEEXDGcLFQ3Js7ihDRiPk3i3MiweyeBrvMPVO+tnctp6gYOAImez5BeiOdzyn
	 BRo8ZsmI6eNtHLoJDBd5oodu+OwL3YGT97wPQZSnAibW+kAhE+2F9n99rfcdocILSm
	 ns0mCOqUG6+SW5P/95RW2pss9b8zGPWVDHLnOOa797tFOquUT4MjMMWN75/5XKy09P
	 D/DrNXrUjPBmohlvYYtkgjwPVoYgB5FnLv/zfpSeqKKqS7hLa6VPB5jdcf2ftdgOxt
	 hyCJaox5RhbfLCD+dY/V/e1hW0686F1VoOt7WQo4KP22iTWHCB50ltRfDa9JidvKXT
	 qiK7XFpQ5O70w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 777F5CE08A5; Thu,  1 Aug 2024 08:28:48 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:28:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>

On Thu, Aug 01, 2024 at 10:52:15AM -0400, Olivier Langlois wrote:
> the initial parsing is fine...
> 
> Aug 01 14:05:51 aws-dublin kernel: rcu: Hierarchical RCU
> implementation.
> Aug 01 14:05:51 aws-dublin kernel: rcu:         RCU restricting CPUs
> from NR_CPUS=128 to nr_cpu_ids=4.
> Aug 01 14:05:51 aws-dublin kernel:         Rude variant of Tasks RCU
> enabled.
> Aug 01 14:05:51 aws-dublin kernel:         Tracing variant of Tasks RCU
> enabled.
> Aug 01 14:05:51 aws-dublin kernel: rcu: RCU calculated value of
> scheduler-enlistment delay is 10 jiffies.
> Aug 01 14:05:51 aws-dublin kernel: rcu: Adjusting geometry for
> rcu_fanout_leaf=16, nr_cpu_ids=4
> Aug 01 14:05:51 aws-dublin kernel: RCU Tasks Rude: Setting shift to 2
> and lim to 1 rcu_task_cb_adjust=1.
> Aug 01 14:05:51 aws-dublin kernel: RCU Tasks Trace: Setting shift to 2
> and lim to 1 rcu_task_cb_adjust=1.
> Aug 01 14:05:51 aws-dublin kernel: NR_IRQS: 8448, nr_irqs: 456,
> preallocated irqs: 16
> Aug 01 14:05:51 aws-dublin kernel: NO_HZ: Full dynticks CPUs: 1-2.
> Aug 01 14:05:51 aws-dublin kernel: rcu:         Offload RCU callbacks
> from CPUs: 1-2.
> Aug 01 14:05:51 aws-dublin kernel: rcu: srcu_init: Setting srcu_struct
> sizes based on contention.
> 
> On Thu, 2024-08-01 at 10:28 -0400, Olivier Langlois wrote:
> > this is with kernel 6.10.2
> > 
> > I have these options set on the boot command line:
> > isolcpus=0,1,2 nohz_full=1,2 rcu_nocbs=1,2
> > 
> > $ ps -eo pid,cpuid,comm | grep rcuog
> >      18     3 rcuog/0
> >      38     0 rcuog/2
> > 
> > I do not understand why a rcuog task is spawn for cpu0.
> > I would have expected to have one for cpu1.

These handle grace periods, each for a group of CPUs.  You should have one
rcuog kthread for each group of roughly sqrt(nr_cpu_ids) that contains at
least one offloaded CPU, in your case, sqrt(4), which is 2.  You could
use the rcutree.rcu_nocb_gp_stride kernel boot parameter to override
this default, for example, you might want rcutree.rcu_nocb_gp_stride=4
in your case.

> > I do have a
> >      31     3 rcuos/1
> > 
> > I am not familiar enough with rcu to know what rcuos is for.

This is the kthread that invokes the callbacks for CPU 1, assuming you
have a non-preemptible kernel (otherwise rcuop/1 for historical reasons
that seemed like a good idea at the time).  Do you also have an rcuos/2?
(See the help text for CONFIG_RCU_NOCB_CPU.)

> > the absence of of rcuog/1 is causing rcu_irq_work_resched() to raise
> > an
> > interrupt every 2-3 seconds on cpu1.

Did you build with CONFIG_LAZY_RCU=y?

Did you use something like taskset to confine the rcuog and rcuos
kthreads to CPUs 0 and 3 (you seem to have 4 CPUs)?

Might that interrupt be due to a call_rcu() on CPU 1?  If so, can the
work causing that call_rcu() be placed on some other CPU?

> > I am currently reading rcu/tree_nocb.h to try to make sense of what I
> > am seeing but I am pinging the rcu list just in case what I am seeing
> > would be immediately obvious to one of you...

Others might have more suggestions...

							Thanx, Paul
