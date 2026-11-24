Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558313;
	b=2FfhspBBnJ/pek2EYpsioApDXCMCfIjplgTXSrIThKPcB2gsZUHKH0YBmrXt7uJeXEtA
	 bOF5+CR+cYNH7AvoFlkVglQrpuwJFTXCliNc77XqX42wO1vL5k/C8DwFj5W2s8Tl+j+gL
	 /RDPCmTirZK+5XbbzjFRtleJaq0Ktg6j7uU9w5KcozuzuUkX8B2eJwdDqYd6LbgmLKDmi
	 xSQaeoGjfezzw/oNsExVfWAsxM6YupbiXQXEuKf/hyW4/evNB4PvMKCg+WqKeuYaQvf/K
	 m1sWjlz7hFR7Tws/t1K7u75D+GNo1txTZuVRfFs9Cehj4j5DLEXYBEEXN7Ft6Y/yDlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558313;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rOPoxz8WrRhhiqOkFhj1QitT4Havi0HdNhUP1VJbZPo=;
	b=O2mmM8Gc8HEG1zJaBy4jKGSA2u33R91E5Yh0pN6XbXaHPu/e2tO1SICudQ/DAI05WdEz
	 O2X1/BrA7VaFH8m2I7odiPfwCnQ3LMm1Cv2lXgYKReUeliV1Go8WwV4XCudEWHM6D7ZcZ
	 arcEcod0OhHgnCMNGP3fpwtOf6TUo4/HSclLlMFKRxN2XFc/v+gQUCEjQSSQrR32ZBkK7
	 4FO8eEW70VFJtbFCA5TZnvhMnuax4ryAvmgi6WgbFiQmkFdfdjt3DrC/PLpBvAtZN2Uf2
	 KqqNSsPmo1NBeHk+8zauC3lqXP0M4DeItKc+4KkIsy7e8cOiIpItMbQdK6UDx2l7P9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SPDI1+TE;
	arc=none smtp.remote-ip=95.215.58.168
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4597606A323
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 22:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4597606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SPDI1+TE
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1exNnXtNN18n5Ncp+78T01qFoaQmDQQwLTH3J8SLk6Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795558310; v=1; x=1796163110;
 b=SPDI1+TEcY5AnELc149oKmjBbVoclRqhPh/LuyKC+vG6jeEKtQqa52k2flhr1m0oPLaTUyzL
 2O8a295yD/b/R0b3tcVzE+oaOlhqaMT1MsBgl3ZvJbCLPOXsgcVdKkt60ZZHpCBhgDocoFbxZtO
 JwFxRe6mRZTRZpNbgiTalk1A=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c1096aa2f557005;
	Tue, 24 Nov 2026 22:11:50 +0000
X-Mizu-Trace-ID: 8c1096aa2f557005
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 22:11:51 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: alexei.starovoitov@gmail.com
CC: boqun@kernel.org, bpf@vger.kernel.org, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rhkrqnwk98@gmail.com, rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
In-Reply-To: <DN3QYI65E4KR.27D6XBG0SUWVI@gmail.com>
Message-ID: <F6FC9F7A-43BE-44E4-92FD-034AB96A1C3C@linux.dev>
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

On 24 November 2026 21:08:46 GMT, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>On Tue, Nov 24, 2026 at 10:56 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>> The BPF trampoline calls rcu_read_unlock() on its exit path. If the
>> task was preempted in the RCU read-side critical section, this ends up
>> in rcu_read_unlock_special(). When a BPF fentry or fexit program is
>> attached to rcu_read_unlock_special() itself, the trampoline runs again
>
>Not quite. need_qs and exp_hint set rcu_read_unlock_special.s too,
>no preemption needed.
>With fexit it recurses on entry, before the prog runs:
>
>  __rcu_read_unlock()              nesting 1 -> 0, .s != 0
>    rcu_read_unlock_special()
>      __bpf_tramp_enter()
>        percpu_ref_get()           nesting 0 -> 1 -> 0, .s != 0
>          rcu_read_unlock_special()
>
>> -static void rcu_read_unlock_special(struct task_struct *t)
>> +static notrace void rcu_read_unlock_special(struct task_struct *t)
>
>It should be fixed on bpf side. Only the bpf trampoline recurses.
>ftrace, fprobe and kprobes take ftrace_test_recursion_trylock().
>notrace takes the function away from them and from livepatch.
>__rcu_read_unlock() is in btf_id_deny for the same reason.
>
>
>diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>index e7013ed..0e8afc0 100644
>--- a/kernel/bpf/verifier.c
>+++ b/kernel/bpf/verifier.c
>@@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
> #ifdef CONFIG_PREEMPT_RCU
> BTF_ID(func, __rcu_read_lock)
> BTF_ID(func, __rcu_read_unlock)
>+BTF_ID(func, rcu_read_unlock_special)
> #endif
> BTF_SET_END(btf_id_deny)

ahh crap, brain fog, sorry.

yeah, this approach looks good, again, looks correct to me, won't blow
anything up.

If a patch is submitted:

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

> 
>Pls target bpf-next.
>
>pw-bot: cr
>
>


--- Thanks!
