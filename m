Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25C342CB6
	for <rcu@vger.kernel.org>; Fri,  5 Dec 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947078; cv=none; b=KdyT4rMLInGB7AyDoiEwkqHflIhRCBK39YBW9VbUeE4g+xNcXJ40FqkakI4vyGIhlQWQ946TKilAw5OGgOvrhsVoohmOi8QqUYlVuVhjWfUcoEoIFTQTBdJsBiKLSkDVpwFkXg6DWp+5i4GIrNqUU8xeaMNmCqrK8UzuPpgLtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947078; c=relaxed/simple;
	bh=nYT7isDKY+85JOut7iFZMlCCqtn2hqYU80NfGHcx+nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Syi6dIt6Tml2qW1VxvU+yvFtG7o7eg3P1C+ETIWuZbFvk0e2V+8CXwZIwSlp5pWQZiB1WeXwAoxaNVtddG2g3aeLljvsBziNlIGjrPIC5CIiOZkpjPCtH5KlSR4uIvUKpo25EcHNI8Ls182gG95Rw/+OUxWmwd+kqX8HUh4FbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g7NWUtmz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g7NWUtmz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764947071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfjsCfDepFkRsERBSNdNVFzU0a98Vk8eoknXHBcn6wg=;
	b=g7NWUtmzuJtJ4ooH8QKth4n0o5/HF4FFMqOfsSsH7OwoBBpOj0rYTRlBzEqoPRyNrs0fJe
	igPdNAyvRkbuA95FojuPxbKAHg9vJFRXTncbasmIa8cSQEkXY6bX++qgIBs3NqJ4yTDfYW
	9hHtq+q37Ey7oOS3ay7nQ9L/meICoIg=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] rcu: Improve comments for RCU_FANOUT and RCU_FANOUT_LEAF
Date: Fri,  5 Dec 2025 23:03:35 +0800
Message-Id: <20251205150335.1681196-1-kunwu.chan@linux.dev>
In-Reply-To: <f2ca1650-0bbc-48fb-a6d9-6c4313325a1a@paulmck-laptop>
References: <f2ca1650-0bbc-48fb-a6d9-6c4313325a1a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Add explicit explanations of the overall purpose of RCU_FANOUT and
RCU_FANOUT_LEAF parameters: defining middle/leaf fan-out parameters,
their relation to Kconfig, and how they shape the RCU hierarchy based
on CPU count.

This makes the hierarchical configuration logic of the RCU easier to
understand.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
Changes in v2:
- Restores the original #else #endif comment format
- Reword commit msg
---
 include/linux/rcu_node_tree.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/rcu_node_tree.h b/include/linux/rcu_node_tree.h
index 78feb8ba7358..a87ca215de4b 100644
--- a/include/linux/rcu_node_tree.h
+++ b/include/linux/rcu_node_tree.h
@@ -25,11 +25,18 @@
 /*
  * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
  * CONFIG_RCU_FANOUT_LEAF.
+ * - RCU_FANOUT: Controls fan-out of middle levels in the RCU hierarchy.
+ * - RCU_FANOUT_LEAF: Controls fan-out of the leaf level (directly managing CPUs).
+ *
+ * These parameters are determined by Kconfig options if configured; otherwise,
+ * they use sensible defaults based on system architecture (for RCU_FANOUT)
+ * or a fixed default (for RCU_FANOUT_LEAF).
  * In theory, it should be possible to add more levels straightforwardly.
  * In practice, this did work well going from three levels to four.
  * Of course, your mileage may vary.
  */
 
+/* Define RCU_FANOUT: middle-level fan-out parameter */
 #ifdef CONFIG_RCU_FANOUT
 #define RCU_FANOUT CONFIG_RCU_FANOUT
 #else /* #ifdef CONFIG_RCU_FANOUT */
@@ -40,6 +47,7 @@
 # endif
 #endif /* #else #ifdef CONFIG_RCU_FANOUT */
 
+/* Define RCU_FANOUT_LEAF: leaf-level fan-out parameter (manages CPUs directly) */
 #ifdef CONFIG_RCU_FANOUT_LEAF
 #define RCU_FANOUT_LEAF CONFIG_RCU_FANOUT_LEAF
 #else /* #ifdef CONFIG_RCU_FANOUT_LEAF */
-- 
2.25.1

