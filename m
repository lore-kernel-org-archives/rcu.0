Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BA21B9FC;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=OCp6EDwQVkML5PI+ag+PDiJyJsDGHAbctq3fRQNCjovqarfy23MkZ0jBtdEDcm3rtGMhSWVJ/oGh55OLrPaSj/5WWnlXR6Pd6V3zfx4fwbopf2dAgIMGG8gpG8WIKVxoYmkoQSwcqfv35G3CjzSdmUom2IPJOXKrHmWX0TnBX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=95yGZppaZZxoJNnNv8N0HfRV+XlPNqEDRvJVFtromRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxRjtwNjsgM44MI4Lb0JWdPJj2L7gvwKAWzXsAGsM8aGH0hxIoMBc3jkbnUPss9sitGuqG9AXAqgpmMT7A3kpfSC4VMWpDcJVC39P3hmZbO/X7i8MDM+9JMA1Ykm7J7GbOdMEOMBxGwAIp0Flc3H9lVZzP0O4vPfHlnBDgX3Aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRea347K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRea347K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C933EC4CEF3;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=95yGZppaZZxoJNnNv8N0HfRV+XlPNqEDRvJVFtromRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRea347KjhdlzVfvJEH/NfNFmqmypO9mjv04ULyxp16D/aiF7o4KlYzrWay6hNJdZ
	 jpdbRR1AtDFj2qqwRovT6wSW31XsJMGepmtkfid5UH8MiKx3zUN5nsgUnJNkZmJI9G
	 bzH47j/Nz2fygb6yfpCoG0UyT2j7ICKW2//EZ/E9l0Yk4iBcZ7hsLzWH/zVv0zKPoL
	 CslapDzVz4v5jvRUBsWV7rEkjqIJ9X2hSkx13451GmEzaXOF+4gJ6N4r8A1ZU671mz
	 vbzho6kqCznqC5ueMrrtJUJTib7cnw22VmzgMMnbwm2scvalaTiB13/UXX6U8srzzU
	 eB0twgqBHIoWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33F59CE12A6; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 07/12] rcutorture: Comment invocations of tick_dep_set_task()
Date: Mon, 31 Mar 2025 14:03:09 -0700
Message-Id: <20250331210314.590622-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_torture_reader() and rcu_torture_fwd_prog_cr() functions
run CPU-bound for extended periods of time (tens or even
hundreds of milliseconds), so they invoke tick_dep_set_task() and
tick_dep_clear_task() to ensure that the scheduling-clock tick helps
move grace periods forward.

So why doesn't rcu_torture_fwd_prog_nr() also invoke tick_dep_set_task()
and tick_dep_clear_task()?  Because the point of this function is to test
RCU's ability to (eventually) force grace periods forward even when the
tick has been disabled during long CPU-bound kernel execution.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7eccc74e60a7f..ea40f3ad32dc2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2410,7 +2410,7 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
@@ -3260,7 +3260,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
 	rfp->rcu_launder_gp_seq_start = gps;
-	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-- 
2.40.1

