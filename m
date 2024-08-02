Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45317BD3;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=r/jfvWkZo/lXIYZsymbnyB4NiA/dVBftjNCB0WRTYrDZj5QpZbm+bVrjaUgSGm6Mqf+Z/sWxDrInNJMCgxGWjMnKxWb2nb3OVG0kJfldGGwlgOjx4ZNv/RCa66NNv63X5CHN/KeI6qDU0UnrIqYYHaVjWZG666KJBu0zqtpjfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=kxIQmbcr9Bs4WnWw6UbzaEHba/xrsV4JB7mQCevE2OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYN/voCFcj5nX/8p732mqz13fCfrTY4FCD380YCy/UVhiFVijuTxqb4ie5rHHUy6RF/6IYeHUqocrd9p/3nfIdQrSR6FjHYaUH0t8L98H9CG6gXEVh/J8633rUQP649N/9ZptSk9Gqm12k1swKmZh8VLxlHqb0som7Yd8gsAAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhvWbTD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhvWbTD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D50C4AF16;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=kxIQmbcr9Bs4WnWw6UbzaEHba/xrsV4JB7mQCevE2OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhvWbTD4Z9rNhhvFIR9TzST0qkP+o2j2AWZEJEoEJWSpRiV2C0Ua0bEYBUivxm50x
	 wqy13tCfS1rrVnxlg8eR9JHh4Y9MRokrq7AGtxry4G8pMDdAcIHDcfE37Ey+gZjNC6
	 1nkl9MBPCADmOTWvd9AZ4pLcz6UBHEE4LI7E7vJgTIMFTAecAeq/yN7f4nOrt9wMeX
	 TJA8mYjZr/AI+fODSY8OAaARwn//V9P2GOy70lz6shaYBOoUAh2gjcB8lYwk7G3UvJ
	 AB2CkFvPViYNwaoBMQfXTC4GxpPlZduJuepmqZUZFf7+8z5zEQSbe7rFjQ9ieBkvC0
	 FQRb06jWyBkuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0FEFCE1073; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/11] rcuscale: Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure
Date: Thu,  1 Aug 2024 17:43:05 -0700
Message-Id: <20240802004308.4134731-8-paulmck@kernel.org>
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

Under some conditions, kmalloc(GFP_KERNEL) allocations have been
observed to repeatedly fail.  This situation has been observed to
cause one of the rcu_scale_writer() instances to loop indefinitely
retrying memory allocation for an asynchronous grace-period primitive.
The problem is that if memory is short, all the other instances will
allocate all available memory before the looping task is awakened from
its rcu_barrier*() call.  This in turn results in hangs, so that rcuscale
fails to complete.

This commit therefore removes the tight retry loop, so that when this
condition occurs, the affected task is still passing through the full
loop with its full set of termination checks.  This spreads the risk
of indefinite memory-allocation retry failures across all instances of
rcu_scale_writer() tasks, which in turn prevents the hangs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index a820f11b19444..01d48eb753b41 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -520,6 +520,8 @@ rcu_scale_writer(void *arg)
 
 	jdone = jiffies + minruntime * HZ;
 	do {
+		bool gp_succeeded = false;
+
 		if (writer_holdoff)
 			udelay(writer_holdoff);
 		if (writer_holdoff_jiffies)
@@ -527,23 +529,24 @@ rcu_scale_writer(void *arg)
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
 		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
-retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
 				atomic_inc(this_cpu_ptr(&n_async_inflight));
 				cur_ops->async(rhp, rcu_scale_async_cb);
 				rhp = NULL;
+				gp_succeeded = true;
 			} else if (!kthread_should_stop()) {
 				cur_ops->gp_barrier();
-				goto retry;
 			} else {
 				kfree(rhp); /* Because we are stopping. */
 			}
 		} else if (gp_exp) {
 			cur_ops->exp_sync();
+			gp_succeeded = true;
 		} else {
 			cur_ops->sync();
+			gp_succeeded = true;
 		}
 		t = ktime_get_mono_fast_ns();
 		*wdp = t - *wdp;
@@ -599,7 +602,7 @@ rcu_scale_writer(void *arg)
 				__func__, me, started, done, writer_done[me], atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
 			selfreport = true;
 		}
-		if (started && !alldone && i < MAX_MEAS - 1)
+		if (gp_succeeded && started && !alldone && i < MAX_MEAS - 1)
 			i++;
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-- 
2.40.1

