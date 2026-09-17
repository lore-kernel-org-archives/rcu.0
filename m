Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC064EDCAC;
	Thu, 17 Sep 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664146; cv=none; b=sKGfc1VQ7Hqpjja4M9c7kNlgIJM6arlC07C0SGw+94sbXTr7eR8Q7SaC6PS/QwJbuAWkqrjAYqQqy1YgWIWcHDz5aC5B96Wgv5F6zXgpIS9cnkDm1ecklYbaB9FMYYoohW/k2o4jc4gJLIQBSgMR5P2n30S5VdVFhV6kB52dMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664146; c=relaxed/simple;
	bh=aWceE8YCDQTZLXjvs2oWn+fK7kFnCIQzMI9JUWzQi5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxDCNVQJe+PmVwABEKwx1l5IKgVcNCVfOVHYu+eIkc6Sist52g5LtHdy6paL9THPFzQR0bj+Vx3B5jekgSyPMIb4kLXp2oFYXjpqTJKWyFcDk6WKLsjoDFnJSJfUo7RxbcgmclyE5qQGfo7Tt0U6iu/YXXR4qKplJDJVKiOP/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9OE8qLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9OE8qLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB21F00893;
	Thu, 17 Sep 2026 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664145;
	bh=kimfGEK+WeQrCTnIb5ePzNtWXHK0EcqiD+euMxaQ0do=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=T9OE8qLzP1qfh6XFbx+1FEoAjXMXA5nopSdvlfyoaHtqeRG7yuIX6hvGsZ2fZDZHC
	 LlZHivU+VHSNOyLlTJD9LcDm74HSY0oBYS6V98tfaqWPsGPg0x3pT212aZxB1cTj2h
	 H5i+iwmISzuUJTFqG0ROiZDclaI7Dsm5HDgAJBJ1MUlStbHa5H1eEUO5Q0pdnLLmRn
	 bfDIUKXG/xV9fr8ZZBBKeo2cOSk+IR2Blsw1i4L2ofdwxlH5VeRL80zT4LC59Fh7Zv
	 2QJ/t3AdkTEG0yssMOFKDF+buK2RR78k+s/SfH4SFxaON89u5sImLoK7VX3+tMuq4b
	 4hANaNhRy05TA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0461BCE1716; Thu, 17 Sep 2026 09:55:45 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:55:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <5734196a-22ab-428e-9565-d7ba787d3eb1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aqqONH8flTIpOUqT@localhost.localdomain>
 <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>
 <aqqpRoTfywUuTgoC@localhost.localdomain>
 <aqqsAUVV8a1yrQzX@localhost.localdomain>
 <6afb0afe-e7b8-46b4-9fea-2c7cf4791044@paulmck-laptop>
 <aqq0cwvRDsorGwgc@localhost.localdomain>
 <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop>
 <aqvZwfUVsiEI7q7y@localhost.localdomain>
 <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
 <c51591e0e96c837bcd762c207e5e1869.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51591e0e96c837bcd762c207e5e1869.josef@toxicpanda.com>

On Thu, Sep 17, 2026 at 04:35:19PM +0000, Josef Bacik wrote:
> On Thu, 17 Sep 2026 08:40:10 -0700, Paul E. McKenney wrote:
> > On Thu, Sep 17, 2026 at 02:14:57PM +0200, Frederic Weisbecker wrote:
> > > You're right. So we'll indeed need to reuse the deferred qs points here.
> >
> > Except this is getting a bit involved.
> >
> > Don't get me wrong, if Josef is happy to take this on, far be it from me
> > to stand in his way.  But if not, we should be willing to treat this
> > optimization as a follow-on effort, whether by Josef or someone else.
> 
> Follow-on works for me. For what it's worth 03/13 is already fairly
> close to what Frederic describes, just outside the core flavor: no
> task-list scan (the GP waits per CPU for a pass through __schedule() or
> an EQS), the irq-exit preemption path checks the interrupted IP and
> queues the task as a holdout before the switch, and the holdout is keyed
> on where the task was interrupted so nothing is needed from the
> trampoline tail. Moving that IP check into the tick / rcu_exp_handler() /
> deferred-QS paths and reusing the blocked-tasks list is something I'm
> happy to look at once this has settled.
> 
> v4 will pick up Alexei's ask (reader emitted by the BPF JIT around the
> fentry and fexit regions rather than in the glue) and the idle-CPU hole
> Sashiko found.

Even better!  ;-)

							Thanx, Paul
