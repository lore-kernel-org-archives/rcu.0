Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2D12C549;
	Fri, 16 Aug 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791845; cv=none; b=KOPTXQvLofi5gziYwwr8qZH9d3uDAlTjlWzY4QPpNR8yIIFyhIII9aa4u53ORZ3gK2U9y8a0KqT7gOwAXi464/MWd4T+EKahARMn0sfjd+gYXlORIMJGnqonNhX9dgT39hKFWcIOWczumzNMVNEpMw9sXhrMvmdEN1Xaa9RJ+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791845; c=relaxed/simple;
	bh=Onny6ymZLcW/+CIvxBmp98gGmBO/rcJMG4CCHHJNEDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ox6l4+QT9Vzr9xYM6Rri12p6EUsKb4KlKRGy4rREYV53bwnRW8PgejFnlzsJP5+rbAAdKwXVa8WRmFEBTGU0Cgz3FzIfiPp1VNhlEXDohZa1BVz4Ih2ynlnvFqfSjy9MglZ8igdb1kPOYleb810LPuTunAJFDwSEkUzdEpcH9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdRvd0na; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdRvd0na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C72C4AF0B;
	Fri, 16 Aug 2024 07:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791845;
	bh=Onny6ymZLcW/+CIvxBmp98gGmBO/rcJMG4CCHHJNEDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdRvd0naZTFrNDqaNb1PcQccdXC9bogemPuXvicl9+yAfMPedxU+eqhlmR12yq/T6
	 MSIeTDOLFtYQPo3/Fe3iuTonEy4jxSeYzgN+47KUiTicdYgZIrkUw3+3Mg4rXh33Bs
	 j29ybHk2uGZDcm06wod/6wkd2tFszlfYaOC2V+JjgkwNd5ps+RsFEy/6epad5fvVwg
	 pFVC83JvaW4DtS1ycVk37ugo1FMd2I9iEkW0ynVS50yvFJRPw1Iv1PfX3KO4s0GiXL
	 htU/c5SkhBVJg63ke/agO7JFKxf4GKNEKvIkibtU+uGEVfA8ZptIdwSwB5HAxc9qk8
	 f1jwae3fwM8+w==
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
	frederic@kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH rcu 02/14] refscale: Optimize process_durations()
Date: Fri, 16 Aug 2024 12:32:44 +0530
Message-Id: <20240816070256.60993-2-neeraj.upadhyay@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

process_durations() is not a hot path, but there is no good reason to
iterate over and over the data already in 'buf'.

Using a seq_buf saves some useless strcat() and the need of a temp buffer.
Data is written directly at the correct place.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/refscale.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f4ea5b1ec068..cfec0648e141 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -28,6 +28,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
+#include <linux/seq_buf.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/stat.h>
@@ -891,32 +892,34 @@ static u64 process_durations(int n)
 {
 	int i;
 	struct reader_task *rt;
-	char buf1[64];
+	struct seq_buf s;
 	char *buf;
 	u64 sum = 0;
 
 	buf = kmalloc(800 + 64, GFP_KERNEL);
 	if (!buf)
 		return 0;
-	buf[0] = 0;
-	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
-		exp_idx);
+	seq_buf_init(&s, buf, 800 + 64);
+
+	seq_buf_printf(&s, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
+		       exp_idx);
 
 	for (i = 0; i < n && !torture_must_stop(); i++) {
 		rt = &(reader_tasks[i]);
-		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
 
 		if (i % 5 == 0)
-			strcat(buf, "\n");
-		if (strlen(buf) >= 800) {
-			pr_alert("%s", buf);
-			buf[0] = 0;
+			seq_buf_putc(&s, '\n');
+
+		if (seq_buf_used(&s) >= 800) {
+			pr_alert("%s", seq_buf_str(&s));
+			seq_buf_clear(&s);
 		}
-		strcat(buf, buf1);
+
+		seq_buf_printf(&s, "%d: %llu\t", i, rt->last_duration_ns);
 
 		sum += rt->last_duration_ns;
 	}
-	pr_alert("%s\n", buf);
+	pr_alert("%s\n", seq_buf_str(&s));
 
 	kfree(buf);
 	return sum;
-- 
2.40.1

