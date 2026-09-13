Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B74BEE58;
	Sun, 13 Sep 2026 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268859; cv=none; b=VFDNccYLOTNDTf7SKYhhkKtUY7jnnTzF3Bwwm63Ooo1U5l3N5l6GkLlny/VHcAOyShNOhGaiiftPE6ifn/KmvkZ4Zm5yQ0qagkL68vZP63w1Iky84d5OtxqYJagLDZ/UxjM4O4Ez1JXU2Wpye/b0u4H2pqEaLA/UGiV9UFNJo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268859; c=relaxed/simple;
	bh=W/3xtVk0o34kiF+8UCp7ZVY3yI8DFhfYs6U4DoIP7kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+NYXX825vfP+PNksME/SY1d7YfDW6/B2gL+eOqlV2voEHUrbzQj5KXhWcYu7LgLwJ6ZdGB0teNR531oewrH9Sac2hGqwLVOn1FE5AGp3og7bpR3UfLz7t26evlI0DnikpS0OxwG0CH281R1bZuNhbI7hoXGJqfSs3IiF+clvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuSv2pXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuSv2pXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524621F000FF;
	Sun, 13 Sep 2026 03:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789268857;
	bh=KdhlkMkoM3bS0HNmhu6FPeXNMD9uLWI8hS4d5wSjOX4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=CuSv2pXmX2je4sRvmHKKZCalCD4vMRFoFyu9Z7kjqib0HJZ0R96u12SmyJngVxR2d
	 CSNggnMjRbuvaNfpOxA6kKMng4amlgHfCnKyRffj3AMRXMMXauRj9OaXw5P8g9hq4g
	 0Z6jqwCBeRqIaINZKgWOtW/1/1bcaqhLqkyXwoXoLd2+dn2NIgd0vZi2yb8bASDNLv
	 piKOj5Fgnde2tv2VXvS/Qdfwbv8zZb8k7djWMTU3jTaLAmygk5QLxZBQxBQre6yGdu
	 +uOGZV0+QeWDGdOrI+TtWo4puMNcmdgECkEQg0EnCDjhQv4usxIOb1Vf5UzttNUsW+
	 4U1q7S5+5p0zA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 15EE5CE0ABC; Sat, 12 Sep 2026 20:07:37 -0700 (PDT)
Date: Sat, 12 Sep 2026 20:07:37 -0700
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
	Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>,
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
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
Message-ID: <509e8eff-2a9c-4927-956c-73708ee4fe5a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
 <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com>
 <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
 <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com>
 <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
 <DLDLDGTSBHA0.32TYNBSKKPFXH@gmail.com>
 <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
 <CAADnVQLQs-+-cu2R3QrHppcxOQt9m7Hi+grr4fOnw8m73kQn0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLQs-+-cu2R3QrHppcxOQt9m7Hi+grr4fOnw8m73kQn0Q@mail.gmail.com>

On Sat, Sep 12, 2026 at 04:59:02PM -0700, Alexei Starovoitov wrote:
> On Sat, Sep 12, 2026 at 3:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Sep 12, 2026 at 12:40:55PM -0700, Alexei Starovoitov wrote:
> > > On Sat Sep 12, 2026 at 11:03 AM PDT, Paul E. McKenney wrote:
> > > >
> > > > In the old kernels, yes, we have current->trc_reader_nesting++.
> > > > In the newer kernels, Tasks Trace RCU is instead implemented in terms
> > > > of SRCU-fast, which instead increments per-CPU counters.  Which among
> > > > other thins is a bit faster and does not need to hook into the scheduler.
> > >
> > > old kernels? I'm confused.
> > > rcu_read_lock_trace() in bpf-next is doing t->trc_reader_nesting++
> > > and then calls __srcu_read_lock_fast().
> > >
> > > Are you talking about some RCU branch that you target for next merge window?
> >
> > No, I was thinking of rcu_read_lock_tasks_trace(), forgetting that
> > rcu_read_lock_trace() is still used.  (For good reason, just be clear.)
> > Your comments are quite correct for rcu_read_lock_trace().
> >
> > Hmmm...  Josep's using t->trc_reader_nesting would break for
> > partially overlapping RCU Tasks and rcu_read_lock_trace() readers.
> >
> > But yes, your #5 makes sense:  Deprecate RCU Tasks, upgrade RCU Tasks
> > Trace to check for preemption from within trampolines, and move RCU
> > Tasks users over to the rcu_read_lock_trace() variant of RCU Tasks Trace.
> > (Or am I still missing your point?)
> 
> Pretty much. This way bpf trampoline stays as-is. No extra overhead there.
> rcu tasks users (faultable tracepoints and what else ? )
> switch to rcu_read_lock_trace().
> The only difference for faultable tracepoints is
> extra t->trc_reader_nesting++.

Let's see what the other tracing guys think.

> I have studied the rest of the patches in the series,
> so this proposal can be completely off the mark.

This last is highly ambiguous.  Help?  ;-)

							Thanx, Paul
