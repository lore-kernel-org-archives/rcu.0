Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208615;
	b=0732HVFJi2nm8dRuXzgi2B9QuADOQxP9hGASJFtez6/hEM4/WFm8y5N/CvLrANYRac1+
	 HwZKHydaZecF/ouNMvSe7lN/XEt/KfN6FXoxxy2UiebwyfrbAhb++dUkzqapocmgFj755
	 46I58za1WkFzHqigKl3A2eJDK7p6TNDFGJhGw/ukufrogjkGBUK9ScgNHRb+uTA0oi91j
	 S4TIT6p1JQgbK5g33OJYzGzm2QgIRgH4o0oHspO3KAJp/D/buk0+FFqHB2/zAC6EZTgSH
	 csdTMO8AbhnpKR6EAuin4zy08Ktw0zhv0KMXiZi9VfQlcGmxL+/h+i3uPKZH2G/n5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208615;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8Nt84TnHQ+TaYGknZlTszyhNfDuEosB1hOb+5gllpAA=;
	b=dunmlAM5x/1l6bFlZLD8MgTFsqjWWoglirsBwLoNvVqhFnzwYYML/kBKjHltcOvGJRHF
	 c945Fa6NDRN/0DjfomTdy+EgPAURPAQPIGn/dF6S1fFZlxx4XDDWGdpWe5pkLQAxNi3bD
	 2YAMSUmnG5U9+a05FCDEIoLG6uGETH9K8YsijsqgNktXutZO1Vf7q1Li8AKKBcawMP2bl
	 Ia6Yt7f9Li8Swne0uBzxqpha+CXSmbXueOyVcL+HzGvR41tvqn6qX9zK2EkaN7DpYZ5Uk
	 ULalSSaD6KmXZnnty0vEzNj87KAuN6Do1cLHGLdwpn3XrCkGfogTYFGXlGYB72B0D7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=bqVyZiZy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b="YjBgM/Gs";
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4C606A31A;
	Wed, 28 Oct 2026 17:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FC4C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=bqVyZiZy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YjBgM/Gs
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793208603; bh=8Nt84TnHQ+TaYGknZlTszyh
	NfDuEosB1hOb+5gllpAA=; b=bqVyZiZyFCps9UXd6hcbK4kf8kXhPTJGsXv6KBi4tI1XTQUn9G
	dAzk+wS3PLftjaGj8OeuQUv72i0slUXPbchvRae0PfaMVKqucdCAQRzT18/YsQPJLoAZxhcxHi+
	QLmm+rqc4JfEKoNtDx8ywYTM2pukIZECQslL9+tG4ujh+Y/LvgNkDFix2KZQUPGngrFQtuZSZ9+
	eboIa9J7HjwAHGPgMcpiY1AYRNgZN/IdlVo1InhrP9gg0EIzH8tFzJzJeVvs/vGqIyY+Zm31m0O
	5WHRqRsmmKUKzQQQkitrGd29ZALcym8sIvXc6qyx/vPrFvusDjLc2PJcFtlM4UZkT5Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793208603; bh=8Nt84TnHQ+TaYGknZlTszyh
	NfDuEosB1hOb+5gllpAA=; b=YjBgM/GsLKmZyxnaoLCZ7LyRolUKQcM3G0xtB7StLcjTmY3jsG
	JRP4nqINTEfoiOwrh4TCrqm5vvAe1QOiaVAQ==;
Date: Wed, 28 Oct 2026 17:30:03 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Andrea Parri <parri.andrea@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Gary Guo <gary@garyguo.net>, Kunwu Chan <kunwu.chan@gmail.com>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_-rcu/dev_3/4=5D_hazptr=3A_Do_not_warn_?=
 =?US-ASCII?Q?when_a_backup_slot_is_released_on_another_CPU?=
In-Reply-To: <20261027163811.2470569-4-parri.andrea@gmail.com>
References: <20261027163811.2470569-1-parri.andrea@gmail.com> <20261027163811.2470569-4-parri.andrea@gmail.com>
Message-ID: <E9999478-EEF8-4CD6-A042-2E65D96FFE69@mainlining.org>
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

On 27 October 2026 16:38:05 GMT, Andrea Parri <parri.andrea@gmail.com>
wrote:
>With CONFIG_HAZPTR_DEBUG, hazptr_release_debug() warns when a hazard
>pointer is released on a CPU other than the one that acquired it,
>unless ->detach_cpu is set.  hazptr_detach() sets it, and so does
>hazptr_note_context_switch() when it promotes a per-CPU slot to the
>backup slot.
>
>__hazptr_acquire() can also put the hazard pointer in the backup slot
>directly, when all per-CPU slots are in use or the pointer changes
>under __hazptr_try_acquire().  Nothing sets ->detach_cpu then, so if
>the task is migrated before the release, the check warns although the
>backup slot can be released on any CPU.
>
>From hazptrtorture, with CPU hotplug and readers that nest a second
>hazard pointer, as "hazptrtorture: Nest a second hazard pointer in
>readers" makes them do (without the nesting, 30-minute PREEMPT and
>NOPREEMPT runs do not hit it):
>
>    Hazard Pointer (addr=00000000e2979b1e) released on remote cpu without context switch. Acquire: caller=hazptr_torture_read_lock+0x43/0xb0, pid=80, cpu=0. Release: pid=80, cpu=1.
>    WARNING: ./include/linux/hazptr.h:293 at hazptr_torture_read_unlock+0x80/0x160, CPU#1: hazptr_torture_/80
>    Call Trace:
>     <TASK>
>     hazptr_torture_reader_tail+0x88/0x250
>     hazptr_torture_nested_reader+0x6c/0x90
>     hazptr_torture_reader+0x2f5/0x550
>     kthread+0xdf/0x110
>     ret_from_fork+0x179/0x240
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
>
>Set ->detach_cpu when __hazptr_acquire() falls back to the backup slot.
>The remote-task check still applies to such a hazard pointer.
>
>The false positive was found with the help of an LLM.
>
>Fixes: 3d48872eb74f ("hazptr: Introduce CONFIG_HAZPTR_DEBUG misuse detection")

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
> kernel/hazptr.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/kernel/hazptr.c b/kernel/hazptr.c
>index b15b84ebd4ceb..b06164aac3a70 100644
>--- a/kernel/hazptr.c
>+++ b/kernel/hazptr.c
>@@ -112,6 +112,10 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> 	 *   synchronize forward progress.
> 	 */
> 	slot = hazptr_chain_backup_slot(ctx);
>+#ifdef CONFIG_HAZPTR_DEBUG
>+	/* Unlike a per-CPU slot, the backup slot can be released on any CPU. */
>+	ctx->detach_cpu = true;
>+#endif

Makes enough sense.

> 	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> 
> 	/* Memory ordering: Store B before Load A. */
>


--- Thanks!
