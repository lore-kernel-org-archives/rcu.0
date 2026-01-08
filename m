Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4F39FCE
	for <rcu@vger.kernel.org>; Thu,  8 Jan 2026 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836118; cv=none; b=bj5IKljM2vdoG6J6ZopBTB5yl1WOdG59PP8XUNNMP5HUiM9hdHi9W5/fKp7pY1MfY5vuYnw/3sZ02U7n1i5vCPQKQLDqh3ty/lASB/lrhPfaYGlFW1+rz5/FWCkXwhNCDx70AmR4wsHhOZQy7AI+xCs+ZtADY1D1Hq2rgAuCkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836118; c=relaxed/simple;
	bh=YuvwB+uAB8cMxPXzO6aOs8cipXS+g4rJ10wsCVlitUw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=b0CsyXexS8hoHio3eme2O9GgQHTtPe5yu11n7FHlqI42CvO7OvbbHq29WbszkWpTK6ujEq3CeIKADFSZAQKQvQ58bEEWf/jaHoyStpgvZDklm/ocYWlDXWr8D4Nij5RImVjMf+ofZHOyDjsiDGolmIQSWGkOEjxElpIUgU1YuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=g4bruk3c; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g4bruk3c"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae53df0be7so3258798eec.1
        for <rcu@vger.kernel.org>; Wed, 07 Jan 2026 17:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767836115; x=1768440915; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14IDgGs8M+5kC5Gh21HKCq+/QmGHgKYdpYq98QosXLw=;
        b=g4bruk3cL8X0VNfB11e3CVvPd5jHT7pWzhgg5TrB3mYtgS9ttdXgh9R5BEQmmWbtWt
         lP0TWl/Y5hyvGTlYlm6eBLQ8E1sv2qKJDvVWu2eeA4WwQp7FHwgntfv/qwkQt5TYb7QF
         CnGzvuXiXqiJ315VJfTj4bwDZauyon4Lc2oN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836115; x=1768440915;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=14IDgGs8M+5kC5Gh21HKCq+/QmGHgKYdpYq98QosXLw=;
        b=mm7fZhfrP4LbCGED48Rcmcrh3i7Mh/8n/FVrYyF+R0xyrXdoZl+NyhLIJ4LI1FblyO
         YpTUYP+iknTqn10B3gOMVcKSQuQU4tfIYRFZBl9G3eiSE6y2Ks11RBTAj0EN216k1lo/
         /2uASWhC7a8rgSXDqeozDMhNWFuOidjrxBthCSanJ7T3c36Y6NNrU1piL3yI/lUCEDdT
         WkRCFLQWyGPb7/W8ZH2OawPQlbu2qY/SOkawFQ2pSJUXh/auQWJxOrbMzxKjXpElB+OE
         1EK49mDGkgC1JyJYYqfDyf4IcVGm9u9n+wVwXhbTlqh9mZlsVfvEYTsZDatLkyclBZA7
         m6OA==
X-Forwarded-Encrypted: i=1; AJvYcCV8zhUyVhu+M5a9/cycq+4TguiViI0B9w4At6tweYyWE7fFFmq8zaAsZbp0FZmayo2kY+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3co5pCbtoxIQrmD+ohaeZfnvdJxIPoQ+tbXNSwzfA3gjBiXh
	bXghEzmAS+UYI9Ax5/iaryyqVf2PpootEfYh8LWVdDj1Duh2CvU9HZ2q9lt9Ra14orsiCOSaF8i
	wEFgI6zQ=
X-Gm-Gg: AY/fxX4ZYluERZ5fULQHCByiBLzt29/U6oUzNPySnqiIk4UiXArs/XFgsXtxv+CZY+u
	hE3cBnG1ryZwWrVbhRZNMxr6m8RTqF4VmqIAYiVaDNCvSp5NsghCD2PK6c2BszkTlD9l8KA3PKg
	jbWMkxvsAPecb0ALcJr8bUuU7tUJcWEA7CkMThrw5XK7j54V+W1Z13GqsEDiwpReDJZeLDvDd3p
	h2WdkUuF9IPedHsFN4txRQTD1YLz7Bnl3pDs2ZPEw5SK7GUzxjiIAYtAqMuAN+hodvp1ibiY1VX
	6qCxUEOBBjSSQw7x/IZGDMOCyL91/UigvoJo57xKYwSoWlzWNz+1m52u4y5nba0ugx9loCzYCTB
	1Bul9qYZes3eg44hmMn6GWgrlC0VM9Lv7uOOC/pN/SzpI2RJ82L9NLWbG2H7EDY8aPD1mGCfKbH
	EqfmtpRPT5iqIYbnavixUg0ITHzB8/FjoAIg==
X-Google-Smtp-Source: AGHT+IGqw+vxUKUIU5FrWCpJJ/Aqw5rv95VRDuH3GQ40ZLFe5hSZzJ1j9CE4U0aHfO8yTL9Na+zYRw==
X-Received: by 2002:a05:7300:b09c:b0:2b0:4e86:8163 with SMTP id 5a478bee46e88-2b17d240aeamr2804347eec.13.1767836115340;
        Wed, 07 Jan 2026 17:35:15 -0800 (PST)
Received: from smtpclient.apple ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm9900213eec.15.2026.01.07.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:35:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to softirq
Date: Wed, 7 Jan 2026 20:35:03 -0500
Message-Id: <B952AB3F-16CC-4D28-8038-23DD052D6DDC@joelfernandes.org>
References: <A88C7853-504A-496E-93A2-C9FE7D80E0D5@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 Paul E McKenney <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kai Yao <yaokai34@huawei.com>,
 Tengda Wu <wutengda2@huawei.com>
In-Reply-To: <A88C7853-504A-496E-93A2-C9FE7D80E0D5@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (23B85)



> On Jan 7, 2026, at 8:02=E2=80=AFPM, Joel Fernandes <joel@joelfernandes.org=
> wrote:
>=20
> =EF=BB=BF
>=20
>> On Jan 7, 2026, at 6:15=E2=80=AFPM, Frederic Weisbecker <frederic@kernel.=
org> wrote:
>>=20
>> =EF=BB=BFLe Thu, Jan 01, 2026 at 11:34:10AM -0500, Joel Fernandes a =C3=A9=
crit :
>>> From: Yao Kai <yaokai34@huawei.com>
>>>=20
>>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>>> __rcu_read_unlock()") removes the recursion-protection code from
>>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>>> raise_softirq_irqoff() with ftrace enabled as follows:
>>>=20
>>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack=
.constprop.0+0x172/0x180
>>> Modules linked in: my_irq_work(O)
>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 P=
REEMPT(full)
>>> Tainted: [O]=3DOOT_MODULE
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
>>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:000000000000=
0000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>>> PKRU: 55555554
>>> Call Trace:
>>> <IRQ>
>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>> trace_event_buffer_commit+0x5c/0x260
>>> trace_event_raw_event_softirq+0x47/0x80
>>> raise_softirq_irqoff+0x6e/0xa0
>>> rcu_read_unlock_special+0xb1/0x160
>>> unwind_next_frame+0x203/0x9b0
>>> __unwind_start+0x15d/0x1c0
>>> arch_stack_walk+0x62/0xf0
>>> stack_trace_save+0x48/0x70
>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>> trace_event_buffer_commit+0x5c/0x260
>>> trace_event_raw_event_softirq+0x47/0x80
>>> raise_softirq_irqoff+0x6e/0xa0
>>> rcu_read_unlock_special+0xb1/0x160
>>> unwind_next_frame+0x203/0x9b0
>>> __unwind_start+0x15d/0x1c0
>>> arch_stack_walk+0x62/0xf0
>>> stack_trace_save+0x48/0x70
>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>> trace_event_buffer_commit+0x5c/0x260
>>> trace_event_raw_event_softirq+0x47/0x80
>>> raise_softirq_irqoff+0x6e/0xa0
>>> rcu_read_unlock_special+0xb1/0x160
>>> unwind_next_frame+0x203/0x9b0
>>> __unwind_start+0x15d/0x1c0
>>> arch_stack_walk+0x62/0xf0
>>> stack_trace_save+0x48/0x70
>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>> trace_event_buffer_commit+0x5c/0x260
>>> trace_event_raw_event_softirq+0x47/0x80
>>> raise_softirq_irqoff+0x6e/0xa0
>>> rcu_read_unlock_special+0xb1/0x160
>>> __is_insn_slot_addr+0x54/0x70
>>> kernel_text_address+0x48/0xc0
>>> __kernel_text_address+0xd/0x40
>>> unwind_get_return_address+0x1e/0x40
>>> arch_stack_walk+0x9c/0xf0
>>> stack_trace_save+0x48/0x70
>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>> trace_event_buffer_commit+0x5c/0x260
>>> trace_event_raw_event_softirq+0x47/0x80
>>> __raise_softirq_irqoff+0x61/0x80
>>> __flush_smp_call_function_queue+0x115/0x420
>>> __sysvec_call_function_single+0x17/0xb0
>>> sysvec_call_function_single+0x8c/0xc0
>>> </IRQ>
>>>=20
>>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ wor=
k")
>>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>>> setting a flag before calling irq_work_queue_on(). We fix this issue by
>>> setting the same flag before calling raise_softirq_irqoff() and rename t=
he
>>> flag to defer_qs_pending for more common.
>>>=20
>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_rea=
d_unlock()")
>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>=20
>> Looks good but, BTW, what happens if rcu_qs() is called
>> before rcu_preempt_deferred_qs() had a chance to be called?
>=20
> Could you provide an example of when that can happen?
>=20
> If rcu_qs() results in reporting of a quiescent state up the node tree bef=
ore the deferred reporting work had a chance to act, then indeed we should b=
e clearing the flag (after canceling the pending raise_softirq_irqoff()).
>=20
>>> flag to defer_qs_pending for more common.
>>>=20
>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_rea=
d_unlock()")
>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>=20
>> Looks good but, BTW, what happens if rcu_qs() is called
>> before rcu_preempt_deferred_qs() had a chance to be called?
>=20
> Could you provide an example of when that can happen?
>=20
> As far as I can see, even if that were to happen, which I think you are ri=
ght it can happen, we will still go through the path to report deferred quie=
scent states and cancel the pending work (reset the flag).
>=20
>> current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
>> so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_spec=
ial()
>> (unless the task is blocked). And further calls to rcu_preempt_deferred_q=
s()
>> through rcu_core() will be ignored as well.
>=20
> I am not sure if this implies that deferred quiescent state gets cancelled=
 because we have already called unlock once. We have to go through the defer=
red quiescent state path on all subsequent quiescent state reporting, even i=
f need_qs reset. How else will the GP complete.
>>=20
>> But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state until=

>> the next grace period. And if rcu_read_unlock_special() is called again
>> during the next GP on unfortunate place needing deferred qs, the state ma=
chine
>> will spuriously assume that either rcu_core or the irq_work are pending, w=
hen
>> none are anymore.
>>=20
>> The state should be reset by rcu_qs().
>=20
> In fact I would say if a deferred QS is pending, we should absolutely not r=
eset its state from rcu_qs..
>=20
> Maybe we should reset it from rcu_report_qs_rdp/rnp?
>=20
> Unfortunately, all of this is coming from me being on a phone and not at a=
 computer, so I will revise my response, but probably tomorrow, because toda=
y the human body is not cooperating.
>=20
> thanks,
>=20
> - Joel
>=20
>=20
>> current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
>> so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_spec=
ial()
>> (unless the task is blocked). And further calls to rcu_preempt_deferred_q=
s()
>> through rcu_core() will be ignored as well.
>=20
> I am not sure if this implies that deferred quiescent state gets cancelled=
 because we have already called unlock once. We have to go through the defer=
red quiescent state path on all subsequent quiescent state reporting, even i=
f need_qs reset. How else will the GP complete.
>>=20
>> But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state until=

>> the next grace period. And if rcu_read_unlock_special() is called again
>> during the next GP on unfortunate place needing deferred qs, the state ma=
chine
>> will spuriously assume that either rcu_core or the irq_work are pending, w=
hen
>> none are anymore.
>>=20
>> The state should be reset by rcu_qs().
>=20
> In fact I would say if a deferred QS is pending, we should absolutely not r=
eset its state from rcu_qs..
>=20
> Maybe we should reset it from rcu_report_qs_rdp/rnp?
>=20
> thanks,


By the way, when I last tried to do it from rcu_qs, it was not fixing the or=
iginal bug with the IRQ work recursion.=20

I found that it was always resetting the flag. But probably it is not even t=
he right place to do it in the first place.=20

Thanks,

 - Joel










>=20
> - Joel
>=20
>=20
>>=20
>> Thanks.
>>=20
>> --
>> Frederic Weisbecker
>> SUSE Labs
>>=20
