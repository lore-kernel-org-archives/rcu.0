Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601E40860E;
	Thu, 30 Jul 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410491; cv=none; b=Puc9ZwYgadZ2nN95GfW4ddEdZ1Z/GceFCwgb95NvGn+bg9GO6+aT4vfYRaLHlrRp1DeBKBN+BhRHdoVeuCWA4/L+hR8vmNPE3OT4LzOjNo3RObNzW6ZARJ6UsutdW+bsI6LPGMIee6NEuZTS75zEipb93zIwg0bpsLodbhUsdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410491; c=relaxed/simple;
	bh=ZUiDRzRwPx3KGgaI1/GWF2qfluYCznYBJnvDMqpl78E=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=QuiD8fZ/+YwDOAeUlmov/+MCQ6LYKxFeIZPr0nLjTzujABDEiNMmReEb1p+XMLyafAaPpZgPy1OJMbl3BqZoUvWozJcEj3bF1wM+M0YiOb88F01ITen5X3LSCyU2yP6zmwis/Hn2yatiZfaEb0JwfFViaxHnJ4vFBAEFCrSs0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h9mx11HjMz8XrrM;
	Thu, 30 Jul 2026 19:21:25 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 66UBLG7H073757;
	Thu, 30 Jul 2026 19:21:16 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 30 Jul 2026 19:21:19 +0800 (CST)
X-Zmail-TransId: 2afc6a6b33af5fd-db3e7
X-Mailer: Zmail v1.0
Message-ID: <20260730192119586UvhYMv4xrNqaZLKIJH9X0@zte.com.cn>
In-Reply-To: <20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org>
References: 20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org,20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org
Date: Thu, 30 Jul 2026 19:21:19 +0800 (CST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <harry@kernel.org>
Cc: <vbabka@kernel.org>, <akpm@linux-foundation.org>, <hao.li@linux.dev>,
        <cl@gentwo.org>, <rientjes@google.com>, <roman.gushchin@linux.dev>,
        <ast@kernel.org>, <andrii@kernel.org>, <puranjay@kernel.org>,
        <ameryhung@gmail.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <neeraj.upadhyay@kernel.org>, <joelagnelf@nvidia.com>,
        <josh@joshtriplett.org>, <boqun@kernel.org>, <urezki@gmail.com>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <qiang.zhang@linux.dev>, <pfalcato@suse.de>, <surenb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
        <bpf@vger.kernel.org>, <harry@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAzLzhdIG1tL3NsYWI6IHVzZSBjYWxsX3JjdSgpIGluIHVua25vd24gY29udGV4dCBpZiBpcnFzIGFyZSBlbmFibGVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66UBLG7H073757
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 30 Jul 2026 19:21:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6B33B5.000/4h9mx11HjMz8XrrM

Harry wrote:
> call_rcu() disables IRQs with local_irq_save() to protect its per-cpu
> data structures. Therefore, if IRQs are not disabled, they cannot be
> corrupted by reentrance into call_rcu(). So fall back to the deferred
> path only when !allow_spin && irqs_disabled().
> 
> The RCU subsystem does not guarantee this contractually, and this
> optimization relies on RCU's implementation details. Ideally, it should
> be removed once call_rcu_nolock() is supported by the RCU subsystem.
> 
> Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/slub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2c5ba8c326e7..bb0f2975c95b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6157,8 +6157,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
>      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>          rcu_sheaf = NULL;
>      } else {
> -        if (unlikely(!allow_spin)) {
> -            /* call_rcu() cannot be called in an unknown context */
> +        /*
> +         * With !allow_spin, we might have interrupted call_rcu()'s
> +         * IRQ-disabled critical section. If IRQs are not disabled,
> +         * we know that's not the case.
> +         */
> +        if (unlikely(!allow_spin && irqs_disabled())) {

LGTM!
Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>

I initially wondered whether in_nmi() should also be checked here.
However, irqs_disabled() already covers the relevant reentrancy case,
since call_rcu() disables IRQs while modifying its per-CPU data.

The reasoning looks sound to me  : )

--
With Best Regards,
Shengming
