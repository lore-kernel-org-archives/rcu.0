Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FE19995A;
	Thu, 12 Dec 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029401; cv=none; b=fdzknCkEY/LIHUF1sqdsiIzw2gbSuzurHaCJIn+g6MgbeyjZJmi9XZ+rNBVINiCPO4U+rpaqCP1d00remQheCFzrFyBZJazgiqgcQ2KQDFGXBX9cvyWVv9GdC0X7VgbXoqyBWa/impoeBeHjCp/GkYVkByJJTH9eVPQOc0vhtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029401; c=relaxed/simple;
	bh=+s39ugeBtH+LrBgGtbQiGuaZ+HcdWkxjxvfYjIKuSRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmOD0NlMFKunQ3koKbqnAo8rNYA+YBVjgsOReaYXI36EjUT9AYyZNCsuQQfOCmo24j74Z5dwhXkZRTKLZAYw+nZnfi4AOL06v4dt897m5Rg6JleRXezHTENe/FNgeMj9jEf9E9w9Scviyc8/MwY5unSyRmgwCltN0c+a7f0y2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI7cD7qK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI7cD7qK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AF9C4CEEE;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=+s39ugeBtH+LrBgGtbQiGuaZ+HcdWkxjxvfYjIKuSRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DI7cD7qKHf71Ex4miwu2LMTB/ySceAeEIRQFGytPG684linvD7jP6GJKf/fVwXry3
	 w9n5tE70rJeIR/Qq/+7ji5ujoVaDRoGZqj4n3edRCEhhDYW6fRvAnDvUKiZsfgAhka
	 kPQ2iK8fYOKVh3VJJVL3k8g+f/pVh4NDjqFOpAK/w3RUsro0ugFXJ/+iG0WcLN7AMO
	 +0co3dbpfgJ/0P4ewYVPW0hu+dI50/yAWcI+XX9El/8W0KB0duPR7Zj6cXH7KvCvef
	 E7Fhz6QbIWFRWE7/gpiUjpDG3xCGGPYP0R05R/IwyDpmNWqBW1Nm2lnPlWD7ZaacB7
	 5EMtqe6OMeREA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DAECFCE152F; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/18] rcutorture: Add preempt_count() to rcutorture_one_extend_check() diagnostics
Date: Thu, 12 Dec 2024 10:49:54 -0800
Message-Id: <20241212184957.2127441-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the value of preempt_count() to the diagnostics produced
by rcutorture_one_extend_check() to improve debugging.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 235a73dad2801..70c27bd67be1e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1872,7 +1872,7 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 }
 
 // Verify the specified RCUTORTURE_RDR* state.
-#define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x\n", __func__, s, curstate, new, old
+#define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
 static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
 {
 	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
-- 
2.40.1

