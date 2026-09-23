Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E3378D8B
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129811; cv=none; b=MdINvL2JKia+dAiz2GlKrnqiIyp2SYHML82jOfmifiZ4ZuHX28ZadrL0TdmcwRiRzcPTeoV1tb/fPk50t0bT1e/sS6NwOX8px9sAdL9uG84E5DstEkrO/01XGQCj6Nlf2WO4R8d++132BEnGa/D+/IGzbERae6dExritA2M4I8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129811; c=relaxed/simple;
	bh=j0orzS41Ul+goT61z8fahX/NeWz2zFFlqB/sCOOKK+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HEY7cE37p4e/hg2hxH8z+k2C+SrCi1XU/Ezzr9FW4Vz+kNhIS2jANZnWocBMAYuSBOss5yKIqDSEM0UNpqv3OEqAgTD+dyZCIqETPZNndJFNJQVSA39+jH2H75aiMlceyXoyvGZrH1bLDzJNOaxmfupivQJbm/mACcVLhk/xOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epklhb1J; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epklhb1J"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so275588a91.1
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790129807; x=1790734607; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5mLdHkKI/Hk3BqqZoW+gtkhvs5fryLWhkPrRSEcEKag=;
        b=epklhb1JVVPAEIoT/WXb8FpeoS+tBP76FyEydJ9h49AfQtVlijJZxYKoKRz+XsCMNa
         J3kHiWOtVapE3a70Ain9YUDy1o6MrZZjx8YDK4i3TRXRWu3IFWLjmpvzDrBSZvaMNf+c
         rp6Th7xT++C5VGprr5cMRx/BqIptXmdTYvYTZVOPdYh5KAUF9k9TeKUw+l1foD0PfmWI
         LAIRbZwj9Gd03M/9ZPIo9OaONTS3ko2ALjr7ocnR/DMkS/jpAo5Or4/zlwckSADmSuH4
         cacUbWoi1FvOVl0DL4gBVrdatLyjzvGSkqf7bBUzmUH9u84RaSzgIJ0HU1/rkHAtqQbZ
         8RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790129807; x=1790734607;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mLdHkKI/Hk3BqqZoW+gtkhvs5fryLWhkPrRSEcEKag=;
        b=ctvcQZS+cII5z3FCRC0FsM8D7NsQ/r2vF7ICZU6L0JZ6eDAeNHnyEVnRQbeZERa/k2
         pQGdMnVF4MtdLp0jYynOy9KlDfrcgrK6Fcm3H8yuc6wZYdMFIIktu/LPax9P4PzrHfb0
         prAfxboll9/emn0QHEBcvHBt0hTXgRzqV0/Ps4Llol1Eo5yWimoC62/4Qm3EhPuKicLD
         looO9hCpwLGyrmrnJMPdUTo1/EuyWk11XmvHMEAUb0jeeOZE6OjpwJSa6wRU3YTT389n
         yJYLoMVV8Mmy/7f3KjD97kNQ7KgsOIjmp0/gPaKr6b98X2ugUm0WqVjuqzaHCyM9iSse
         3lEw==
X-Forwarded-Encrypted: i=1; AKwUvBzuBkROGGWoQR7nbvswibUeUvwz398MkByGUsremrjImSIeB95n2YIpHNRidAU+RRUw9aI=@vger.kernel.org
X-Gm-Message-State: AFuF++maBaB8bT87bxsOIg4bS2aDD5W4dckjDf0qjfHeMh2gaCJ15Xfs
	Rf/FxrxujYkmgrov4TB0bDEdWNea0m66oHEHVQ4NW5s/zrDFQgl3Vxld
X-Gm-Gg: AYBFou2j9ROK70W3C1b6Y3gQgJlSCV+yiwUuDEQYlFem8GmyasB1JNrgGDNriIPEbBG
	htSDchh78SFTNpQx/+feomP1wugnUWrL0VoNStF53PLoBTMDpgPCrOkNHaEevd8PAF7GX0Qc0PB
	imIN4xMQfvsgDYSNA5OR7D88fjn2kE6BK4Wa+E7cncvBsK5rSTdupoYU6SiyEImAaHs1gls2wI1
	cdSgPAax9Tkw7fnnvY6DKTh28X2V378FCVaKjuUGXf5fz8NUX2KFpL5FE/JCcT5UfbMvi0KGCzY
	nfgdPLBaNIefXBXLo7sZVFxQdAoLG56kA9DLHMu0s+ZYVUL06C0bNCv5Q8/nuGcoqUnt8RZ/kZ4
	Sdbjt1+gYzWFe8FIQQy4fNVLK/cKk7yQcLkpWbrM7WmGozq90PzCAyns0b4rjLUlPwUJhVTUx+H
	lrrcbi1izM2SLABGsU6AXcQr92kLTAZzosQaqinE0dB5d5+4YpD+VeB5lkZFmJMFd8G8g04sgRc
	YKSxlVxw4zw5KmxmFsBmQG8lzwuhH0CXhWMGsq5mmmFTw7GQE5zjBQmyHOHbqgpCFXNmjdwi7Tk
	/L4AGzGlLvwyYbc=
X-Received: by 2002:a17:90b:2e0d:b0:39e:6c6a:4b6d with SMTP id 98e67ed59e1d1-3a07e6bc443mr1025420a91.55.1790129806696;
        Tue, 22 Sep 2026 19:16:46 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddae723sm2013459a91.5.2026.09.22.19.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 19:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 02:16:45 +0000
Message-Id: <DLMC1ZMTWZYV.3H2LAOGONVAUQ@gmail.com>
Cc: "Boqun Feng" <boqun@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>,
 <rcu@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/13] bpf, x86: Take a Tasks Trace reader in the
 trampoline around its call-outs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com> <20260922-b4-rcu-tasks-preempt-qs-v5-7-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-7-410f57770bad@toxicpanda.com>

On Tue Sep 22, 2026 at 2:23 AM UTC, Josef Bacik wrote:
> On HAVE_RCU_TRAMPOLINE_READERS kernels Tasks RCU keeps a BPF trampoline
> image allocated only while a task using it is a Tasks Trace RCU reader
> or is executing text that rcu_tasks_trampoline_text() recognises.  The
> image itself is such text, but the C glue and the programs it calls are
> not, and only sleepable programs take rcu_read_lock_trace() today.
>
> Have the x86-64 JIT open-code rcu_read_lock_trace() and
> rcu_read_unlock_trace() in the trampoline, as ftrace_64.S does for
> ftrace_caller: one reader from just after the frame is set up to just
> before the original function is called, covering __bpf_tramp_enter()
> and the fentry and fmod_ret programs, and a second one from just after
> the original function returns to just before the final register
> restore, covering the fexit programs and __bpf_tramp_exit().  The
> original function itself runs outside both, since it may run for a long
> time and the image is pinned by im->pcref across it.  Trampolines that
> do not call the original function get a single reader around all their
> programs.  The second reader is entered before ip_after_call, so the
> ip_after_call -> ip_epilogue jump that bpf_tramp_image_put() patches in
> is inside it, and the fmod_ret early-exit branch lands after that point
> still holding the first reader, so exactly one is held on every path.
>
> The sequence uses r10 and r11, which are scratch at each emission point,
> and references current_task and rcu_tasks_trace_srcu_struct by absolute
> sign-extended address, the form the JIT already relies on for
> this_cpu_off.  Sleepable programs' own rcu_read_lock_trace() simply
> nests.  Nothing is emitted on other configurations.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 107 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2853e87797a7..b77e29c9599d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -14,6 +14,7 @@
>  #include <linux/memory.h>
>  #include <linux/sort.h>
>  #include <linux/execmem.h>
> +#include <linux/rcupdate_trace.h>
>  #include <asm/extable.h>
>  #include <asm/ftrace.h>
>  #include <asm/set_memory.h>
> @@ -722,6 +723,91 @@ static void emit_indirect_jump(u8 **pprog, int bpf_r=
eg, u8 *ip)
>  	*pprog =3D prog;
>  }
> =20
> +/*
> + * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() for the
> + * trampoline, see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the equivalent
> + * macros in arch/x86/kernel/ftrace_64.S.  The image is not relocated, s=
o
> + * current_task and rcu_tasks_trace_srcu_struct are referenced by absolu=
te
> + * (sign-extended 32-bit) address, the form the JIT already relies on fo=
r
> + * this_cpu_off.  Uses r10 and r11, which are scratch at every emission
> + * point, and clobbers flags.
> + *
> + * lock:                                  unlock:
> + *   mov  r11, gs:[current_task]            mov  r11, gs:[current_task]
> + *   mov  r10d, [r11+nesting_off]           mov  r10d, [r11+nesting_off]
> + *   inc  dword ptr [r11+nesting_off]       sub  r10d, 1
> + *   test r10d, r10d                        jnz  2f
> + *   jnz  1f                                mov  r10, [r11+scp_off]
> + *   mov  r10, [&srcu.srcu_ctrp]            mov  dword ptr [r11+nesting_=
off], 0
> + *   inc  qword ptr gs:[r10+locks_off]      (smp_mb)
> + *   mov  [r11+scp_off], r10                inc  qword ptr gs:[r10+unloc=
ks_off]
> + *   (smp_mb)                               jmp  3f
> + * 1:                                     2: mov [r11+nesting_off], r10d
> + *                                        3:
> + */
> +static void emit_trace_rcu_reader(u8 **pprog, bool lock)
> +{
> +#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
> +	const u32 nesting_off =3D offsetof(struct task_struct, trc_reader_nesti=
ng);
> +	const u32 scp_off =3D offsetof(struct task_struct, trc_reader_scp);
> +	const u32 locks_off =3D offsetof(struct srcu_ctr, srcu_locks);
> +	const u32 unlocks_off =3D offsetof(struct srcu_ctr, srcu_unlocks);
> +	const bool mb =3D !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB);
> +	u8 *prog =3D *pprog;
> +
> +	/* The plain this_cpu_inc() form of __srcu_read_lock_fast(). */
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
> +
> +	/* mov r11, gs:[abs32 current_task] */
> +	EMIT2(0x65, 0x4C);
> +	EMIT3(0x8B, 0x1C, 0x25);
> +	EMIT((u32)(unsigned long)&current_task, 4);
> +	/* mov r10d, dword ptr [r11 + nesting_off] */
> +	EMIT3_off32(0x45, 0x8B, 0x93, nesting_off);
> +
> +	if (lock) {
> +		/* inc dword ptr [r11 + nesting_off] */
> +		EMIT3_off32(0x41, 0xFF, 0x83, nesting_off);
> +		/* test r10d, r10d */
> +		EMIT3(0x45, 0x85, 0xD2);
> +		/* jnz 1f */
> +		EMIT2(X86_JNE, 8 + 8 + 7 + (mb ? 6 : 0));
> +		/* mov r10, qword ptr [abs32 &rcu_tasks_trace_srcu_struct.srcu_ctrp] *=
/
> +		EMIT4(0x4C, 0x8B, 0x14, 0x25);
> +		EMIT((u32)(unsigned long)&rcu_tasks_trace_srcu_struct.srcu_ctrp, 4);
> +		/* inc qword ptr gs:[r10 + locks_off] */
> +		EMIT4_off32(0x65, 0x49, 0xFF, 0x82, locks_off);
> +		/* mov qword ptr [r11 + scp_off], r10 */
> +		EMIT3_off32(0x4D, 0x89, 0x93, scp_off);
> +		/* smp_mb(): lock add dword ptr [rsp - 4], 0 */
> +		if (mb)
> +			EMIT2_off32(0xF0, 0x83, 0x00FC2444);
> +		/* 1: */
> +	} else {
> +		/* sub r10d, 1 */
> +		EMIT4(0x41, 0x83, 0xEA, 0x01);
> +		/* jnz 2f */
> +		EMIT2(X86_JNE, 7 + 11 + (mb ? 6 : 0) + 8 + 2);
> +		/* mov r10, qword ptr [r11 + scp_off] */
> +		EMIT3_off32(0x4D, 0x8B, 0x93, scp_off);
> +		/* mov dword ptr [r11 + nesting_off], 0 */
> +		EMIT3_off32(0x41, 0xC7, 0x83, nesting_off);
> +		EMIT(0, 4);
> +		if (mb)
> +			EMIT2_off32(0xF0, 0x83, 0x00FC2444);
> +		/* inc qword ptr gs:[r10 + unlocks_off] */
> +		EMIT4_off32(0x65, 0x49, 0xFF, 0x82, unlocks_off);
> +		/* jmp 3f */
> +		EMIT2(0xEB, 7);
> +		/* 2: mov dword ptr [r11 + nesting_off], r10d */
> +		EMIT3_off32(0x45, 0x89, 0x93, nesting_off);
> +		/* 3: */
> +	}

I think lockdep is still broken due to inlining.
lockdep enabled kernel will miss this rcu tasks CS.

Instead let's add rcu_read_lock_trace() to __bpf_tramp_enter()
and remove it from __bpf_prog_enter_sleepable*().

Also add __bpf_tramp_before_call_orig()
and __bpf_tramp_after_call_orig(), so that orig call
can run outside for RCU tasks CS.

Better ideas?

