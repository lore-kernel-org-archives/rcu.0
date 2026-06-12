Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D130FF27
	for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231738; cv=none; b=acwe/bBYkMmdZ9d9k8R6dmiB9BmpZecQ4JOdHRf4e56fhBZx6vnzM+V+2a1e4M2REokuCaFFb5CootOqrtNX7eVsXo9dMj6RZP5VFzwGjwmPvZyQ26SQn6MMW9VMcG+7jL8Kce6GLXtDcIHPnv2HALolzI58lawKIRv2Kg4CY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231738; c=relaxed/simple;
	bh=x+6fCpcN19Sd1TOECz68NnQlhLcF8vvudsNrQh05u6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMJlgOVDMzzGYNNaqTAEBjzVix8M3s91eqzFNlL8ns3LQbk+9Q02fh1nCFKQgWrinaOVi25+oAiAqyvQm2jlWtmk5kvsWxAjZJcn+/zKGk/LemxCSkdruvYT7wWEUZjk/Xk5yO3BzCZ43xEdOl77VlMsWNesGGEG6jjumkO7uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c/3TXTTP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c/3TXTTP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781231735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcWQQuMBxK6QH1hzTqiLhue/t83DTfgsChiZY2URapU=;
	b=c/3TXTTPkMsyQfkyxT3778mhIHshbEOXONFgjW/ms/9L3egotBYG4u0/t03Mmcpc8MvgL2
	+d6jrc3E3NFe3Kx8msQB4SS36E7Pz1aeYvoj+D8Xd2JswZFocueysIMJ3l4wqg/zl0BrsP
	lC4BFkf+awBxx2BvKcD5eINQCstEepM=
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
Subject: [PATCH v2 3/3] hazptrtorture: Use task_state_to_char() for task-state reporting
Date: Fri, 12 Jun 2026 10:34:14 +0800
Message-ID: <20260612023414.679618-4-kunwu.chan@linux.dev>
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
 kernel/rcu/hazptrtorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 0da0a4606..19ea479c9 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -497,10 +497,10 @@ hazptr_torture_stats_print(void)
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
2.43.0

