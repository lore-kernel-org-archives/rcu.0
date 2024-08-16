Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B713790B;
	Fri, 16 Aug 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791892; cv=none; b=NluyrdkVXwvhHDzBvhYhFXbiItu9YjxpwkjkwTteacsxoQeyRTJZUqpjZy1H6COP8K/aPgj186h7nh775+tJzN8Jx+3kiIscrXPGi7/W04y0h9O4zohv2/mWYhgxLqmDqGuYdMBPse97kaOA/OS0pt25ZAf5/Jca1S6+I9KFP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791892; c=relaxed/simple;
	bh=BJJbVM0oLX+bNBsDn9howoFV7Y/+W9jzYAXgiWat4O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6ZsV8yhQs22gk5IETJwQQSuguSvjLUkN3qsMOG2Lvmz1Cea7Gsqm+tCNvLErNR7cXyv8yIFLCOBUlNJCA/Lqei1BIXK0yRXBJ8w/Pw3oJAbRZwS8JfAnxhtF1WplX/da+TWSRXKC4JiaW3ZvVnJl4IyuQYt9lx26eCzqYoGyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADDC4TZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADDC4TZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D0C4AF10;
	Fri, 16 Aug 2024 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791892;
	bh=BJJbVM0oLX+bNBsDn9howoFV7Y/+W9jzYAXgiWat4O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADDC4TZwINLeeN08WtjxfuFVf8gaQWgI0EK638hF3sDThRjNMddQLMTRScxKulqkF
	 qStHirPe81laziSxdBVRbJhltYyZLEh6+fIEKsBbPwINKnwAGF/olbTAOZhU8UsCUS
	 E+UQwl0LtrI0MokkgF/wTRVqMy/WvULUU0Z4ycFZWawqubPq3WV2CWw+vSkPZ23jzX
	 8E7rksqWKdjiU7CdZ0yLHDhSs0pxB5IqzkLIdniC06pICU+Ftt5A3hEqQAf0BTgTQ0
	 Yy3hq0vpAHD/mb9D5JrJHAWvJ9K98dOdNIqbmZbnqg3njPx16yVtcRq2Vc+xSp4LF9
	 IxslYlOTqW8Ug==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 10/14] rcuscale: Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure
Date: Fri, 16 Aug 2024 12:32:52 +0530
Message-Id: <20240816070256.60993-10-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

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

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index dfe8e0faa4d8..80518662273b 100644
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

