Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E11E32A2
	for <rcu@vger.kernel.org>; Fri,  9 Jan 2026 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921181; cv=none; b=RhuoLQ1CDPdVc+E571IwH41P0CDxwSoNMAiMftPjoMfEFg1PXP3LPASI8qUEjnGn/XxjF8u8tyXMoBpz1OaQrl7DN9bXCGX4fX7iBNZN4eklScs28GuKphgcUgkjsmkeJERDz7FWd9wsZ+P0AkX7ioTRUf2T/npNjzRjDPWqWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921181; c=relaxed/simple;
	bh=/eSlBPX/kyyrFBZsDG9AIA0KS95FwtVFMG9OiB4oWzk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0KS2EgOBd/ZLuNErE0uMn8dJSWUIgn5pcX2sGAXGbdOHNthoiVtV46O1vdo7EYIrSfoh3i8teBufIl2VSQi6YSUyrq/sPz7KuVTJEbhsHu1NtTzCOvKa/XxeSS47IxF+WdT2TcpfGQlimGvCKKcibZHQf4hBBNiseSZ76xqhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=oYX8TWwN; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oYX8TWwN"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-121a0bcd364so3796993c88.0
        for <rcu@vger.kernel.org>; Thu, 08 Jan 2026 17:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767921179; x=1768525979; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnGlbZvYuz03Yb0nrZqn2RjtIyjEfedXQ3hxMAKDtco=;
        b=oYX8TWwNURDl0yb5YBoY1GZCYNS0B+cuwNnQ3iiYNxt5DPdatS5DsYpUTpYSwU+Ij7
         pe8s3U7jKVXCCBkW9DNH6/MQh7clQyy7pBR4ALmzWVzqSWr7h4AsOS3V9iQn9zMYePV3
         zCPb9AX+3vtu44xRWXYcGcO1IKTcady44kKyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767921179; x=1768525979;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnGlbZvYuz03Yb0nrZqn2RjtIyjEfedXQ3hxMAKDtco=;
        b=nXnbAjA8/OZMBK/9Cz1LaoaAEkZog3aYj960NFKtLY4nkaINC02gWtPWkOUMzNZ5qW
         4nj7vmM421Bw5eKKK6Jhv+MumwYYBv9nDWzzZanmFLfNNSqtRMcMcCsSmqqzBg5esMjf
         3fd++vOp9X8+HKmBb/wvN2QBvs6h1MPW7fC115soGgpUdBUbgtt9uWpPoJrY+a6HEcgy
         z8GksPYl4krcvZdXoglNPTifgm9JDXtfRnLn047eDXYXsbe8Xlu3m8dSf/uqIpXDI+L0
         MfCnAbTs0oMW+2Eug09/IM+mXiEQ3fL03qwu4tqQOsy9AvBPa91h6ja9yDjpjKEwDyVm
         onBw==
X-Forwarded-Encrypted: i=1; AJvYcCVsyoggfzJIS6iesawhqW7GsqzSafBrYSn1vTty2wBc924munC0RdkEfCUO0y5XzX34LDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Os3jHy4HIuwfwWQT74PFX5U16Dr7oAKoiuMJ2UDvrlm9NkOW
	KiYSSat1fzvEEMBglEARPQlCghN9KfYMmwQH/bFfCgI+sIi9BTVLmh2GZ5Dumyuc0Ck=
X-Gm-Gg: AY/fxX4/YhhDVecvA18Tr0S3Dg+VMhyCdFNG54nOcmFCpmEAe1XwLgbzfVyiKWOpAfi
	Tp+ATV4qWXg5ZFWihK+iHLRutaDeTxwVRKoExfuEs0NdHCSdGWwGkKEm/GQi+kPCs5xTYk7eBuE
	z2ghYlk3BnUk+o1E2jl3xZDmu0rm3a1xMMenmF2ZOBIMFjFONMAiMkLlf0avibrAaYdNArPv6pM
	CagqL4CcAHj4Eo+3M1gUSF1tvAKgu9HnAPNHad5OIG2H+bMzTdjnA9040Uctj7vRGTrjZY9Y9EK
	i4SOrwsEcGNPmk72E0eFLkAJg0lM3sOpWXT2eSiVAXXGGMTO7rotI1Di1WaMRT190tT2O5KlEs5
	6uYRlNraPxMnF7VqeSUTceKqjupR8AlOaKxVLIkEZJDiFrdf920XdanpxPz8nY4Ok27f+m0LjLv
	J5K9WJhy1KFAsLmXMEqw==
X-Google-Smtp-Source: AGHT+IEo/ViGo3mBYCIINoPRUxDpsbHqk6s5jdGyhnucbk8EjmBieDT2xf4lTkrWXcd3jc+0wPMLJQ==
X-Received: by 2002:a05:7022:220:b0:122:8d:3680 with SMTP id a92af1059eb24-122008d3bb3mr3187718c88.40.1767921178397;
        Thu, 08 Jan 2026 17:12:58 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm15803053c88.2.2026.01.08.17.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:12:57 -0800 (PST)
From: Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelagnelf@nvidia.com>
Date: Thu, 8 Jan 2026 20:12:56 -0500
To: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>
Cc: Paul E McKenney <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kai Yao <yaokai34@huawei.com>, Tengda Wu <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <20260109011256.GA1099041@joelbox2>
References: <aV7o36CHTLc-tD41@pavilion.home>
 <A88C7853-504A-496E-93A2-C9FE7D80E0D5@joelfernandes.org>
 <aV_MZfdIfsITRfFD@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV_MZfdIfsITRfFD@localhost.localdomain>
User-Agent: Mozilla Thunderbird

Hi Frederic,

On 1/8/2026 10:25 AM, Frederic Weisbecker wrote:
> Le Wed, Jan 07, 2026 at 08:02:43PM -0500, Joel Fernandes a écrit :
>>
>>
>>> On Jan 7, 2026, at 6:15 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
>>>
>>> ﻿Le Thu, Jan 01, 2026 at 11:34:10AM -0500, Joel Fernandes a écrit :
>>>> From: Yao Kai <yaokai34@huawei.com>
>>>>
>>>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>>>> __rcu_read_unlock()") removes the recursion-protection code from
>>>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>>>> raise_softirq_irqoff() with ftrace enabled as follows:
>>>>
>>>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
>>>> Modules linked in: my_irq_work(O)
>>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
>>>> Tainted: [O]=OOT_MODULE
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>>>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>>>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>>>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>>>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>>>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>>>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>>>> PKRU: 55555554
>>>> Call Trace:
>>>> <IRQ>
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> unwind_next_frame+0x203/0x9b0
>>>> __unwind_start+0x15d/0x1c0
>>>> arch_stack_walk+0x62/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> unwind_next_frame+0x203/0x9b0
>>>> __unwind_start+0x15d/0x1c0
>>>> arch_stack_walk+0x62/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> unwind_next_frame+0x203/0x9b0
>>>> __unwind_start+0x15d/0x1c0
>>>> arch_stack_walk+0x62/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> __is_insn_slot_addr+0x54/0x70
>>>> kernel_text_address+0x48/0xc0
>>>> __kernel_text_address+0xd/0x40
>>>> unwind_get_return_address+0x1e/0x40
>>>> arch_stack_walk+0x9c/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> __raise_softirq_irqoff+0x61/0x80
>>>> __flush_smp_call_function_queue+0x115/0x420
>>>> __sysvec_call_function_single+0x17/0xb0
>>>> sysvec_call_function_single+0x8c/0xc0
>>>> </IRQ>
>>>>
>>>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
>>>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>>>> setting a flag before calling irq_work_queue_on(). We fix this issue by
>>>> setting the same flag before calling raise_softirq_irqoff() and rename the
>>>> flag to defer_qs_pending for more common.
>>>>
>>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
>>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>
>>> Looks good but, BTW, what happens if rcu_qs() is called
>>> before rcu_preempt_deferred_qs() had a chance to be called?
>>
>> Could you provide an example of when that can happen?
> 
> It can happen because rcu_qs() is called before rcu_preempt_deferred_qs()
> in rcu_softirq_qs(). Inverting the calls could help but IRQs must be disabled
> to ensure there is no read side between rcu_preempt_deferred_qs() and rcu_qs().

Ah the rcu_softorq_qs() path. Indeed, I see what you're saying now. Not sure
how to trigger it, but yeah good catch. it would delay the reset of the flag.

> I'm not aware of other ways to trigger that, except perhaps this:
> 
> https://lore.kernel.org/rcu/20251230004124.438070-1-joelagnelf@nvidia.com/T/#u
> 
> Either we fix those sites and make sure that rcu_preempt_deferred_qs() is always
> called before rcu_qs() in the same IRQ disabled section (or there are other
> fields set in ->rcu_read_unlock_special for later clearance). If we do that we
> must WARN_ON_ONCE(rdp->defer_qs_pending == DEFER_QS_PENDING) in rcu_qs().
> 
> Or we reset rdp->defer_qs_pending from rcu_qs(), which sounds more robust.

If we did that, can the following not happen? I did believe I tried that and it
did not fix the IRQ work recursion. Supposed you have a timer interrupt and an
IRQ that triggers BPF on exit. Both are pending on the CPU's IRQ controller.

First the non-timer interrupt does this:

irq_exit()
  __irq_exit_rcu()
    /* in_hardirq() returns false after this */
    preempt_count_sub(HARDIRQ_OFFSET)
    tick_irq_exit()
      tick_nohz_irq_exit()
	    tick_nohz_stop_sched_tick()
	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
		   __bpf_trace_tick_stop()
		      bpf_trace_run2()
			    rcu_read_unlock_special()
                              /* will send a IPI to itself */
			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);

<timer interrupt runs>

The timer interrupt runs, and does the clean up that the IRQ work was supposed
to do.

<IPI now runs for the IRQ work>
  ->irq_exit()
   ... recursion since IRQ work issued again.

Maybe it is unlikely to happen, but it feels a bit fragile still.  All it
takes is one call to rcu_qs() after the IRQ work was queued and before it
ran, coupled with an RCU reader that somehow always enters the slow-path.

> Ah an alternative is to make rdp::defer_qs_pending a field in union rcu_special
> which, sadly, would need to be expanded as a u64.

I was thinking maybe the most robust is something like the following. We
_have_ to go through the node tree to report QS, once we "defer the QS",
there's no other way out of that, that's a path that is a guarantee to go
through in order to end the GP. So just unconditionally clear the flag there
and all such places, something like the following which passes light
rcutorture on all scenarios.

Once we issue an IRQ work or raise a softirq, we don't need to do that again
for the same CPU until the GP ends).

(EDIT: actually rcu_disable_urgency_upon_qs() or its callsites might just be
the place, since it is present in (almost?) all call sites we are to report
up on the node tree).

Thoughts? I need to double check if there any possibilities of requiring IRQ
work for more than one time during the same GP and the same CPU. I don't think
so though.

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b7c818cabe44..81c3af5d1f67 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -729,6 +729,12 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	}
 }
 
+static void rcu_defer_qs_clear_pending(struct rcu_data *rdp)
+{
+	if (READ_ONCE(rdp->defer_qs_pending) == DEFER_QS_PENDING)
+		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+}
+
 /**
  * rcu_is_watching - RCU read-side critical sections permitted on current CPU?
  *
@@ -2483,6 +2490,8 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		}
 
 		rcu_disable_urgency_upon_qs(rdp);
+		rcu_defer_qs_clear_pending(rdp);
+
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 	}
@@ -2767,6 +2776,12 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			if (ret > 0) {
 				mask |= rdp->grpmask;
 				rcu_disable_urgency_upon_qs(rdp);
+				/*
+				 * Clear any stale defer_qs_pending for idle/offline
+				 * CPUs reporting QS. This can happen if a CPU went
+				 * idle after raising softirq but before it ran.
+				 */
+				rcu_defer_qs_clear_pending(rdp);
 			}
 			if (ret < 0)
 				rsmask |= rdp->grpmask;
@@ -4373,6 +4388,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
 
 		local_irq_save(flags);
 		rcu_disable_urgency_upon_qs(rdp);
+		rcu_defer_qs_clear_pending(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
@@ -4432,6 +4448,7 @@ void rcutree_report_cpu_dead(void)
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_disable_urgency_upon_qs(rdp);
+		rcu_defer_qs_clear_pending(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 96c49c56fc14..7f2af0e45883 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -272,6 +272,10 @@ static void rcu_report_exp_rdp(struct rcu_data *rdp)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
 	ASSERT_EXCLUSIVE_WRITER(rdp->cpu_no_qs.b.exp);
+
+	/* Expedited QS reported. TODO: what happens if we deferred both exp and normal QS (and viceversa for the other callsites)? */
+	rcu_defer_qs_clear_pending(rdp);
+
 	rcu_report_exp_cpu_mult(rnp, flags, rdp->grpmask, true);
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6c86c7b96c63..d706daea021f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -487,8 +487,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_pending = DEFER_QS_IDLE;
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
