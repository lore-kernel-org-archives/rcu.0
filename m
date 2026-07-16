Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E42D1907;
	Thu, 16 Jul 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161527; cv=none; b=Fz/l7wzzFgtRG2+2YseQ38ZGMQLw5IePijuLQxO7gI22CmU7so3dL22KoYH5G04HiyqLhWEzfPAr2Oxfw52tURapiKdyDgRvocfIat7I6wm1k+garXYCLR892im51Z8lG0fT1Z4I/mWthzkE1nr+Ui7ABOwyh0RA5rs+0D1mpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161527; c=relaxed/simple;
	bh=MiSicBxAP8pbF4HSksNimmbE3PEse7VM+Hsu1u7Uxsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfsdglihf6ISSOOXV7MtN1fMyeP/ed3Vc3e8dLKzSZlVcR2Ks+jJv/+Ii729klr/gx6cdmg0HMapWlHA9lkL3q1Go4p45UYPkw1RmWryeen3oQnGMlyX0FGeCJiyaDc6a/ODcYSSVPwgdbQTf3EiA9pF5iOTJ3gDUC89HtjGBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrFWvxGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrFWvxGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB84D1F00ADB;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=Z5KXD0bvc6C+lKUybNSUiAX92DHyWBYmG9YhYb8bd0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BrFWvxGXFtQDlC1iF4PQpWf93qD4MOZHQMxo9rb1z4B/gVCHEPBYNyMfjXysevKpE
	 jD71TDxQgsAOK5qWDOJnNh3AgzjKWjWQryIy3Xg7Faxdy0lGO3s7Vmf0Ts7j9stQ/l
	 0YIStF55b71U0kKZVaPMFgbnH9BE+xSSQyBlIoEIRrygAEkZOwVRkUiAdvKIxmwGrp
	 8St68unVOEuCOzC+fdN/MpO1JsYDZPpf4ZDbxMJxfASNG9Ocd9hVpgl9cHMSSd17/U
	 WVGMLfK82jhFpmbzFQJK1Kaq9NKoyc8WD7+13VkTYzN2n/70o2o7ymYPw3ojyRf+2S
	 UD9YAePXtzpUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C83ECE0D3B; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 06/11] rcutorture: Use task_state_to_char() for task-state reporting
Date: Wed, 15 Jul 2026 17:25:15 -0700
Message-Id: <20260716002520.11895-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
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
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 64b56ec823c1af..05ef7bb65f710e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3076,10 +3076,10 @@ rcu_torture_stats_print(void)
 		if (cur_ops->get_gp_data)
 			cur_ops->get_gp_data(&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
 			 rcu_torture_writer_state_getname(),
 			 rcu_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0U : wtp->__state,
+			 wtp == NULL ? '?' : task_state_to_char(wtp),
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
-- 
2.40.1

