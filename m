Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F841A914;
	Wed,  7 Oct 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=cZipPU4vAGVmuAHNdeIAQEcW9rdvvrXKvYKWZMrx8Su0IALMLBcj0/rkAzjf8VcteK4QIvrltXoxP/OCRyMOb00AMotfwcq/8ts+Ecklvd6eUKp3clAMY+fVSwVSzQHLuF2Banp+zJC6DWx4MSOd5Lr3Y8yXceTC1Fpc/yPATHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=nk0VT+ejcehvauCAbLgwNiiYkA6XlZRRiQia10amOo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWq+ZW82XLn81eeTDE3I0NWf9QNIaUXo3FEsbcSgGYsTNfzducsmU95Hiz9i0NexDFXc0bb3UQWJDQF/z7iUGYMSUMy7iFOIZpGrFLGQYfNtjl9s04ttyAi8WSsxFduSPQ55/AFcBlT/xiQ7Gudvc/xM8a0DCDL8F3/dRrfXNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR2Kgucs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR2Kgucs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F801F008A5;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=V+EAgTthBzAiXqoGwZhj5RXRbqmhseyxwF20ilJu5OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AR2KgucsCTD/Hbw3kp4hat/aOsVLVuSJk6TKSuIvIpyLSD/oDRLcCREmJ1vuHXX3t
	 OuSt6TYgMsLwfaqcYSlu7/Jm/KRppgQ15xIwOd33zPUXQYVObEjcxGJWyX0luu3sjo
	 tWdQaKS/7NAN8bYi3jk1YeQ4rq14xS44Os5jLxuWTMqmXvsiJU2Uf7NQIsRnNlhhmk
	 jfMwNHzUdU4IkHuNNcuaWik8zS783Ods6Rq/KaRGvwXfN1TjMhJGacT3hozphjtQKN
	 0ZvPGF0+NmupH2GdiOMN6Z510zQ2aRBk2xrlGIK/YiLi2JZuVo4iKCpTOHT+s0VaYr
	 EtjFVcNEjwzjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30A7ECE3991; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 13/21] srcutree: Skip callback scheduling for atomic SRCU grace periods
Date: Wed,  7 Oct 2026 13:59:16 -0700
Message-Id: <20261007205924.1983367-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

call_srcu() is forbidden on atomic srcu_struct, so srcu_gp_end() never
has callbacks to invoke for them.  Yet it schedules callback invocation,
which for atomic SRCU's SRCU_SIZE_SMALL state arms the boot CPU's
->delay_work timer every grace period, only for srcu_invoke_callbacks()
to find nothing to do.

Skip this for atomic SRCU.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 93b8d1088abe8..0954486880c7d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1016,10 +1016,10 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 
 	/* Initiate callback invocation as needed. */
 	ss_state = smp_load_acquire(&sup->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
+	if (!is_atomic && ss_state < SRCU_SIZE_WAIT_BARRIER) {
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
 					cbdelay);
-	} else {
+	} else if (!is_atomic) {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
 		srcu_for_each_node_breadth_first(ssp, snp) {
 			raw_spin_lock_irq_rcu_node(snp);
-- 
2.40.1

