Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119136;
	b=J6GglE84bs1IEF4mmTmX14M40GP0iuv+dLUMZZHel3UIQK7Pl+Z+cr9mOFlJ7BBFYUNu
	 ZGmD1doFH5qkyR3pgK0jQPp62aE80zw0umpQ28mQZVsosKzMbJfCWkmSBff6vk+YJ1b+D
	 gE1rmfVjtcbv+WsGK0zYE+qSPYO5cgc7w7zmYBXVtDkwUS2WI4AG2XizhDvsAVYg96sjB
	 FMO3p1l9b1kWRDAbNOjlvRgvmdjI46FM1ixuHhXbibM66v+OH6YI1oXt+JnQjfUJtORIE
	 LGpYrA2xj4SpSTBTqzyudSj8WvUS2nuZSGAUAx72hFtqfWLrHeh8sTcplwLriKI4k4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIOYUtjyO3LOx0Dt4B+mTWmj1MQMym+QDsKA8UeeV4g=;
	b=ydu3beOjHenJB84QYmizIADrF9/qApMKRf9x8++m3yKNspWMQRyx64oWVZvfXkpQwoTN
	 hjlM8+keYoFjWXh8UslE4tjPbObsxg0ONf497BiDnQLCiQ0yfr4vb3c4Zk1yaeNQL/1oW
	 7YkI9LlfLBPsH6p1tie7oqkKpIEIOBu5mgW0I6AgjSuloyju7Dd26bA/+myWe07R4Xvm/
	 9FYzhtmwcBAMmhCA84gfYzPtFez6sQ7VzD1DR1bDOvWeNTA672NCENPTdkbGu3xqCV/vi
	 vRsKnvgyoO1ho/nvsZ4SHlnOCJ7AihEKDkfDYwRMK43FmojmRm4QmFRstI/BsFxOKYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDXQ97uP;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74460A260E
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E74460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDXQ97uP
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso221125e9.3
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119134; x=1793723934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIOYUtjyO3LOx0Dt4B+mTWmj1MQMym+QDsKA8UeeV4g=;
        b=jDXQ97uPzLLLVbT5rFYdb1pQTXrcFlnapazDTPLkZZZzwm/dGHfnuIdGyn77eFA0ll
         rVBv/5nJphqBbUw+a2Td1v6GrDeETKSOvgJ16nRoBxrVotcF0qP/50g7KcOxGtryWC0V
         82S7gR4XD6AEFY2bR8wsJHDC2n3MXTp1j8TOVpzctgje8F6Q2LgZxBO6dMNKbxhXYYne
         3ugxFsXqy++IHUeYF5s3xiNkbkoyShdYlrRIi7mhMt3xmm4xnSahUcRjGeZ/Y5Mb2O1b
         ZZicvp4ASkhGLwgqJXFP12i+YmVGlubN6R19iyBxMFtHHqdFJmdg6xkHn698fClqvbJw
         MQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119134; x=1793723934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIOYUtjyO3LOx0Dt4B+mTWmj1MQMym+QDsKA8UeeV4g=;
        b=TU154pv2FJYc5X/6RmtY/MFKeZzNzIDpfJSQsSi2fXSDMEZkPV34y5EhevNVBMhan8
         NNvfrTDoYzSC/uW68ZWmrbF0QABWxn8sOKo55e2jIuLuh5OKO+dvRXQMaeOAopYV8lgK
         wVk1lHhGAc6sNc484VyWiEsBkS1q7dvjA73X6fzyN0x/2MWZDkiO6izv+wNQqwsG/1LD
         4ERtMO8W4Myt6V9tMR6MjWB8WmyLhc1LBPS89AOa5K3g6o5q5wg6gl72SlZFZ2lcWYh3
         q56PkFwLgZ4o6UecjdQvl74H66GXpKguTSgnm6S3YDL/lH8HoTdRQJB9QwIEDmTUzfmp
         S5eg==
X-Forwarded-Encrypted: i=1; AKwUvBzTDz3tbf/OaROEKCh4ULpdYqKGJE7k9XQ8A9yaZbVTSFEYu6WYIwsR/D8M+1g7Gv0w+ns=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhIn3B9VTMNTGRDo6YiRrWjBF4s1sW9X9+vm8/hlKa85RFRmHh
	eeVHbOeKoH6iQc1QWwuehTr83maR2mWRcIAfdOknwxF2/dikyHnNiUCb
X-Gm-Gg: AYBFou0Ee6X7AbVXnChVlopaklVLl7C3i3p4lOxJA1YtMoOTTElSvXhAGGPUJ5FvQpG
	ATzBz/yJ+20qZbB4yXTMMWVa95Ehl8+c9iHR8zj0xEk996dX37JNj5VU+8RVcLoLJ/LHjoy0j/N
	FChflzwlwQqm0U/d3Gn0ptvAPG1PcJVfitgYq/8oziMfhDNPR5IOhWLwAjiJK1MPsPyEhPpHAZ1
	xAVJS3RaLirx5kvaClaDPFSHXIQLZhyfluJQS/WH4UWtkGZCwNrlZHiMuT93gM0rIF62QEwmB9L
	Fqu6ndUxCh0367ugpBnxxosXNuKRW1UZlD+TerKiSKnBQkyshq5MBQydlXbC1oGiYn8joX76bQM
	w8JuvBtDEk8HQlYZslF6gjB6VRqxHFictadYflA1m/uWlbCdrUn4Cv17+YiIGn2xyucVXltBs5G
	ksz01p3V8RyIj76XZtJJKipARQZqC7j4ososy/n1D7lDKsC4INwYd/Gg5HJGaO/DnGP4MSjB7sv
	OnR70d37AQ73mW+lnUQgzr6CdV9wfoBr0mRu/YCuNn7HVP2YmCwZjZDb34X52YdZYElR6GWvXx7
	xNIgOBOmQbBr9PGlCS8KBMslzis=
X-Received: by 2002:a05:600c:8114:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a35aca4ab5mr173697125e9.22.1793119134362;
        Tue, 27 Oct 2026 09:38:54 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92c21df84sm2358195e9.15.2026.10.27.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:38:54 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH -rcu/dev 3/4] hazptr: Do not warn when a backup slot is released on another CPU
Date: Tue, 27 Oct 2026 17:38:05 +0100
Message-ID: <20261027163811.2470569-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027163811.2470569-1-parri.andrea@gmail.com>
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_HAZPTR_DEBUG, hazptr_release_debug() warns when a hazard
pointer is released on a CPU other than the one that acquired it,
unless ->detach_cpu is set.  hazptr_detach() sets it, and so does
hazptr_note_context_switch() when it promotes a per-CPU slot to the
backup slot.

__hazptr_acquire() can also put the hazard pointer in the backup slot
directly, when all per-CPU slots are in use or the pointer changes
under __hazptr_try_acquire().  Nothing sets ->detach_cpu then, so if
the task is migrated before the release, the check warns although the
backup slot can be released on any CPU.

From hazptrtorture, with CPU hotplug and readers that nest a second
hazard pointer, as "hazptrtorture: Nest a second hazard pointer in
readers" makes them do (without the nesting, 30-minute PREEMPT and
NOPREEMPT runs do not hit it):

    Hazard Pointer (addr=00000000e2979b1e) released on remote cpu without context switch. Acquire: caller=hazptr_torture_read_lock+0x43/0xb0, pid=80, cpu=0. Release: pid=80, cpu=1.
    WARNING: ./include/linux/hazptr.h:293 at hazptr_torture_read_unlock+0x80/0x160, CPU#1: hazptr_torture_/80
    Call Trace:
     <TASK>
     hazptr_torture_reader_tail+0x88/0x250
     hazptr_torture_nested_reader+0x6c/0x90
     hazptr_torture_reader+0x2f5/0x550
     kthread+0xdf/0x110
     ret_from_fork+0x179/0x240
     ret_from_fork_asm+0x1a/0x30
     </TASK>

Set ->detach_cpu when __hazptr_acquire() falls back to the backup slot.
The remote-task check still applies to such a hazard pointer.

The false positive was found with the help of an LLM.

Fixes: 3d48872eb74f ("hazptr: Introduce CONFIG_HAZPTR_DEBUG misuse detection")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 kernel/hazptr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index b15b84ebd4ceb..b06164aac3a70 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -112,6 +112,10 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	 *   synchronize forward progress.
 	 */
 	slot = hazptr_chain_backup_slot(ctx);
+#ifdef CONFIG_HAZPTR_DEBUG
+	/* Unlike a per-CPU slot, the backup slot can be released on any CPU. */
+	ctx->detach_cpu = true;
+#endif
 	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
 
 	/* Memory ordering: Store B before Load A. */
-- 
2.53.0

