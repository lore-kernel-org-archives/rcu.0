Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C428ECE3;
	Wed,  9 Jul 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057756; cv=none; b=WpxW8lQA6Xh5uktEpIU1PkF/Um+UcrDa4dLyn8y6VgVu5DMDUhfpWBB2118nVlziaJ04vMVgTvqfMkN6g1AY5xaNuJ2vjrM+FO1pLnQT3iMVYVJWmram3ta2fkaB5r0CW15zTJfsxFIsOn9cj3sIfx3rSMSWZ0t6jNs75hjrCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057756; c=relaxed/simple;
	bh=SzxkaOuv/N7hhZVa2OKTcKqSRoz3CcE3SpKXXMgs8B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQMb2GMjNgqGwiwn0IIcx7gQpngK323vcC89HYD/WSwJyEAA04fGb4nZkY9fOkWXAsneBco5vQqt9imG6Pn39YYXLK2NnXVlGnCUwPcw2nKgBOQdXw8MnfF2mPu0nQUsKO8KvpA+AtM3gd2zgsK3WDdqWFb5a38qAAXXXAwAJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7bB13un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7bB13un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F3C4CEEF;
	Wed,  9 Jul 2025 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057756;
	bh=SzxkaOuv/N7hhZVa2OKTcKqSRoz3CcE3SpKXXMgs8B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7bB13un4EGNFbQVIFVG/6nsvt+/wJIr8X1lzAYUj3tGRtsKs1yK/F/3lQ+iwnld1
	 Bmyid1kocUZlr0u5gTD3UIneHciGBkcI5ZDjXVCj8bztZ5xpKKFl9ZPLILqWiO7eNT
	 7f/LH6IRcybJpq8EXOybPXASG9sflM0W3QqFgI6XhaT9hbSV9PPJe2UXKmmjEdxbx0
	 LPcDF/Fns4oYGFw1ZIWuuZ9QnROHhp0wWcKtA4RIft+fsqMXlc8QiNACwphGT+NISG
	 kGWO/375UjyX0gUGbCMEsrQsxnqBRdaK7XmYTCFygYbnu8hPEsv8JeyGZZcdjL2G/v
	 7GKYs2u/mc1mg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 01/15] rcutorture: Print only one rtort_pipe_count splat
Date: Wed,  9 Jul 2025 16:12:01 +0530
Message-Id: <20250709104215.15562-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_torture_writer() function scans the memory blocks after a stutter
(or forced idle) interval, complaining about any that have not passed
through ten grace periods since the start of the stutter interval.
But one splat suffices, so this commit therefore stops at the first splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 70ec0f21abc3..d1e0d61d8815 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1722,6 +1722,7 @@ rcu_torture_writer(void *arg)
 						cur_ops->gp_kthread_dbg();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 					rcu_ftrace_dump(DUMP_ALL);
+					break;
 				}
 		if (stutter_waited)
 			sched_set_normal(current, oldnice);
-- 
2.40.1

