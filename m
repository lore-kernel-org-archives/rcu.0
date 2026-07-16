Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11458223DD4;
	Thu, 16 Jul 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161095; cv=none; b=s4X4DgKfnbd7qcNxckU1ssu754XgogQGi6pBqOSB3Z7alW9FhRyLy9S/vXVlSWW8TzRSughCBTbm0mnA/P9t8iVl87kmRWSEtu4ycUhoYYQYX62VjWX+Ljr6G2x8F0V3UcWYWFuv0fPKTw7UJ9QxBIXaJ/4Accf7wTK+xNmfYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161095; c=relaxed/simple;
	bh=q5x7h/cKxZhYRIDtmDdIaqS5ptNKMn+4az5MYemtxRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBzWILA/JddUGiUXtgYUVneoEL13d6zDqsVKrOaVON4sYkdkx/90/VhL/UACsAFP/UE1BxWBN8Ud4AmCV2rZIU4avYrJR17MGdQfjA8aJI+kQa2q2DHAT+zy7nHtrrf4R1/rRmHU2PCBmY0Q5bjQDvzWWhb2TtsI9erOI2wYjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csf1T6D8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csf1T6D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6371F00A3E;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=3CvywNr0WbXOGx0JTNUPTDTUNzLnOXqHzFE6wFFrR5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csf1T6D8JqrGZsEcDKWkDiSyH+M/AKUgFMKfL9u48n+1HNOAqcnKohhOCBkJ1/GCK
	 3VBvqbbvV0UHUBAOSYkYc8Vf+qEyNNcOIZiKrOI7oB7mL3U3jmeRCAk/jQ9kMIAlfa
	 h97apb+Yt9VE8NnwCLLGwfGDXcbMWoFBurdwRmDKIEdo9XP8CSI7QBq4aMjj4revZ5
	 7GX2khwfKhw1w7OiYOMEFGSEBCUqvBUpvnLxcpBEbTA2z0/XM3T/uhhOGDlDimN0gu
	 JJp9EEldZyjF/bWwl848Qa+vRBDO1GejsCnreePyhb2Gi2gxqHPk/FO6HaWln22bHs
	 pU3KtKbW1PZlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 430DFCE0F14; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 13/24] hazptrtorture: Use task_state_to_char() for task-state reporting
Date: Wed, 15 Jul 2026 17:17:58 -0700
Message-Id: <20260716001809.11084-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Use the kernel's standard symbolic task-state representation instead of
printing raw hexadecimal task-state values.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 3304eb450d7e32..266fecb00105f9 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -621,10 +621,10 @@ hazptr_torture_stats_print(void)
 		unsigned long __maybe_unused gp_seq = 0;
 
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
 			 hazptr_torture_writer_state_getname(),
 			 hazptr_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0U : wtp->__state,
+			 wtp == NULL ? '?' : task_state_to_char(wtp),
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
-- 
2.40.1

