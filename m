Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AE2D7380;
	Sat, 12 Sep 2026 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789189842; cv=none; b=bB3kxkbFJ+U2EgDkijPT/0/Fe5B99LdypMRCSfNa+2TSBFrMI7+BcEeMgZvvp37RC9poj2Z9j6EnMlP3aldW5Ej/ASceYaa8iISAtJZvVcfLrNNPXZjjYyrwKZ7tcqX3zc8my3nuvuaPfrklnO45ucSicZzhg0+gk36dlJMZ9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789189842; c=relaxed/simple;
	bh=hVsHNEchk19ZFl5Ele9nkgAwvZ85K0YSzOU9gj44rBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDz8JTfpn4vHaU50rVP5r/0OIVg4jFcFHhtqhHpk+qJIrf23empJgDNZvjiB1/E9ddDtbjuWzaUwI5iteUgHgQ1OKzG4SuaHOhD3Dc1L4P7hwe9+lfp5EogfBsVggz/U507o5EhkdrlpV/Qjry3DauY2/OOYN2QR+UxNghJL5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEZphzm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEZphzm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2201F000FF;
	Sat, 12 Sep 2026 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789189841;
	bh=b7gamaM3ocBB+4O2hg6ustnV02tbiSJQKUzLHib6YK0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=OEZphzm3wMMRqTwmUnagcM+KkWkkTEvAT3wcp93TZCJkN2dazyFetMFqVZVuf+zV7
	 drMfqy3/azCvyRO4GZwYRU62gKX9R/h4JnLkota4GImeWvztGmQ6gwzOEl9t+pkiVf
	 BDyS7frnNnG5/bK6UOHkPheXHOc+Ms5TmGLMpESOjUDdK4nK60SgDxKyQ8zj52lyzc
	 wcMR2QrQ2oOSEEYg/HXgIsIeY8gxve2Ade2bJEbOR4QQA4BcQ9oOAbXJ23ExBEaMJr
	 fjuNwfEtxx9Jn4UMZiVSKI/wMEB0jAsmzu3W4RnVLmA/qTJBuYAwblXEdcX6uU/UsY
	 1IvqTxEnYzpUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2B99CE1580; Fri, 11 Sep 2026 22:10:40 -0700 (PDT)
Date: Fri, 11 Sep 2026 22:10:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
Message-ID: <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
 <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com>

On Fri, Sep 11, 2026 at 08:27:56PM -0700, Alexei Starovoitov wrote:
> On Fri Sep 11, 2026 at 7:08 AM PDT, Josef Bacik wrote:
> > Emit an increment of current->rcu_tramp_nesting once the trampoline's
> > frame is set up and a decrement before the final register restore, so
> > that a task preempted while running fentry/fexit/fmod_ret/LSM programs
> > or the __bpf_tramp_enter()/__bpf_tramp_exit() glue is not treated as
> > Tasks-RCU quiescent.  Drop the count around the call to the original
> > function: that may run arbitrarily long without sleeping and must not pin
> > a Tasks RCU grace period, and the trampoline frame above it is held by
> > im->pcref rather than by Tasks RCU (see bpf_tramp_image_put()).  The
> > fmod_ret early-exit branch and the ip_after_call -> ip_epilogue poke both
> > skip the decrement/increment pair around the original call, so the count
> > stays balanced on every path.
> >
> > The sequence is "mov r11, gs:[current_task]; inc/dec dword [r11 + off]";
> > r11 is scratch at every emission point and (u32)&current_task is a valid
> > sign-extended %gs-absolute with the current per-CPU layout, the same form
> > the JIT already uses for this_cpu_off.  The image is dynamically
> > allocated text, so the instructions outside the bracketed region are
> > covered by the irq-exit IP check.
> >
> > Assisted-by: LLM
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2853e87797a7..a375c1b7bd50 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -722,6 +722,31 @@ static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
> >  	*pprog = prog;
> >  }
> >  
> > +/*
> > + * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().
> > + *
> > + *   mov r11, QWORD PTR gs:[current_task]
> > + *   inc/dec DWORD PTR [r11 + offsetof(struct task_struct, rcu_tramp_nesting)]
> > + *
> > + * r11 (AUX_REG) is scratch in the trampoline at every point this is emitted.
> > + */
> > +static void emit_rcu_tasks_tramp_nesting(u8 **pprog, bool enter)
> > +{
> > +#ifdef CONFIG_TASKS_RCU
> > +	u8 *prog = *pprog;
> > +
> > +	/* mov r11, gs:[abs32] */
> > +	EMIT2(0x65, 0x4C);
> > +	EMIT3(0x8B, 0x1C, 0x25);
> > +	EMIT((u32)(unsigned long)&current_task, 4);
> > +	/* inc/dec dword ptr [r11 + disp32] */
> > +	EMIT3(0x41, 0xFF, enter ? 0x83 : 0x8B);
> > +	EMIT(offsetof(struct task_struct, rcu_tramp_nesting), 4);
> > +
> > +	*pprog = prog;
> > +#endif
> 
> It's not a lot of overhead, but I feel it will be the death by thousand cuts.
> rcu_read_lock_trace() in bpf_prog_enter_sleepable is doing the same thing...
> increamenting a variable inside current.
> Can they be combined? Like treat current->trc_reader_nesting > 0 as
>  current->rcu_tramp_nesting > 0 ?
> Or replace one with the other?
> Two current->foo++ operations look redundant.
> 
> bpf trampoline is already quite heavy. I'd like to find ways to reduce
> its overhead instead of adding more.

Replace rcu_read_lock_trace() with Josef's rcu_tasks_trampoline_enter)?

But if this means reverting the re-implementation of RCU Tasks Trace in
terms of SRCU, I will be rather annoyed with myself.  ;-)

							Thanx, Paul
