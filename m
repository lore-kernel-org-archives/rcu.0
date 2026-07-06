Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0839B4A1
	for <rcu@vger.kernel.org>; Mon,  6 Jul 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332214; cv=none; b=P9bAY+kLLuKSCwnrSPUdiA/E++LwU6TGhCSd/FK1Apueo1+YpIW7ZgjWtwgBKlIPxjAPpYQQSqh8dIBOWWRO7aGHt71aTOs8Zrrlnf1f4mzO4diHkkuZHsJdsTfmG3kTl14gNYzI61U+zHgVD70nlEgPjU0RYlCf28ghCqUyq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332214; c=relaxed/simple;
	bh=gVb7j8lsF8ivUB4IOGs6qfdsybSD1FtjtL0OdjDqZ/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hl6pt34te8+fQNOs2bB7gDObcLi8u+7MuF3592+y3X4koseOGwXd4XVxUBBL504I6zPBDekkyLtzjMj9nmVIYudHr4PM1adf7fS6NmLC4Um4ukm3bBB71gQAvQEovE0NlMQHmHjUMuRc57E8FumGyo21b50OGVCoHEFxkQ/5hpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xhBtnUH4; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xhBtnUH4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783332210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=OhJ4zr+vwSugMj1JEeBVIb98/ToulIrDMX+/KcI7PAg=;
	b=xhBtnUH4bnBVzqiJDEKDSQIdLPceTXtcWcX0RDTPEYuyYZxSxM+fT3qNdpYLNwrXEwP9Bd
	KVohpKYt4LIIkIH0nsiTqDQ3c+hLLdS/0UVsCoAOk+i+s7xFuEYjOFghxJzE7DCoGavjxD
	+r94qZPTNo3ztqXhdxkxlmMPkmTNWks=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Dump rcu tasks status when the boot-test failed
Date: Mon,  6 Jul 2026 18:03:10 +0800
Message-Id: <20260706100310.19735-2-qiang.zhang@linux.dev>
In-Reply-To: <20260706100310.19735-1-qiang.zhang@linux.dev>
References: <20260706100310.19735-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

This commit adds a dump RCU task status function to rcu tasks tests,
used to obtain more information to help debug when the RCU tasks
boot-time tests failed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---

 syzbot reported the RCU tasks boot-time test failed:
 https://syzkaller.appspot.com/bug?extid=251e9abcdac140e7ec74

 kernel/rcu/tasks.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7f7d1e636217..d9e1e53f4ccf 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1453,6 +1453,7 @@ struct rcu_tasks_test_desc {
 	const char *name;
 	bool notrun;
 	unsigned long runstart;
+	void (*gp_dbg)(void);
 };
 
 static struct rcu_tasks_test_desc tests[] = {
@@ -1460,6 +1461,8 @@ static struct rcu_tasks_test_desc tests[] = {
 		.name = "call_rcu_tasks()",
 		/* If not defined, the test is skipped. */
 		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
+		/* Dump rcu tasks status, if test failed. */
+		.gp_dbg = show_rcu_tasks_classic_gp_kthread
 	},
 	{
 		.name = "call_rcu_tasks_trace()",
@@ -1519,6 +1522,8 @@ static int rcu_tasks_verify_self_tests(void)
 		while (tests[i].notrun) {		// still hanging.
 			if (time_after(jiffies, tests[i].runstart + bst)) {
 				pr_err("%s has failed boot-time tests.\n", tests[i].name);
+				if (tests[i].gp_dbg)
+					tests[i].gp_dbg();
 				ret = -1;
 				break;
 			}
-- 
2.17.1

