Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996653A9603;
	Fri,  6 Mar 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809925; cv=none; b=IsByUoqmWNgBwd0F2EaNUatAgaebuwikcGmv8ewJXA0rutIKydrDBmXjfrknbFVtC07I/Gs1eRwUNe+JzySjuu7Kym7MPGQsOjTvcf16nEIp6luRHdmRVgqRZcXfLPylU977JoiP6vYHFT5mgLLE257lZMCh2vJIXKf1wS4TZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809925; c=relaxed/simple;
	bh=WwutwLYkNqMgYr85DYyu7UXdAyTvO1cCqDjQc1hUNWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqsxpVhl6kWlf9P946WGo0b0C7atr6HovHCzqMVLA4LsIpMJ8iH33AiWH4shhPwJDU8LcnOPhlM5JI9kHV0P9pPV4xIO1jZU2Vm+UiELBqsVUZFC6fkx5Qfn7m5hqK3xe7+JSFZ/8z8IYweY/IeUzi0O3DTKdTjrYpblwSmJTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4yvnZtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4yvnZtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0B6C2BC9E;
	Fri,  6 Mar 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809925;
	bh=WwutwLYkNqMgYr85DYyu7UXdAyTvO1cCqDjQc1hUNWM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h4yvnZtjsCZtx0s0O7R/iH8mhJRKZGkRZ/h1iQH7FOmBMGn06eR06iE9EpkJkMcf4
	 2fxdS1l66Yli83V/D018dNLgjARu3bahibTlFa52g0EkNfYrdf5YedO15wY8Nu7PpX
	 VSzE0yp3WEuvXuKewiIkfA4U3UFQ1Tn+TkxtQAFC1iv5R8PK8DA0E8qJ4LrGLjlHPt
	 6QlJCFSsSYaWkSC+HpZW6G/tXRMZNYxOmTApeT5ZfOPtyiMNIML+Zue6e836YT5Rer
	 xO9vpY6kyAx9WRe4xPKFLaf9J24y2TDlrJg+2yvrjm8+EC06cEHC6VXhXeOEj+dJFI
	 fHzY2InL9Nbiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72379CE0992; Fri,  6 Mar 2026 07:12:04 -0800 (PST)
Date: Fri, 6 Mar 2026 07:12:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Samir M <samir@linux.ibm.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	peterz@infradead.org, aboorvad@linux.ibm.com, boqun.feng@gmail.com,
	frederic@kernel.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, rostedt@goodmis.org, srikar@linux.ibm.com,
	sshegde@linux.ibm.com, tglx@linutronix.de, urezki@gmail.com
Subject: Re: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
Message-ID: <bde1a8b9-7f56-45fb-830c-038fa7b85f0d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-6-vishalc@linux.ibm.com>
 <20260227011352.GA1089964@joelbox2>
 <94b3284b-885d-4263-99ed-728375c1a2b7@linux.ibm.com>
 <aapprY-prH0l_WeK@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aapprY-prH0l_WeK@linux.ibm.com>

On Fri, Mar 06, 2026 at 11:14:13AM +0530, Vishal Chourasia wrote:
> On Mon, Mar 02, 2026 at 05:17:16PM +0530, Samir M wrote:
> > 
> > On 27/02/26 6:43 am, Joel Fernandes wrote:
> > > On Wed, Feb 18, 2026 at 02:09:18PM +0530, Vishal Chourasia wrote:
> > > > Expedite synchronize_rcu during the SMT mode switch operation when
> > > > initiated via /sys/devices/system/cpu/smt/control interface
> > > >
> > > After the locking related changes in patch 1, is expediting still required? I
> Yes.
> > > am just a bit concerned that we are papering over the real issue of over
> > > usage of synchronize_rcu() (which IIRC we discussed in earlier versions of
> > > the patches that reducing the number of lock acquire/release was supposed to
> > > help.)
> At present, I am not sure about the underlying issue. So far what I have
> found is when synchronize_rcu() is invoked, it marks the start of a new
> grace period number, say A. Thread invoking synchronize_rcu() blocks
> until all CPUs have reported QS for GP "A". There is a rcu grace period
> kthread that runs periodically looping over a CPU list to figure out all
> CPUs have reported QS. In the trace, I find some CPUs reporting QS for
> sequence number way back in the past for ex. A - N where N is > 10.

This can happen when a CPU goes idle for multiple grace periods, then
wakes up in the middle of a later grace period.  This is (or at least is
supposed to be) harmless because a quiescent state was reported on that
CPU's behalf when RCU noticed that it was idle.  The report is quashed
when RCU notices that the quiescent state being reported is for a grace
period that has already completed.  Grace-period counter wrap is handled
by the infamous ->gpwrap field in the rcu_data structure.

I have seen N having four digits, with deep embedded devices being most
likely to have extremely large values of N.

							Thanx, Paul

> > > Could you provide more justification of why expediting these sections is
> > > required if the locking concerns were addressed? It would be great if you can
> > > provide performance numbers with only the first patch and without the second
> > > patch. That way we can quantify this patch.
> > > 
> > > 
> > SMT Mode    | Without Patch(Base) | both patch applied | % Improvement  |
> > ------------------------------------------------------------------------|
> > SMT=off     | 16m 13.956s         |     6m 18.435s     |  +61.14 %      |
> > SMT=on      | 12m 0.982s          |     5m 59.576s     |  +50.10 %      |
> > 
> > When I tested the below patch independently, I did not observe any
> > improvements for either smt=on or smt=off. However, in the smt=off scenario,
> > I encountered hung task splats (with call traces), where some threads were
> > blocked on cpus_read_lock. Please also refer to the attached call trace
> > below.
> > Patch 1:
> > https://lore.kernel.org/all/20260218083915.660252-4-vishalc@linux.ibm.com/
> > 
> > SMT Mode    | Without Patch(Base) | just patch 1 applied   | % Improvement 
> > |
> > ----------------------------------------------------------------------------|
> > SMT=off     | 16m 13.956s         |     16m 9.793s         |  +0.43 %     
> >  |
> > SMT=on      | 12m 0.982s          |     12m 19.494s        |  -2.57 %     
> >  |
> > 
> > 
> > Call traces:
> > 12377] [  T8746]    Tainted: G      E 7.0.0-rc1-150700.51-default-dirty #1
> > [ 1477.612384] [  T8746] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [ 1477.612389] [  T8746] task:systemd     state:D stack:0   pid:1  tgid:1 
> >  ppid:0   task_flags:0x400100 flags:0x00040000
> > [ 1477.612397] [  T8746] Call Trace:
> > [ 1477.612399] [  T8746] [c00000000cc0f4f0] [0000000000100000] 0x100000
> > (unreliable)
> > [ 1477.612416] [  T8746] [c00000000cc0f6a0] [c00000000001fe5c]
> > __switch_to+0x1dc/0x290
> > [ 1477.612425] [  T8746] [c00000000cc0f6f0] [c0000000012598ac]
> > __schedule+0x40c/0x1a70
> > [ 1477.612433] [  T8746] [c00000000cc0f840] [c00000000125af58]
> > schedule+0x48/0x1a0
> > [ 1477.612439] [  T8746] [c00000000cc0f870] [c0000000002e27b8]
> > percpu_rwsem_wait+0x198/0x200
> > [ 1477.612445] [  T8746] [c00000000cc0f8f0] [c000000001262930]
> > __percpu_down_read+0xb0/0x210
> > [ 1477.612449] [  T8746] [c00000000cc0f930] [c00000000022f400]
> > cpus_read_lock+0xc0/0xd0
> > [ 1477.612456] [  T8746] [c00000000cc0f950] [c0000000003a6398]
> > cgroup_procs_write_start+0x328/0x410
> > [ 1477.612462] [  T8746] [c00000000cc0fa00] [c0000000003a9620]
> > __cgroup_procs_write+0x70/0x2c0
> > [ 1477.612468] [  T8746] [c00000000cc0fac0] [c0000000003a98e8]
> > cgroup_procs_write+0x28/0x50
> > [ 1477.612473] [  T8746] [c00000000cc0faf0] [c0000000003a1624]
> > cgroup_file_write+0xb4/0x240
> > [ 1477.612478] [  T8746] [c00000000cc0fb50] [c000000000853ba8]
> > kernfs_fop_write_iter+0x1a8/0x2a0
> > [ 1477.612485] [  T8746] [c00000000cc0fba0] [c000000000733d5c]
> > vfs_write+0x27c/0x540
> > [ 1477.612491] [  T8746] [c00000000cc0fc50] [c000000000734350]
> > ksys_write+0x80/0x150
> > [ 1477.612495] [  T8746] [c00000000cc0fca0] [c000000000032898]
> > system_call_exception+0x148/0x320
> > [ 1477.612500] [  T8746] [c00000000cc0fe50] [c00000000000d6a0]
> > system_call_common+0x160/0x2c4
> > [ 1477.612506] [  T8746] ---- interrupt: c00 at 0x7fffa8f73df4
> > [ 1477.612509] [  T8746] NIP: 00007fffa8f73df4 LR: 00007fffa8eb6144 CTR:
> > 0000000000000000
> > [ 1477.612512] [  T8746] REGS: c00000000cc0fe80 TRAP: 0c00 Tainted: G     
> > E    (7.0.0-rc1-150700.51-default-dirty)
> > [ 1477.612515] [  T8746] MSR: 800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE> CR:
> > 28002288 XER: 00000000
> > 
> > 
> 
> Default timeout is set to 8 mins.
> 
> $ grep . /proc/sys/kernel/hung_task_timeout_secs
> /proc/sys/kernel/hung_task_timeout_secs:480
> 
> Now that cpus_write_lock is taken once, and SMT mode switch can take
> tens of minutes to complete and relinquish the lock, threads waiting on 
> cpus_read_lock will be blocked for this entire duration.
> 
> Although there were no splats observed for "both patch applied" case
> the issue still remains.
> 
> regards,
> vishal
