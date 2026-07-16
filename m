Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A526B95B;
	Thu, 16 Jul 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161424; cv=none; b=OdDh6gDBOKhoirgAyhZUArCTjLBQeoixY/ruadgLL+qLESAPBrC+qd9e2jcbAB+d6rCegKvp6P5/G9xQCFrwOba4Q+mqxHVEsI0dSOL9FhWWJqZLBh2MKahaKwK2NItKT4LWHiSzI+OwYIouA4un2ET/xy5+iMC0dOcom5iJCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161424; c=relaxed/simple;
	bh=jlKsbYmNXw2mKKfpRSL8s+FINdKeIGc0OWQxAvSpyOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTF7hl4us4eJKk/ICKD4X8OjaMtAnzwT/0B2/nnjSl8gsrCT06cfnNXprJ1ltdB3qva+9nQr5TxOcJhuU8CQzXiMHCO+EFgGeeZuDlWYQYYgoghVV0VokNzvpjDz92yi6UziR9AxrdPfRFqYyUS0dMDvG77834gCFY5j1Sv8O7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/NS7PEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/NS7PEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531DD1F00ADE;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=j4QeWZr5VIw92nE193Im+u0gBQiE/2LIDQgcCKVG+x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/NS7PENvio8o8EmejgAvS+iPj2Q2POmylwpSETI7xtYx+rZfEyg8XWhN/Ac5LxhW
	 5rGmQyUYEKYHsWOsn1LfsDaLOj0gtgNGtlMM4ekn/abUUCxLV44+3aZP3mIGDiTcX5
	 02auIvprNYx+/qi0st0tRrUAQqbcl2adGHyIg0LgdpNJSY281i/EX2RWhk0QGIRgD/
	 iFk/7D6fuz7kFmhaPkRIPaJeZ7rUc7h/GE0eNUFXxsSKi9mleXjRXl6ikoUw7AkYGH
	 idLasDRCOyxsqa085V5QS5f3rCYygBf5aNuMqGcvGj52dfVy+pvFX+F9YRzNhYn6Ts
	 7UoUB9rywOTIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 006BDCE0D3B; Wed, 15 Jul 2026 17:23:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 06/10] rcu-tasks: Dump rcu tasks status when the boot-test failed
Date: Wed, 15 Jul 2026 17:23:35 -0700
Message-Id: <20260716002339.11717-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

This commit adds a dump RCU task status function to rcu tasks tests,
used to obtain more information to help debug when the RCU tasks
boot-time tests failed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7f7d1e6362178a..d9e1e53f4ccf31 100644
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
2.40.1

