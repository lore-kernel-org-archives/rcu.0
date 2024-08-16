Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FA12EBE7;
	Fri, 16 Aug 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791887; cv=none; b=o9TtT2khRhxCbAQEM0uq+68O4Y4CSHNsJ0eKEtZvKYPkv+CsmhMIsFmbSNNUcbPqYHHryVjgvZw+YOZGLaiauxQG2uEaIxhLb7keBlEnTdt0v7KxRTnMuImD3OyZSaxNwsCcnVdmww5niYYE54R4ODiwOWjwOA7M3Hfz98ojttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791887; c=relaxed/simple;
	bh=OoxDmktJaOMty2kevzZelHWkNA6J/CFdJiE+1Wq6wDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQLkVXRwFbEFoOfCEocgq68jSN1s/TKnRRJtLGbR7GfG7MdOUL5SDbXNs450+z9rHpw4SSXxp0XVXRzOOTcVg+yw+crSF/0Fdg/Et1GANST6eiByRRYUUVhDN4ijdM/JVxJUSS3r0aK8EVQfmC/SsM9a0l/ko9dhEEo71K/nG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6CthFmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6CthFmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7209C4AF12;
	Fri, 16 Aug 2024 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791887;
	bh=OoxDmktJaOMty2kevzZelHWkNA6J/CFdJiE+1Wq6wDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6CthFmzSeJWwU3gTcaEbHhvNxPVRqeyu8Nk7k4rUUfXPVsrEj9QBEmEek3jmctVQ
	 DNQdUVR0/X+BfQ3eCKIJoaYzmAYyRHtLOhQnBL4nwKEgAmoTriyeIZUhDbqNQeuW8h
	 CdViMglCSusg4opjixCPdW0LU5UmPXZKxul9BGl0TYSyUH6FJjcMYv6iC88RH2e6Uh
	 K/RqFyJ5pwQx5nKNYqcvfXSs96MZfq3t/LJunYMv3k4AeWxk/DrSuy61A2fjj8uDq5
	 eKOp1J3+4PvslkXsHwNbM0RIMuY2h79FYlLl0AF0cX1BAyQ+QDXORH/pK2fQQwSzvL
	 5Nz9ocPVkx1iw==
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
Subject: [PATCH rcu 09/14] rcuscale: Make all writer tasks report upon hang
Date: Fri, 16 Aug 2024 12:32:51 +0530
Message-Id: <20240816070256.60993-9-neeraj.upadhyay@kernel.org>
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

This commit causes all writer tasks to provide a brief report after a
hang has been reported, spaced at one-second intervals.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 79e1c32d5c0f..dfe8e0faa4d8 100644
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

