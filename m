Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795846826;
	b=hebaVsV5ED4AF+LAOx8sJY4q0qZvsRAKWG7cDfwwA9896lnOYosdKoSW/Ir3O7rkluED
	 R6N7WtJ01HlkYNU8SdSoPNkCHucPw3kDvhAx8qhHt+tMXnAOKnGikhC6psDNENnfYm11I
	 R+/BFng9SHjdpyJn1uIMC25phq4v7H+EC5KwOzzlyr43pGRiKa16Nxkvm3g8rdulV1ER/
	 2dWRX0BAVWgg/fxCMHNEhCuL7gZ2OkZfxHM0B8VCFBcl2QTz76Bdh634dLhc7/mjook5o
	 Xib7vgTNU0KYSX/RjOj9QsWPa+wiYwx69y6eg1tE36mx0oPvYESahQ5e5dfdaA3ncvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795846826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2hMGbCM5tB70FBdwb9zAs1NZJOT/JT/9Od6CekBUEzc=;
	b=XpudQEaLVJfIZR8n7FfeezPGVrbJ7czKO1IXDNXximesjdI79X7Q0JX9KNgTy1un3qAh
	 sisdEqLqZcQMalKm372T54EUNOb+hVXwr0LtRqdnCyHH45x2Cb4oE68CaaUlzSlHIvftI
	 hbmqHz9xr14NqwZPd+26hKc8zJ0H7O3/M8pxLvNzdmEAFC9nKwwOneX1chlgTcx/dKp+7
	 U8P4S/qjBJJp1Wu2FL3Qka6gswaZV1DeTqyP/OHJ1Oy29xMHoX39YGmTrMjqh9YxFBnyB
	 CvKeYjv2OF8C2nexlPEr9MXU0KnnKwJtwpwX8q4e81ZjmQJOk+SPQq7U7MF7fqFiqPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prak9o+R;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A8606A31C
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B91A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prak9o+R
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso5078558a91.1
        for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795846825; x=1796451625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hMGbCM5tB70FBdwb9zAs1NZJOT/JT/9Od6CekBUEzc=;
        b=Prak9o+RMwLOyAisXlGs9WAiPIXX6RSG2RFdsICD7cJpTtubAiSuZz1Vksg4WpjDc8
         BRWsJaaPbG7XoLe92Mv+C/BXf8THgs0uJ0uZpMFeYYhUHMm2p7WO+1mbddZvAj1uVVJ3
         SP8VWqY8VwZKpE0PqKNsQpvxDLHd6PXX1bq77qBbAzFGACnrS4/+biDTl57BCbmMSdNI
         mkohNqR4Mh0GoyX+Z+O1XVXXk+1QZxEPIcjWEvf7aXM3MyLwFuWYndrx5Ty9MFquX0y6
         0/BlJHEo615HqfrTEsJvEwTRL7sjxW1TPCqsWclVlmktRoBMt8foNPajsfbDGUDqn2/o
         n0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795846825; x=1796451625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hMGbCM5tB70FBdwb9zAs1NZJOT/JT/9Od6CekBUEzc=;
        b=2ISw4r40JC5bCRoIq69W1iJODqwwXCnYq4BR8GwG5ZHkYpYLWzQgqSmgIiNy3EjSUP
         Sc5yuz6gyRPG4tUi+tTAYDxCD7zA81FKZYFyLjlVCfggRV/FsxtvW0nGSJFAh3BTWGbz
         vHXIGQA8iAa3HIRcHX/3oTZm2VsfLhSFgbLxjAeAK17BH/mmztgKHCC7T52U0MpzJ2Pb
         pffNgGgrYxt9CCOxf6n8SzOGZlSwIRlZpqe35z3MLdxEetBrz5s58Up4GZ/FURoIUbGM
         EG3t/9PKXr8nL8GSgiiMCxmJV4DLKj29/ZIfqHEslfvtNASbDKG0/PTfHmiSVzOtmVRQ
         lqGQ==
X-Forwarded-Encrypted: i=1; AL+hErE9S+99uOmT7ICvSQus04IW2X4Apq7fObmC4+7aUERj6iDhWOFO3d6ilDXiLFvCTiM159U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hJrX7DgMNoMnmyLBXRgzi8NOT6RLRKTWhfDfsiJZZbrZNBaxm
	mlss9vKoT+pDEN73sX0Bd1lVRCojkzXlFke8iKNktgIBD+GMmn+1fOLs
X-Gm-Gg: AZFdTZdTn39n1K3sQlTif7OqVu/TUNE0yGKX/ZpHWKoMiOXeM0lZLp4nrU7fmRDyy4h
	TcmJN+6C/UvXmi5FEXKDXncAKrVwTRPCx6IML8/d40rU+/z16JoqxXdio+H2haEYWeoUgNM9jOp
	4b5xcCx9Soay518pTco3H6YHxi4xqkFyVI3Lb7e+Kto/Bwx3rPuzzxvHfJaneI6dPuLnV36T7hu
	kTKn62yFmJXy1ufbcFyq87+q859e1y8pQGD3CM5aCRqpJZ4sSFLMQG+503+YyFHyPzRAq7Zc/sv
	NThpcE3ub1iEStRmpUvZwhzC1hXXs3I8ZgK8HqggTTBxoWU/y/J7XkWP2hHOkPrhcwfMnqbFpn+
	g/EMOHLVcL5gU2zRsag+Eict1X1wYzsjOQqT2YQUyZhw0hkVQEmc8eIKSmE8xLgBgTbiGOs3lqn
	0Bls9m3lVcLkHIKIA+AN9qtGnqX9culFVFHZByJyUVAh9b0YLqdK2rDaCoNckHkWCi1zVYYdHQP
	Lvozm5D/Pu9dYqANK0RXV1XnTvTZShJIN4ceP2jd16slxRuXt5awcVqyrf4SkKrxLHlFxwjktMf
	1f9w/e65aXU3D+jjl0MaluC6Ivj3c3r+/X1XymHX7bagS2xO8hMMMC8LRBy/gR5U
X-Received: by 2002:a17:90b:5350:b0:3b3:b414:9aaf with SMTP id 98e67ed59e1d1-3b41c93b4admr17215431a91.27.1795846825015;
        Fri, 27 Nov 2026 22:20:25 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm32008126a91.9.2026.11.27.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:20:24 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] rcu: Mark rcu_read_unlock_special() notrace
Date: Sat, 28 Nov 2026 06:19:26 +0000
Message-ID: <20261128061955.174288-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The BPF trampoline takes and drops the RCU read lock itself. When the
outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
calls rcu_read_unlock_special(). If an fentry program is attached to
rcu_read_unlock_special(), the unlock on the trampoline exit path still
sees .s set and calls rcu_read_unlock_special() again, which recurses
until the stack overflows:

  BUG: TASK stack guard page was hit at ffffc90001657ff8
  ...
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   __rcu_read_unlock+0x9c/0x120
   rcu_read_unlock_migrate+0x93/0x220
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   ...

With fexit it recurses even earlier, from percpu_ref_get() in
__bpf_tramp_enter(), which takes and drops the RCU read lock before the
program runs.

Mark rcu_read_unlock_special() notrace. rcu_unlock_needs_exp_handling()
also runs with .s set, so mark it notrace too.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v4:
- Go back to notrace as in v1
- Also mark rcu_unlock_needs_exp_handling() notrace (Alexei)

v3: https://lore.kernel.org/bpf/20261125055359.2715140-1-rhkrqnwk98@gmail.com/
v2: https://lore.kernel.org/bpf/20261125040106.2200628-1-rhkrqnwk98@gmail.com/
v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/

 kernel/rcu/tree_plugin.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3500e4874833..9c1b227f5fa0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -689,10 +689,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
-static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
-				      struct rcu_data *rdp,
-				      struct rcu_node *rnp,
-				      bool irqs_were_disabled)
+static notrace bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+						  struct rcu_data *rdp,
+						  struct rcu_node *rnp,
+						  bool irqs_were_disabled)
 {
 	/*
 	 * Check if this task is blocking an expedited grace period. If the
@@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static notrace void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;

base-commit: 2348d158c7fcc2c9557b2fb550ee841c62942fbd
-- 
2.56.1

