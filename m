Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818893;
	b=uj3mDnrqjNSPx9daWCCzTDzMYtROxViWqH5t7jqIK66cd1FA98Vhg5DK871QRCTmc8If
	 4GXv08XtSuPcAN1rVfXTl3kFfZxN2CKjfmymB1rVnHI1FNtuD5LaChZF4gcpLfjOSEXB3
	 3smgnLu/G1R7Ba0pLq+wGCh34EchWholtRs4bE2csTMTcoFne4Fk3rKSwmWT9K4H/KBv8
	 ppAhLHhxiAbhrkezrM+iKwBKlOA0zI1zfqpGzNKfcQ6so4ePviNjDgUUWwjdZYYq4akI5
	 erdu0E6jVsr72mYCQdWDea/tht+DPN0Eb7VdzUKDz8Ji+fYQst9Yot5Og5CFdmZIBVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818893;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=agSk+cFPktjD4lmleaUPN9v5OCRHldmWtEkAJi2dW2s=;
	b=sOeuGxsk2l5JkYbSUoDW07Ms8HHnoEzvmegyNEMAuSHaQnfEg/uZ/0AIJpKW4N3Leyft
	 Q2K6L+RQzdl9uiDgGD6Fr9XNPUxE1MIkxgk3jSfyX6KeVTOvbfqOa7PReycVlnGbJRZ2g
	 bgAaLKb0UAPlrZt+cFvas5zwWszCA/iBqLqovoD4Fvhs0RPdbm0cBhfiDO4BxMntstDov
	 nPKDnaBth3daJOFREIJYuaKHwSKpSqCQEI6n83IdxMpeMFVkEuvnz0HyGF12fbmFXxd2i
	 lUp2mrolvmNpwdmfalwrFg9FJyC1GlcchGGVvxdHCKzQKNSe6czaGoFDWCyH/nJuqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="SRAUb/GV";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=BrYsymwf;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464FF606A31B;
	Wed,  4 Nov 2026 19:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464FF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=SRAUb/GV;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=BrYsymwf
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793818883; bh=agSk+cFPktjD4lmleaUPN9v
	5OCRHldmWtEkAJi2dW2s=; b=SRAUb/GVki4GpidZse7+3EsGLr/rK7VIUjf5XkxwWtAR+GjSye
	rO+JZJMWr4ulT5YjFK81VHHIf0Ah8/UAjVrKzUUBI4IBjfdTYx0rBYOCIaVqOJAw3sIN0gi/3Fi
	y27G+QeKjt1ILV+YaNMxf9coQt3zcGf4Uecblhc6LLCDRmoml38o3HeDCzJX3tZL92+BYkItuST
	XUDS/SIF07Z79m2A2alWvGhnuJmkOE+QwpVptkTVFh65zuA2dsIcWjHtv76i58SvjvCN62M46ds
	XHv7yDsi1stEUP5p6xcrzrL3Q+OAFNAJoYoVT4szncJnOjRlOCvoNwHr9ok0uxJ8UcQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793818883; bh=agSk+cFPktjD4lmleaUPN9v
	5OCRHldmWtEkAJi2dW2s=; b=BrYsymwfmY+Jp9PuQnFzb8bV5OJT7hhOEcP97qdIjA+lZnzSwI
	9WYQncpk3bt4oRSUerevyLwwvdIgWdX8PoCw==;
Date: Wed, 04 Nov 2026 19:01:24 +0000
From: Bradley Morgan <brads@mainlining.org>
To: joelagnelf@nvidia.com
CC: boqun@kernel.org, frederic@kernel.org, jiangshanlai@gmail.com,
 josh@joshtriplett.org, kunwu.chan@gmail.com, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH] rcu-tasks: Track barrier callbacks in debugobjects
In-Reply-To: <20261104153046.965890-1-joelagnelf@nvidia.com>
Message-ID: <3AB3C8E1-9709-4F46-8283-27CAB4A264D6@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 November 2026 15:30:45 GMT, Joel Fernandes <joelagnelf@nvidia.com>
wrote:
>rcu_tasks_invoke_cbs() now unqueues each callback from debugobjects.
>However, rcu_barrier_tasks_generic() inserts its per-CPU barrier heads
>directly with rcu_segcblist_entrain(), bypassing the queue hook in
>call_rcu_tasks_generic(). This produces active_state and deactivate
>warnings for untracked objects when a barrier callback runs.
>
>Activate each barrier head before entrainment and undo that activation
>when there are no callbacks to entrain behind. Successful entrainment
>is balanced by the invocation path, as for ordinary callbacks.
>
>The existing n_barrier_cbs=2 torture test reproduces the warnings before
>this change and completes without them afterwards.
>
>This fixes patch "rcu-tasks: Detect duplicate callback enqueue".
>
>Cc: Kunwu Chan <kunwu.chan@gmail.com>
>Cc: Paul E. McKenney <paulmck@kernel.org>

Thanks,

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>---
> kernel/rcu/tasks.h | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>index d5d060a5c4b6..a20db323612b 100644
>--- a/kernel/rcu/tasks.h
>+++ b/kernel/rcu/tasks.h
>@@ -470,9 +470,12 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
> 			break;
> 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
> 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
>+		debug_rcu_head_queue(&rtpcp->barrier_q_head);
> 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
> 			atomic_inc(&rtp->barrier_q_count);
>+		else
>+		

Wow!
	debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
> 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> 	}
> 	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
>

--- Thanks!
