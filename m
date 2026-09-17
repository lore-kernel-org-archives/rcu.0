Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B428852E;
	Thu, 17 Sep 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647324; cv=none; b=MSonWrA+McsGVR/doXoUcJ0yMWjdArmTcen8VciYHoKzzibf4earZ3sZZCnnL4VgeWeiF4ilnfgcMelEMcO2LjyQXdcUBFuU2i3f/SWVaUvKVquL5sccZe4dvKfv7sY4DzM2iNS8YbVy3Y9zNGZYIjlZl8/vOeECBieoGD/N+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647324; c=relaxed/simple;
	bh=GvcoigiTjAsLsFHBu6fI/64YO0irYpJt4M1oZl+sTAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmA9SzXnn6VxtiADdR4Nu16orHKQJ3ZYHzjDYuO+tv49LVF4LRuFF7wxiijUYDT6b243Mie4WylWVjDkdcVUDK5QJpEETca8Oj7Ai8JqifFoHu5MG0q4zOxatq7PLs8MK4Z7+9iM3+DP+M+4midlY0mMO41aAESpicWEdpyxlec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9x6i3Wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9x6i3Wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894761F00893;
	Thu, 17 Sep 2026 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789647301;
	bh=gkbPrcWx7naDFzx6es9+fglMGRB1RD3y/GInwlzOxG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l9x6i3WuvpeAcNcSCVNaCtMy5SaRo1F+MZuI+PgVBSML9X+5R+oQzomOBe+PerxoF
	 MGnUJJPBiBDo05wMQ6X2KJcxdTZENp23PzB7WcnSwSqj62YzmxsyGgJ7HZBIPXjfEF
	 E8dIJpEOvURwajkhYJ8tZHYQ6DR7NoU4HbmBYBXiWsOXfSshDWbFnC/MWHjo/l6SjU
	 kyARmxn8MXXrjxfSzwNY5oyHwnrB7W7LX+V0sI6oGEFdrpZUh+ZlK2RgUPaDlHkss4
	 ui9Wsp50EnRuS0GxbBmgweTiv/MsHviRvjcYoGFHOH38WcDLv/iZ2YR+oN+hK1zE4l
	 XEyjqlwBekiag==
Date: Thu, 17 Sep 2026 14:14:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Message-ID: <aqvZwfUVsiEI7q7y@localhost.localdomain>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com>
 <aqlgxKGk_AEKls_1@localhost.localdomain>
 <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop>
 <aqqONH8flTIpOUqT@localhost.localdomain>
 <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>
 <aqqpRoTfywUuTgoC@localhost.localdomain>
 <aqqsAUVV8a1yrQzX@localhost.localdomain>
 <6afb0afe-e7b8-46b4-9fea-2c7cf4791044@paulmck-laptop>
 <aqq0cwvRDsorGwgc@localhost.localdomain>
 <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop>

Le Wed, Sep 16, 2026 at 08:41:36AM -0700, Paul E. McKenney a écrit :
> On Wed, Sep 16, 2026 at 05:23:31PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Sep 16, 2026 at 07:55:02AM -0700, Paul E. McKenney a écrit :
> > > Perhaps in rcu_core() in kernels booted with use_softirq?  I am thinking
> > > specifically of the checks for deferred quiescent states.  I don't (yet)
> > > see a need to modify rcu_check_quiescent_state().
> > > 
> > > Maybe other places as well.  ;-)
> > 
> > Hmm this tracking would have to happen on preempt_schedule() just like we
> > do for PREEMPT_RCU. Or am I missing something? And then we would need a
> > list scan of those tasks.
> 
> I am thinking of the case where a trampoline is interrupted before entering
> (or after leaving) its RCU Tasks Trace read-side critical section.  Then
> there is a softirq handler on the back of that interrupt handler, and
> RCU_SOFTIRQ is invoked, calling rcu_core().  Specifically:
> 
> 	/* Report any deferred quiescent states if preemption enabled. */
> 	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
> 		rcu_preempt_deferred_qs(current);
> 	} else if (rcu_preempt_need_deferred_qs(current)) {
> 		guard(irqsave)();
> 		set_need_resched_current();
> 	}
> 
> Preemption is enabled, but we should not report a quiescent state because
> we have interrupted a trampoline.  Correct?

Right!
 
> > Or we can build the blocked task list handling, that we already have for PREEMPT_RCU,
> > when CONFIG_RCU_TASKS && !CONFIG_PREEMPT_RCU. We would just only add tasks when
> > preempted in .text.rcu_no_qs since rcu_read_lock() would still disable
> > preemption on normal explicit readers. So I wouldn't expect more overhead due to
> > that blocked list tracking built since it would rarely track tasks.
> 
> Yes, we could avoid the list of tasks by treating the preemption within
> the trampoline the same as preemption within an RCU read-side critical
> section, but there might not be an rcu_read_unlock() to clean up.
> Which could be a problem.

Ah yes, good point.

> 
> Trampolines that transfer control to tracing code could supply the needed
> cleanup call.  But last I checked, there were trampolines that transferred
> directly back to the original code, with no opportunity for cleaning up.
> 
> Or am I still missing a trick here?

You're right. So we'll indeed need to reuse the deferred qs points here.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
