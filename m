Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88038C423;
	Tue, 22 Sep 2026 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048138; cv=none; b=ZXaeQN3v8NUVheJARK2PRH4xtsfKLUX0wZ6+P53JO2l77VBwCxrqBdBtk/JjkkalWWGVxBZVFQxckba4aAIDtiqnEMcxa/Ssr4ruIWQf+l9xpVq8v8s+rto4G9SR/KLn6bpnPh5BrHxoSx710SzlCF7aiLHmG3x3zKalUsBBHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048138; c=relaxed/simple;
	bh=+FWlMO2cLI9SxgR2ihPHzlFIH0pLd+kC4fMPBKil/Qc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NKlRWZ5BsBo5fcsWcI7Z5ij6srq/3Y/IrhnWG8Cr+wBF32aSFtK4NYqix3VJK7CBjHkIhhGDGSpze9sjKHWdqXoTEJWBZIfzu+yBP4GmIo2JwRrlW4nzYkr8gCYGmNq0QysMDXwRasbZ36xfsPGiD98ghwWFQ/iktYZl7bZbIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUKNa/hd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUKNa/hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52DA1F000FF;
	Tue, 22 Sep 2026 03:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790048133;
	bh=WtEJJnI23HMrvJ1nLmsa7kWdStULy778TOJcpNKSbbw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fUKNa/hdOHyAYp1daoHBAx94b+RvDrx0R9Hp5CTaq6b60oFQ59lV4J8Okxeofqpao
	 kgTZ6GQcYMEXK5UK6Dnu19icDYfUBIr9McTHB3xfjciF5SroVP9m4AIXHYE0ToFc9Y
	 m/650gxZ5ZnaJTCtGxDfgYCe16zZ7XRLMzT1bqFmSY/a8LOeY3MZfqckQ39jbwVcdt
	 SeG0xq89Q33ndu0hMf2e3vXGUc6HzoaBSyZVi1gzjMAH1q9KLW7Hk3q/JcAbqIIN8P
	 lOUJpEaHYN9pqK+VweionZyb+PRU6EDSdmLX7zNglw5+wahlPcbyVdQcuzinDzvvnn
	 RH9ocCGbXPjOg==
Content-Type: multipart/mixed; boundary="===============6597116511644733316=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5de177edfbaed1c26e91a222f2636a56b48a96001cba1d4dab7e37b57e312a0b@mail.kernel.org>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-10-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-10-410f57770bad@toxicpanda.com>
Subject: Re: [PATCH v5 10/13] samples: ftrace: Make the direct-call trampolines Tasks Trace readers
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,ast@kernel.org,rostedt@goodmis.org
Cc: boqun@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,peterz@infradead.org,tglx@kernel.org,daniel@iogearbox.net,andrii@kernel.org,puranjay@kernel.org,rcu@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 03:35:30 +0000 (UTC)

--===============6597116511644733316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 1deb3b548a13555ffd63d9373f054d6da02ad75e
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Tue Sep 22 02:23:29 2026 +0000
>
>     samples: ftrace: Make the direct-call trampolines Tasks Trace readers
>
>     The sample direct trampolines are exactly the kind of out-of-line
>     register_ftrace_direct() user whose lifetime depends on Tasks RCU
>     waiting for a task inside them: nothing else stops rmmod while a task is
>     preempted in my_direct_func().  On HAVE_RCU_TRAMPOLINE_READERS
>     architectures that wait only covers Tasks Trace RCU readers, so give the
>     samples a small shared header with rcu_read_lock_trace() and
>     rcu_read_unlock_trace() open-coded as instruction strings for x86-64 and
>     arm64 -- the same sequences as ftrace_64.S and entry-ftrace.S, using
>     caller-saved non-argument scratch registers -- and bracket every
>     call-out with them.  The instructions outside the bracket are module
>     text, covered by ftrace_direct_mark_module().  Other architectures get
>     empty definitions.
>
>     Assisted-by: LLM
>     Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This looks like a bug fix for the direct trampoline lifetime issue.
Should this include:

  Fixes: 32999f49426a ("rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35680506278
--===============6597116511644733316==--
