Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FA3BED44;
	Tue, 15 Sep 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478007; cv=none; b=ZVLgQnxdcLv61wl0l5jtQ5VDnJArWxjhTC6D99WHwV0ZUBb7/vzyK7FpDYBX6QigHA2PhfCY+gbrebdQ82cC9X9GfXqwBKO6DugkSTAx1HvdXOn3gd28WyBegqg+ShXCP2LWHXPxLKqpyonJI2PCjnNuC96zDguvwiT/YFidnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478007; c=relaxed/simple;
	bh=k+0dMCoNgd+4Arb0rMJ5VhFs9Y31Zn2sBDRwmdeUU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjr4b4xBYrwNNW2YWY3OOvlt891UPYWcluuzx0nx84ztsRIDC2rLertRYPZyhL/mJwROmNCJ5jjmG+GPPRv8KcQJVBRmonjRjcnV3djHEt3Gqd+DnudbndzlFmCJWZS0RcBGi+43qv9ghvGwpNGnfJbF/wTKQYNEN9wjPGc/FH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knl5Rk7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knl5Rk7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BE11F0089A;
	Tue, 15 Sep 2026 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789478006;
	bh=4tD8a6exBiuiMZ+UoC5PJsvb3MP2QyoYGVvzltIQRI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Knl5Rk7L79lys25DYi750mDQwSC6ffBx2Yd/MV/TjslA4t980FAtpJisR/xidrHPa
	 6T6sVPQ0O8X3eLpZ4aarQrxyNuteXmYp3jFjVCIelAbEeqFmpJ0aG+1p7qWMugMF2G
	 WnMT63DNSgDMnE4a4bsyEHD0XV1F9aDohAhutgwte6vXVNl4dHGI/2KBmBhezBvpJx
	 3GnTUXWxqs+EZxgeUrMfbLe6QI7ea2Bw2jnSpd87qTMVX6qIeb9u4IYVif7vUzusPZ
	 1kTqjhRNVP4VMysH92GYpVpSFfauL7AkXQtXSNc7pu9ap+gUdQdJdoxv0udHzAQgmY
	 SX9YeTJ0eXJvg==
Date: Tue, 15 Sep 2026 15:13:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH RFC v2 03/15] rcu-tasks: Hold trampoline nesting across
 irq-exit preemption in trampoline text
Message-ID: <aqlEcz5g5VNjHWzP@localhost.localdomain>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-3-eaaa61ed2da4@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-3-eaaa61ed2da4@toxicpanda.com>

Le Fri, Sep 11, 2026 at 02:08:41PM +0000, Josef Bacik a écrit :
> A trampoline's own rcu_tramp_nesting increment and decrement live inside
> the trampoline, so there is a window of a few instructions on entry and
> exit where the count is zero while the CPU is executing trampoline text
> (or text on the way into one, such as a static ftrace stub holding a
> direct-call target).  In that window the task has not called out, so it
> can only be preempted from an interrupt, and the interrupted instruction
> pointer identifies where it is.

I haven't read the whole patchset yet but what happens if the count is zero
on trampoline exit but the trampoline isn't finished yet and RCU tasks does a
fully quiescent scan of all tasks during that short window? Isn't that ending
with a too short grace period?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
