Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC52FD68B
	for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231733; cv=none; b=sAZKgw9Ew67YlYX2Vyf5ogfEkaoCS9h0fknD4dCyT7w6EjO86etIJb5BDBJ145w/oxHVZ1jbmHeuILeHpz7TePfTCcBh4iTPWmJcNq6xHBt9QlS8nuKboWTY8+vMf0HJX00T8x4UQGbflRiHEtLJleWKwStD5bRAmayGaiCR4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231733; c=relaxed/simple;
	bh=us7CT6O7r6DBOBGqCqbB4KCGGmWCDWgcfYM0vWcUD14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oxz94+eZ/xA5eGpod47KOnkznEQSlIYYX1TncVivQgvQXRmnupeK+E4o0Uk66jS9MwL8BteY2t8NyFhN0o5cLRgUjCdmSf5eB5AKyAO9PeXZ3lFohljrcAahREjLM1ywPVosvovF53ZfXpZhtOS3GNHkRWp4KYNI4kdxpklw4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JyHLBx3+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JyHLBx3+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781231730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTYmi2pJn14v+F8dalqoWcVlyGrMp+RKHY2LIowQqRE=;
	b=JyHLBx3+DUZDPgvX7orlSGEHcxS1OwnNRumONM05hu7joVW5FIIMgpoVF8/lQC98bPLKlN
	9AAqOU8GhftAL4Zsf3J5nIur7ZrT6KGm73PBnH5ECwuF1Ozm8YPBKhL0gaeh4WB5Jv9ows
	m7GVDnGFHWlcyqQAht6oWcF2ay7gWz0=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dave@stgolabs.net
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH v2 2/3] rcutorture: Use task_state_to_char() for task-state reporting
Date: Fri, 12 Jun 2026 10:34:13 +0800
Message-ID: <20260612023414.679618-3-kunwu.chan@linux.dev>
In-Reply-To: <20260612023414.679618-1-kunwu.chan@linux.dev>
References: <20260612023414.679618-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@gmail.com>

Use the kernel's standard symbolic task-state representation instead of
printing raw hexadecimal task-state values.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fcb421ced..4d4ebeeea 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3074,10 +3074,10 @@ rcu_torture_stats_print(void)
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
2.43.0

