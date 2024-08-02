Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B236171BB;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=Xia9J1H7Ev4IDLlFBwoPhMgh4uiESQby1onFB+WRn+lbj3IxT73+q743sA+HKjsw2qaHQM2+/XA2LThkwma8oPS8If4vwPiOmowjKtnsnlTHp29yEfCf8hb41+PNqErB58jaIftChS3Dy6NhsaScE7S6f+AXRQS0NCj4abJndZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=ii3Lw31Du2kvj80qfw2EEctLsKo4MDiaG/6o1ncMupY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tM9SZDfnItqaVaTHjg9D13iTHbyTFwuKfiyYsoah900+f5kO2P/yrX+0uoNJIbMEehSXX1RkDg9oyJTanQOM1hHhUYv8nkIGVORejsTf6k6YdMDfajlIRAMlhqM0BdFPfpKkGB1GNMr9c7IPTz6iAhtp56yCsYLGf2Dsc47X0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMeU4s/a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMeU4s/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307DBC4AF0E;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=ii3Lw31Du2kvj80qfw2EEctLsKo4MDiaG/6o1ncMupY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMeU4s/aSSRJlqfRV4FMOOjAF7clBboARTEy5Yoq1lkRyTdQshKvq/daAIp31TMTp
	 OrPHWLq4ZUks+fxlzu7XuBf4D3ktpEusH04uZdcdyxy83jAdDvIkZeSz2yFI0LO7Rx
	 RSOTGUhyiJ0oHZPZCw8WkFnwcyXRz4gwrM9WQukAQsTid1zFaHcgiCWzynRrXu143Y
	 yZv38O/xnWQ5FJ3WV0f4TPRNkOuoRpF5MoDZetjCipgJe320ZyDSPn4JOpixeirvTH
	 0DEzKSPzNrzWRD9FRKGMyAsbC1HdvL+iJ7kvYsajRsCyZwYK/oeysKhA4XfBPMewuD
	 BUJgOSVEP33jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C641FCE0E0B; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/11] rcu: Mark callbacks not currently participating in barrier operation
Date: Thu,  1 Aug 2024 17:43:01 -0700
Message-Id: <20240802004308.4134731-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU keeps a count of the number of callbacks that the current
rcu_barrier() is waiting on, but there is currently no easy way to
work out which callback is stuck.  One way to do this is to mark idle
RCU-barrier callbacks by making the ->next pointer point to the callback
itself, and this commit does just that.

Later commits will use this for debug output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 77b5b39e19a80..930846f06bee5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4383,6 +4383,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 {
 	unsigned long __maybe_unused s = rcu_state.barrier_sequence;
 
+	rhp->next = rhp; // Mark the callback as having been invoked.
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
 		rcu_barrier_trace(TPS("LastCB"), -1, s);
 		complete(&rcu_state.barrier_completion);
@@ -5404,6 +5405,8 @@ static void __init rcu_init_one(void)
 		while (i > rnp->grphi)
 			rnp++;
 		per_cpu_ptr(&rcu_data, i)->mynode = rnp;
+		per_cpu_ptr(&rcu_data, i)->barrier_head.next =
+			&per_cpu_ptr(&rcu_data, i)->barrier_head;
 		rcu_boot_init_percpu_data(i);
 	}
 }
-- 
2.40.1

