Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A533A8384;
	Tue, 15 Sep 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481869; cv=none; b=iwVbxETh64LtlHsLzoVJiwigTP7JUia9mGMzH8Eli20pEbmwXcMeegBfy/TxgXLSXrcaMHM1ov6MG3vXl1ZvhcsDsg6jS3ZwzyYbgA8aOYkzu3U4JGicC+e7BjffeczMv8A3jHku0DEWnsczhL3zzrB+f7UptKZoazNDe/ADcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481869; c=relaxed/simple;
	bh=GSBXBpX3k61wKZRiyorDdlVGTnvYP3dNajlSBtHshzo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fk7FaEgpmtKAuXJKQlHkQ1yp0BgK5EDlZAudNL+S/v8tkEEun77XX96oa21CGYWSPlIvPaX98EuVHtg4qAs3vwonO0/Yt79c9D0l3FUCDUCJQsUnd5WJ5nExTP2yn3ee1uJGf8KBf/LGCNDK0dMwSeIlRebGZgcRlORLzimf+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5hKV+gK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5hKV+gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C088A1F00893;
	Tue, 15 Sep 2026 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481868;
	bh=rJvpLOWtutAdyJcIT4Epm9F/ufbvJwi0dK09wh/lipY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b5hKV+gKFGEYB++V/g0LCzL6EdpH+9azJH56tU91B+MKNmFVYfcfubRI+Z6jUwjfZ
	 SEgnOeBs3bmkgqS7C1Kidx46+6Kxlpini01Qx0s2uUnpLOI7mdUSrPeOa7Y8lWQwY/
	 btfzDnYi+pjxUhgfSmgahplYapkq5Em2dbm/YNQOGAaK8WFvoovMEXiE7Xnr5EIpTo
	 8T6NeN//BDqwnyiMsnnAdm0lV97sGWugDZOU071h2RnNzNKJGDyAPMaQLiNiRqiaHf
	 B+gACGttwahZzLIHSCmZ+UYbizeNXEZ+OsDwsHi8Uan3ZCzG/CrX19BajbqyLIeDGI
	 ohwSxRnyNQGUw==
Content-Type: multipart/mixed; boundary="===============3131281285391241463=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3244a34236665e0602fc3f0b56fb74cd94e8f741d4946749ca9c67578acf2ee@mail.kernel.org>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-1-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-1-0ad30c4c5ee7@toxicpanda.com>
Subject: Re: [PATCH RFC v3 01/13] entry: Pass pt_regs to irqentry_exit_cond_resched()
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,boqun@kernel.org,tglx@kernel.org,peterz@infradead.org,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,catalin.marinas@arm.com,will@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,paulmck@kernel.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,boqun@kernel.org,tglx@kernel.org,peterz@infradead.org,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,catalin.marinas@arm.com,will@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com
Cc: luto@kernel.org,josh@joshtriplett.org,urezki@gmail.com,mathieu.desnoyers@efficios.com,jiangshanlai@gmail.com,qiang.zhang@linux.dev,jgross@suse.com,mcgrof@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,rcu@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,xen-devel@lists.xenproject.org,luto@kernel.org,josh@joshtriplett.org,urezki@gmail.com,mathieu.desnoyers@efficios.com,jiangshanlai@gmail.com,qiang.zhang@linux.dev,jgross@suse.com,mcgrof@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,rcu@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,xen-devel@lists.xenproject.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 14:17:44 +0000 (UTC)

--===============3131281285391241463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 2c64b388f6164..3d85035f5624f 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c

[ ... ]

> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index 0bb6c03481fad..b811b469b0a77 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -346,21 +346,21 @@ typedef struct irqentry_state {
>   *
>   * Conditional reschedule with additional sanity checks.
>   */
> -void raw_irqentry_exit_cond_resched(void);
> +void raw_irqentry_exit_cond_resched(struct pt_regs *regs);

Should the kernel-doc block above this declaration be updated with an
@regs parameter description? Every other function in this header that
takes a regs argument documents it (for example, irqentry_enter_from_
kernel_mode's block has "* @regs:	Pointer to currents pt_regs").

Also, the kernel-doc block documents "irqentry_exit_cond_resched" but the
prototype is "raw_irqentry_exit_cond_resched" - that mismatch currently
prevents kernel-doc from checking the parameter list, so adding @regs
wouldn't trigger a warning yet, but it would make the documentation
complete for readers of the header.

[ ... ]

> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index e3d381fd3d251..e4acd50bd81a1 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34975311706
--===============3131281285391241463==--
