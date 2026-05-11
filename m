Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5EB36D9F8
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522097; cv=none; b=Npkg2JU5Gpv4RG9gLP1izcnuwIep2jhfqUvSsG/trsHFy2LVSBZ0b3V56GBosY/wMj760mHxypL3YwEYrPpiAfIFYUZuQ/IkrZhtYPZJchOd0ZC9/sFU7NqC53Bnoe/feVA5c9YlejyV77kOPIT6iMcUAiI45TQO/Kyfaz0K8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522097; c=relaxed/simple;
	bh=1gqbdSXuc2lYJ9G7B+thJWtUos0MtzF5jgiSQKynjWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+hSHE1WdWgl35O5jrdCJEhBAsVPiMZGgIMKkt8YpC1uew2b9IFrIbsx76wI5t+S5KhQktqkPhzV4heP4WvLJjMA9EDfrUCwEIcFtWsECTjS/yUTXMRY9BpH3yvDUfyoA7VJFtvYE1308AsOjUVTZrzNix3B3aWg3Ydj3VZZpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgcOubl6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgcOubl6"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-393800f638bso37071521fa.1
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522094; x=1779126894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHIDhlOJb8urKkomAEMs1m87rndRxl/f43Adb3lInY4=;
        b=PgcOubl6Y/FdPFWtoCtspYmTpt260eQBD/YoQvixSBdvJhjja3XhD+WUtzXcnE4Ihw
         8UG87PXYxIYEBm0DUjnyslA6y0n7HCWecYVByFldaC6H7Ca/I+FUdBfjq40iV+VjPyc2
         tMLZWj2E3bKYT125PhjGt/RTsraRBvQZaKmxu+m+/R6Phlgtd4ot+gdCdvbb4pGgxtTF
         NVhgb7X5OYEW3ikLcJyWCqjgEZqZYjOoE9K+atx3b+mCIQE8vZpdf/p0i2JlxEZP5Cvq
         cCAMMRBPOC8JbZn9Co2hi2Jalqc6bnPZvr9VkpA8CHrjBhASjLimIwWehm4NX+77kUKB
         I2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522094; x=1779126894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHIDhlOJb8urKkomAEMs1m87rndRxl/f43Adb3lInY4=;
        b=KqAay76T3ylWIJtu7preViglt0rul3IvZLPpr60jE3+yIFcJJq5GhDE+cfHBVgMQxg
         G3QfLwVE+UWuTxj0Zz6CFmH06GWeLBc2tpT5tdr7paNDh39JOKmuIu7WTOTq6u32N05c
         UvQqLfYyVhxupFLjhPSAXtwr413OkLTYvOYa9YZXLx5rkJJGaRK+6Z1MTHD2V/dYnAlS
         mVPEEA6nyHSQ4ztCDerhqueLJD4PgHQt7bJp9jE1y06r4sxScJn6d7sh83t9C9lWtMH9
         EEGzso/lrTmemjXr13poRJZ6bpxrcpd3JlCqKwqflBFoUfMe1SgNiXOvEtF16wUzwKnY
         siqg==
X-Gm-Message-State: AOJu0YxRQpOBSSsFiN8MTLa+YgU9p9v3XiZTu/0BaI/S2tdo/9jRKSiO
	jvt6i116DJRMopbYoylvKPz4VxLC0pp4nVkhBxai5eXBz6kFhe1//55hAsgtag==
X-Gm-Gg: Acq92OH4cl/mvfAGvDYirHzvNlJcyX95E4mHyjwWdBaImXtabp7FET+pGp8iVmnKlfE
	SNiXwZY/VusRPGlD8tSrD/Big+iJp8T1Qw8Yec2TwXydvm2OpzzAV1q15yhCrqgDdEBwOAHKEk/
	GaFwDatzrmPZwFTD/1XWOfZUyDxvbCFzvTzfPF+EqVlF3WhB/dFkBxUn+iC9PjfTpCSRML4VNYW
	DRIkx9gAeqlMkAEFobkYU27RVO/VHNpg4FNJuKTnnEorbyhuX35pno8lwzOTujcEdEzjK4jo9Tq
	2G0w7Xigh46yy7rAVJVwX1wUCGgHR2ux10I2S5H3CLP4xKSGGYerEJK8Eo7lv8i/WupJhq5oy0w
	J8/CrLpmYflHFvqujyMxXFSGVKx1Dgq8FehQCUmQ+CCJ9l7xS5NBuldXrk+AWJ0zEWFThpByuKF
	gKpK8Jwce8qqMwn+g=
X-Received: by 2002:a2e:9783:0:b0:393:903c:225b with SMTP id 38308e7fff4ca-393c4338719mr65673121fa.31.1778522094076;
        Mon, 11 May 2026 10:54:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:53 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to never-online CPUs
Date: Mon, 11 May 2026 19:54:41 +0200
Message-ID: <20260511175448.153326-6-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

While an srcu_struct structure is in the midst of switching from CPU-0
to all-CPUs state, it can attempt to invoke callbacks for CPUs that
have never been online.  Worse yet, it can attempt in invoke callbacks
for CPUs that never will be online, even including imaginary CPUs not in
cpu_possible_mask.  This can cause hangs on s390, which is not set up to
deal with workqueue handlers being scheduled on such CPUs.  This commit
therefore causes Tree SRCU to refrain from queueing workqueue handlers
on CPUs that have not yet (and might never) come online.

Because callbacks are not invoked on CPUs that have not been
online, it is an error to invoke call_srcu(), synchronize_srcu(), or
synchronize_srcu_expedited() on a CPU that is not yet fully online.
However, it turns out to be less code to redirect the callbacks
from too-early invocations of call_srcu() than to warn about such
invocations.  This commit therefore also redirects callbacks queued on
not-yet-fully-online CPUs to the boot CPU.

Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when non-preemptible")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Samir <samir@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/srcutree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a..7c2f7cc131f7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -897,11 +897,9 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 {
 	int cpu;
 
-	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1UL << (cpu - snp->grplo))))
-			continue;
-		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
-	}
+	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++)
+		if ((mask & (1UL << (cpu - snp->grplo))) && rcu_cpu_beenfullyonline(cpu))
+			srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 }
 
 /*
@@ -1322,7 +1320,9 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 */
 	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_CALL)
+	// If !rcu_cpu_beenfullyonline(), interrupts are still disabled,
+	// so no migration is possible in either direction from this CPU.
+	if (ss_state < SRCU_SIZE_WAIT_CALL || !rcu_cpu_beenfullyonline(raw_smp_processor_id()))
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
-- 
2.47.3

