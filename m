Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B6223DE5;
	Sat, 19 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=VUBGUEWmcit6U4IGU7CoNKYCFLtUfVacI96fbkob/l8ApmOBLmRcNsHYxLwj+gFUdWNwFfNMeNda6++oxINJtKV0YeqHZcan4l4mBcqSTovWZgVP2VwLn59OL5yJZX2zJ+dOhV3MvzmBxEZBLbIE6wIHdv7RhvIL72lNLIotl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=L1xo5v5dyrgZ7oAe04Ke7PBekML80mrgnl5uOoJJ5AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXr/4ic4JZ7caxFIsye9r4qHVvs6pGC9wSzAb2JSWRPvVgoURhwMPyC45Wxygar99FT3nGgklOeDZL5HMU/MxYt6H7YjW36nWzv/rmLH/Glk9s3UeunN7SPV8HbIDl6KtXWp9xwLauvlDOSF8Pri+rw5O8cxkypNWpC7oH1Fxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqH56TJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqH56TJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F401F008A4;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=E0FCg87O7SpYI0j8TB88y3JAaxXy4Wf5cgvNHzuDiSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqH56TJt1oux6aJULASRre920lFIEdM3N0eNS+cxg04DAbujFA7/XtHIFWSyLpkvV
	 l0zqFin805wnd0gpGu05+oq1B0JWt172b/26kowstRZZpl4ZEvjugdtb8cgI7gtzSq
	 VuMsry22hKZSvgsOwY1I0aLe80O6GXdkg2vGfWHACDVmk9sXgcs4iAIcBmLcdTWk3e
	 9uuLL898Xo3dPk4WcmV5spWxXM4jwQZ6ZuN6tstuwyO+BlupVx4qX/1O79j8t8jJoa
	 NCTGeyy93iu61Mkn2XV/RjXypKRz8ZiMQdodWBcTN8ltU/wWAMdfhHE02vpWPLasD7
	 dXUSv8GVtgl6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6F433CE0C8F; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 13/28] hazptrtorture: Use task_state_to_char() for task-state reporting
Date: Fri, 18 Sep 2026 17:00:41 -0700
Message-Id: <20260919000056.3132131-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index dc148894786b..51fd0562f9fa 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -620,10 +620,10 @@ hazptr_torture_stats_print(void)
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

