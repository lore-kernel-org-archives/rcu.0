Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F1327C00
	for <rcu@vger.kernel.org>; Sun,  2 Aug 2026 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785700619; cv=none; b=smA6g/UlHf6J29pZV1tUr5PCtUYW7VQSKj+rro6+6W5AQBDQ4S0TsIOHCEI3LvpkY3VSK3B4t/h0Ah9nqePFu2stPHbWeNjgmMglF3PDoNtztfpsKgM4dAKcUiZtszPFa4fIXiKXZQ8+02nR/NvYAtsrAK+sRqddB/lzcAMlZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785700619; c=relaxed/simple;
	bh=V1IzwZdk2mYsbL+TYSbB+904Wbwqx0+Hj3gAzFn1/gM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mNImzOTAbL5U799BkKdOweqWIYMqx5rNol/I/fG0xiUymFq9gIS1MpHkv2NeLLbrjEDSZkubcpWd1hBY2f5IvwJ+SO58ZmwvWHW7IEsBnn6ASfa5lALduwEZcg5mkXRm3YEOveX1CyZP9WDedas/N5E8GC8bdDdpp4m+2iDqzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPJEjBvB; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPJEjBvB"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso2327435e9.1
        for <rcu@vger.kernel.org>; Sun, 02 Aug 2026 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785700615; x=1786305415; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JTBPTzllvI8xs8/vG3mDDWRwtzJsDWx33RPIMSsvnUQ=;
        b=JPJEjBvBF7xyzqUoFyBAIghjH58WnXzFxVfErKwGuuOSySo2FUWTvTd27IEBHsP3Gt
         civTkE697WTW2P2ZJvKZHYgoU24/p7WmlZwXatafsBc3hKikV0u3kNDVlu72a6WHRzql
         3Gs+m82ifJdlZ6RVhY1LJ19mICiTUMJaNgntgS8LfGa8+MZ80HpR822zyfdYXVLs9RPm
         3IEVTf/BIToDeIZ3FqQk6YJ+qic6xzQS/SM2D1aP6syCa1AO+Vl79XbbySoWekk6HEov
         RCIBA9vdPQCcSBluXL/c84eADiFt51PlsNxpUSKIqjWZy15ZDPWJ1sFojmZGmiM28ouF
         RooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785700615; x=1786305415;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTBPTzllvI8xs8/vG3mDDWRwtzJsDWx33RPIMSsvnUQ=;
        b=cHdvNpMZ8z27drnwE5N1MzdMrAoxGts/tQRpYnmEe0lZQm2rrdGjWjxc3YK+MkmUBL
         fcp6VDL8HGGvrXurVfa6lmZyssqFqaobGse2GD9UhD/uQFdpQGGU3Vi8SfhHKQtITSr9
         HHT/m9qIwLjS04Ekov1Rjm7SGgraGFyWfuowkEXaQAB0SAZ51CYWdzTXmYCc9x+QrmBF
         vIPfUXemVSbqZZrXKFQbsZ0gGCL/ifh/ubcsgxF0mWcJxrfYhhSMNOFviA9jf5KD5e6M
         TKK6cyWIh22zyzgteFdTUPZwQBMh2/1GZa70kQLZ26hDpUiHLlEYXumnCXiWAMH4PupQ
         uJjw==
X-Forwarded-Encrypted: i=1; AHgh+Rp67rE0pPeO5G8iUJiEhS+mHf8zbGiqqiPBWR2frCWymcdVeWYZXmGbVPWZ9gGHCzAPIhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9fB4rq6ln2OowD4SCQ29yL5Rvwz81kuiZfuPWddiHpHQmC9R
	uFyvMKjTAiNUeRePPyKHnzWZlS6ph/+Z3HYKa7n4oRKLiHTS2lZl2GCe
X-Gm-Gg: AR+sD11+2KduA2dOQy+CZpk9OtncoZQipXvUFeu22u+II5tUCXGZkZDNwub1fGdawIT
	WOo1nUlBHRErg8P/Cib/ox9B/RHAi6H6nry/obpVbpYnd2GG+Xkf3oMMlI5yxWYzCUcEnID3I74
	yTq8nlP/eqBC78X33ScG/q01Bh2NsT7BWH7bL2b/KxD+OIy6IlwrurpLDeS3I2oHzTvldJ/LV1X
	l8B+7gdU5bywxlCnGLPdd0IC1ECF1nO6I+os77e4VbmkX4NG14uM6k33qgyEbJzEYtS0Jzrspry
	CSUMG7k+aIkorvKuVS27g147w+VXK42/FVOIvvlIqcNJJSX0LIE+UZF/H2FIw/mKA5uCdgvU6Ef
	PcIZ2Hjf29mfbWp4HWkwhlVZYnVGRQXMZIZ3Pf6qfvKADQxzh1XUwbFERSXBsAVHGk5J18AAnTp
	VgGWMF2U5toDD8sV+hIpHbuYwTmT9VBbx5HIEr0hl+peusQ52mx0fiHrJwpBBKejTJazEmK+APs
	u5z3yytE3F9PC7Olxp9cQoIIadPjm3X56KMekPBc3tslEo7K8+axEMTZnDLMLQWVTC/HGg8BxPo
	YI6Fo8LDmUXrW2vRd/qYaoL8HTD9
X-Received: by 2002:a05:600c:470a:b0:496:c18c:f998 with SMTP id 5b1f17b1804b1-4980c6a2241mr163673185e9.19.1785700615172;
        Sun, 02 Aug 2026 12:56:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm27799191f8f.27.2026.08.02.12.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 21:56:53 +0200
Message-Id: <DKEQ1D0U77V6.1EMGXI819YAW9@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <paulmck@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
Cc: "Lai Jiangshan" <jiangshanlai@gmail.com>, "Josh Triplett"
 <josh@joshtriplett.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Boqun Feng" <boqun@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Davidlohr Bueso" <dave@stgolabs.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Zqiang" <qiang.zhang@linux.dev>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Matt Fleming"
 <mfleming@cloudflare.com>, "Harry Yoo (Oracle)" <harry@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH 0/6] rcu,srcu: Make call_rcu()/call_srcu() safe from any
 context
X-Mailer: aerc 0.21.0
References: <20260729162207.1567770-1-puranjay@kernel.org>
 <0096fbf8-c3be-4388-a60b-1968664e4f27@paulmck-laptop>
In-Reply-To: <0096fbf8-c3be-4388-a60b-1968664e4f27@paulmck-laptop>

On Thu Jul 30, 2026 at 5:07 AM CEST, Paul E. McKenney wrote:
> On Wed, Jul 29, 2026 at 09:21:59AM -0700, Puranjay Mohan wrote:
>> call_rcu() and call_srcu() only ever touch their per-CPU callback lists
>> with interrupts disabled: the enqueue runs under local_irq_save() (and t=
he
>> nocb locks when offloaded), and so do callback invocation and grace-peri=
od
>> work.  That is fine as long as call_rcu() itself is invoked with
>> interrupts enabled, but it is not always.  An NMI handler can call
>> call_rcu(), and instrumentation can reenter it.  The case that prompted
>> this is a BPF program attached to rcu_segcblist_enqueue() that frees an
>> object: the free reaches call_rcu_tasks_trace(), which is call_srcu()
>> under the hood, back on the same CPU with the srcu_data lock already hel=
d,
>> and it deadlocks on that lock.  Either way, enqueuing directly can corru=
pt
>> the list or deadlock.
>>
>> Rather than scatter context checks through the enqueue, make it defer
>> whenever interrupts are disabled: stage the callback on a per-CPU lockle=
ss
>> list and re-issue it from an irq_work once interrupts are back on, going
>> straight to the enqueue helper so the re-issue cannot defer again.  Only
>> the drain side takes a lock; the staging is a bare llist_add() and stays
>> safe from NMI.  This is behind a new hidden CONFIG_RCU_DEFER, which is s=
et
>> wherever a reentrant enqueue is possible (HAVE_NMI, KPROBES,
>> FUNCTION_TRACER or TRACEPOINTS); without it call_rcu() enqueues exactly =
as
>> before.
>>
>> CPU offline is the awkward part.  A callback can be deferred very late i=
n
>> the outgoing CPU's teardown -- from do_idle() or cpuhp_ap_report_dead(),
>> past the CPUHP_AP_SMPCFD_DYING flush that would otherwise run the irq_wo=
rk
>> -- so the irq_work can no longer run there to re-issue it.  rcu_barrier(=
)
>> and srcu_barrier() therefore drain the deferred lists themselves before
>> they wait: for online CPUs they wait the irq_work out, and for offline
>> ones they drain the list directly, since that irq_work may never run
>> again.  rcutree_migrate_callbacks() drains the outgoing CPU's list too, =
so
>> a late deferral still lands on a callback list even when nobody calls a
>> barrier.  To keep those three drainers from stepping on each other, the
>> drain holds a per-CPU raw lock across the llist_del_all() and the
>> re-issue, so a drainer never returns having pulled callbacks off the
>> deferred list but not yet put them on a callback list.  Every lock the
>> re-issue touches (nocb, rcu_node, srcu_data) is already raw, so the
>> nesting is fine.
>>
>> The irq_work is IRQ_WORK_INIT_HARD.  It is not needed for correctness, b=
ut
>> a non-HARD irq_work runs from a kthread on PREEMPT_RT and can be delayed
>> under load, letting deferred callbacks pile up; running the re-issue in
>> hard-irq context keeps that from turning into an OOM.
>>
>> Patches 1 and 2 do Tree and Tiny RCU, 3 and 4 Tree and Tiny SRCU.  Patch=
 5
>> teaches rcutorture to issue ->call() from a perf-overflow NMI -- the
>> nmi_calls parameter, on by default -- on the flavors that advertise it,
>> and checks that every callback issued from NMI is later invoked.  Patch =
6
>> adds the BPF reentry reproducer described above.
>
> Nice!  I applied this series to -rcu for testing and review.  Patch 6
> might want to go up a different path, but let's see how it goes.
> If it goes via -rcu, it will need an appropriate ack.
>

I think it makes sense to take it through your tree for now. If there are i=
ssues
when we get these changes on BPF side (with the selftest), we'll fix forwar=
d. If
we take it now, it will end up deadlocking the CI, so should come with the
relevant changes once trees are synced.

You can add my ack when taking it in.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> 							Thanx, Paul
>
>> Puranjay Mohan (6):
>>   rcu: Make call_rcu() safe to call from any context
>>   rcu: Make Tiny call_rcu() safe to call from any context
>>   srcu: Make call_srcu() safe to call from any context
>>   srcu: Make Tiny call_srcu() safe to call from any context
>>   rcutorture: Exercise ->call() from NMI context
>>   selftests/bpf: Add a call_srcu() re-entry reproducer
>>
>>  include/linux/srcutiny.h                      |  11 +-
>>  include/linux/srcutree.h                      |   4 +
>>  kernel/rcu/Kconfig                            |   6 +
>>  kernel/rcu/rcu.h                              |  18 +++
>>  kernel/rcu/rcutorture.c                       | 115 +++++++++++++++
>>  kernel/rcu/srcutiny.c                         |  53 ++++++-
>>  kernel/rcu/srcutree.c                         | 138 +++++++++++++++++-
>>  kernel/rcu/tiny.c                             | 101 ++++++++++---
>>  kernel/rcu/tree.c                             | 122 ++++++++++++++--
>>  kernel/rcu/tree.h                             |   5 +
>>  .../selftests/bpf/prog_tests/rcu_reentry.c    |  58 ++++++++
>>  .../testing/selftests/bpf/progs/rcu_reentry.c |  45 ++++++
>>  12 files changed, 636 insertions(+), 40 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c
>>
>>
>> base-commit: 9dc303e69bcd49f9668ca090ae45325269531fbb
>> --
>> 2.53.0-Meta
>>

