Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6019D8BC;
	Tue, 22 Sep 2026 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046691; cv=none; b=uzJpicmmgRB+j8wXUm4JlZ5/r5ByycFYi09Aebzo2KkRSa9Yv7RJ+K4yfkKdzeG3oDYYn6LXm6lCcMa30ogKdjUFQeZSvxALHWPzbnMbUYQMT1llN8297h5wqrOPO2LTbNGJW+jc6vX+LCuVyXUAggjF3PrfnZAvtPUKDwM4qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046691; c=relaxed/simple;
	bh=WLRYkkbBWDKPMJXCvjf6ULDKHUK5Pfaitj6yTfelGUo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ik/8hk+LZEv0bMs6Q+j8HMWc/I8hofc7CXwMY72X3WYQJkH8mTMR3ek7++2TFJ1BZ/G/l0ejLgHnJNqgIomKZfTf2kVocq0CXD7oT9SdmPStahwDofDfxqxaeNk5deBczSuCj1Q4ZJmb2IerBU8vZhLw31NJW3H2FT8aS79qF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEqSKjgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEqSKjgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8FD1F000FF;
	Tue, 22 Sep 2026 03:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046690;
	bh=XyNCoq/etK8VeSwcZtzf9WuBv6P9bzgHrlMb9BH//o0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gEqSKjgM4G5xPfJTYQv1LR2kutPUZxItSCcCzzm/PJQ+t+Vp1wm4/jEmdPng+fC4U
	 JnkTRwogPwTy+/uZWZ/nFD2nj4cYzHWH0KEJgal/RZ6Y9bM6tcIcogmdoINrn4wlAY
	 0EBQAPLuYfCxCHNay9BipAOhiQ4sFVFszhHcRHzFmalyJBegR9nbz9PLCFY71+ILnO
	 Auya2yVihZTe8E5xkrWcZhyBq/gyCQALGQo1bY6U0LmIqGvWFXGjrbzJjHKTW15u4e
	 lsQCTd3LmW3Lgql4YIfDLFij3+8PwoT2qkIB63AOPekmWYJ6sGRBu/VbAUa27RDmsw
	 7MIEA0knZmSiw==
Content-Type: multipart/mixed; boundary="===============6030411877518670542=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <76cb003abe9b55df08565c2bd3954e1b7a5300309a6d721111cd454359f050ae@mail.kernel.org>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-12-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-12-410f57770bad@toxicpanda.com>
Subject: Re: [PATCH v5 12/13] rcu-tasks-trace: Assert no reader is held on return to userspace
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,ast@kernel.org,rostedt@goodmis.org
Cc: boqun@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,peterz@infradead.org,tglx@kernel.org,daniel@iogearbox.net,andrii@kernel.org,puranjay@kernel.org,rcu@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 03:11:27 +0000 (UTC)

--===============6030411877518670542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index e19b41ee6b18..d42568a488a7 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -5,6 +5,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/hrtimer_rearm.h>
>  #include <linux/kmsan.h>
> +#include <linux/rcupdate_trace.h>
>  #include <linux/rseq_entry.h>
>  #include <linux/static_call_types.h>
>  #include <linux/syscalls.h>
> @@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
>  {
>  	/* Ensure that kernel state is sane for a return to userspace */
>  	kmap_assert_nomap();
> +	rcu_tasks_trace_assert_idle();
>  	lockdep_assert_irqs_disabled();
>  	lockdep_sys_exit();
>  }
> diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> index dcdb11643496..9eb7f92c710b 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -217,6 +217,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
>  // Placeholders to enable stepwise transition.
>  void __init rcu_tasks_trace_suppress_unused(void);
>
> +/* A task must never reach userspace inside an rcu_read_lock_trace() reader. */
> +static inline void rcu_tasks_trace_assert_idle(void)
> +{
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(current->trc_reader_nesting));
> +}
> +
          ^^^^

This isn't a bug, but since rcu_read_lock_trace_held() already exists a
few lines up, would rcu_tasks_trace_assert_no_reader() (or
..._assert_not_held()) read better here than ..._assert_idle(), given
that "idle" already means the dynticks/RCU-not-watching state elsewhere
in RCU?

And would it be worth moving it above the "Placeholders to enable
stepwise transition" comment so it does not read as part of that group?

>  #else
>  static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
>  /*

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35680506278
--===============6030411877518670542==--
