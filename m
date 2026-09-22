Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9A3A3815;
	Tue, 22 Sep 2026 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047341; cv=none; b=A65F3sM6476aGTvGfhcNDA4n6tcv7l8WoangQM8jI9gdE5PuQ4tWbWVFm9iwO2+EmAmjSY136BV4Fus5X+mje3MMz9+1smOuSA/87tH4ptaLxUB900E/2eFgH6pmrTyamubbMaEOBCdY8bCymn2OzwAzcrsPzm97juax4+2vj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047341; c=relaxed/simple;
	bh=KF7mc1Ly1kFwYtSxCT25pyvXNwlbOJlwOugdFFRVKZA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RhXtxVK6i68k79FPubAOs0pa9HXRxzDKuye0k3pPW2+6Fn6hK5x6s7FKh2wAIjLTJ1MRjx/X8q3BlOoeU1ptnfS5oI9IFLDtu++hPL2TROMk/ng3aHTHDUp8SzGNHzqTw41E17NjBdB7NctDG6IPGMUO6VDaW0WAS9Fg4BWbYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyTfXxNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyTfXxNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4EB1F000FF;
	Tue, 22 Sep 2026 03:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790047339;
	bh=8HfsmWe18vqaIcsmBURthJcIj9m0ORvWdZMKM+oBDQU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XyTfXxNihIPoDS6At5q0W54OiorJXa/2PrFWQ6EE1wm23IUj66LZAPhxJYu0pLS2G
	 1KQZjhatjx2ZifOfHqgECb6+whVG20CsWi8sSEudzSAQ3MdoUES5MLIf3NxVhd0ThN
	 5GzNifSNQouMiGetl2TsPuvpEgvtEEirDPMdSl9ghr2ywFcO8+224AjtCaqm4kJyJw
	 Fb9vTSZf+vZNSgjDb7B+tbnyljroqeBVLSISyr35f4625A5jq3aZ4wuPzP6UkDcK02
	 q+GV/JcbTmjgOs1wouNolcdp6urbu5pgLSJnlwVzoLnq+n5q8zPldDLTTwPELpjK1e
	 YMffkVBUqWQpg==
Content-Type: multipart/mixed; boundary="===============5613520125627611600=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebf2ee78977b3aae08c12e4ba0a18f48463567e20fd282f25acf11f5af375030@mail.kernel.org>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-6-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-6-410f57770bad@toxicpanda.com>
Subject: Re: [PATCH v5 06/13] x86/kprobes: Take a Tasks Trace reader in the optprobe template
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,ast@kernel.org,rostedt@goodmis.org
Cc: boqun@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,peterz@infradead.org,tglx@kernel.org,daniel@iogearbox.net,andrii@kernel.org,puranjay@kernel.org,rcu@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 03:22:17 +0000 (UTC)

--===============5613520125627611600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> x86/kprobes: Take a Tasks Trace reader in the optprobe template
>
> The jump-optimized kprobe template calls optimized_callback() from a
> dynamically allocated slot with preemption enabled, and only Tasks RCU
> keeps that slot alive under a task preempted in the callback.  For
> HAVE_RCU_TRAMPOLINE_READERS that means the template must be a Tasks
> Trace reader across the call, so open-code rcu_read_lock_trace() and
> rcu_read_unlock_trace() around it as ftrace_64.S does.  The template
> lives in .rodata and is memcpy()d into each slot without relocation
> processing, so the references to current_task and
> rcu_tasks_trace_srcu_struct are absolute (R_X86_64_32S, relocated for
> KASLR like any other) rather than %rip-relative.  %rax and %rcx have
> already been saved by SAVE_REGS_STRING and are dead after the call.
>
> The slot itself is dynamically allocated text, so the instructions
> before the lock and after the unlock are covered by the irq-exit check.
> 64-bit only; 32-bit x86 does not take part.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This looks like a bug fix for the preemption issue introduced when commit
a19b2e3d7839 removed IRQ disabling from optimized kprobes. Should this
include:

  Fixes: a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35680506278
--===============5613520125627611600==--
