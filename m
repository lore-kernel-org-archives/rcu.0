Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5917BA4;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=MuxkPARxVYD6J5flMJY/AVilk7KVNCRdereCGGKjZsKsG7gZlgEXKzZCN87xyFAK2wdpbZVAFRObNymJvn7G4Z1S/vlRusxlChKaHIKwICyYY1s0cJJkSZcRmjTv5AcSEKaJ2SjJeXUGms2z7kNY+zHjQYAC9pahVbJlov/oM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=wtNU9ny0pb6w6vugnHTvWS5lxc3HG5A0ixYSJLK9w1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FqM6iQQPsk3QSKW1+gWmlMY1ljxKcs9yFFWJwqymiPGFy2QT7AwYazRIhN9F0ZlWXg2SFI7OWAtcsnI6FXv8sgl0NFu0ANsuDEqWqKZfSPmpqv2FixH1D2/VqDCzzxUK8RbfZZnraZ30n/slR1fhDcaG+rMPobcBeg+HB1I7lMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul8bPBSU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul8bPBSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E582C4AF15;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=wtNU9ny0pb6w6vugnHTvWS5lxc3HG5A0ixYSJLK9w1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ul8bPBSU2jl+Z3cs5u/wyRDgudETm4TcVugUU2h8u86K132S3wDN8zZa0ZbYCXc6K
	 XoiOLqHRqc0XvVCn8zmNflupW3neXlF/AZh8qsm+74Z2ekP5OT50riSAaxX+44OQeL
	 UCCuTFzbZ/JbA5Fo51cyakhEEXHqmngEzcNnpbrCv1r/a019UrKrFhkUyeFMjYGIH9
	 YQNFjzFtRntD7HxT8cIoFyXrFYpHkdKstUMl5Y6MediuXNzOZBCNdBOm57Jvv3R6Gw
	 2RL5EU85qhQ84JkLVa6Dc1sw3yL5ZhaZebNqZL9Fz7DfTDhBttuAzs7lfbLKiW/tGW
	 4gninT4KMfK4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CDF0FCE0FA9; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/11] rcuscale: Make all writer tasks report upon hang
Date: Thu,  1 Aug 2024 17:43:04 -0700
Message-Id: <20240802004308.4134731-7-paulmck@kernel.org>
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

This commit causes all writer tasks to provide a brief report after a
hang has been reported, spaced at one-second intervals.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 315ced63ec105..a820f11b19444 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -483,6 +483,7 @@ rcu_scale_writer(void *arg)
 	unsigned long jdone;
 	long me = (long)arg;
 	struct rcu_head *rhp = NULL;
+	bool selfreport = false;
 	bool started = false, done = false, alldone = false;
 	u64 t;
 	DEFINE_TORTURE_RANDOM(tr);
@@ -593,6 +594,11 @@ rcu_scale_writer(void *arg)
 					cur_ops->stats();
 			}
 		}
+		if (!selfreport && time_after(jiffies, jdone + HZ * (70 + me))) {
+			pr_info("%s: Writer %ld self-report: started %d done %d/%d->%d i %d jdone %lu.\n",
+				__func__, me, started, done, writer_done[me], atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
+			selfreport = true;
+		}
 		if (started && !alldone && i < MAX_MEAS - 1)
 			i++;
 		rcu_scale_wait_shutdown();
-- 
2.40.1

