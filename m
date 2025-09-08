Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BB8C0B
	for <rcu@vger.kernel.org>; Mon,  8 Sep 2025 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757291538; cv=none; b=boOSJ2fqPlFborXZS84odXCN5Z7wuJDLNlADLTulm6kJT5RuJi1c0DReQ02x90GoGFgL3hQCLdJeZlfZYYiDUp24OnXosUmd/DyrRVbwhb4FJPzGxmIPG9UBL+0sBKUvcbz/Wft7ZdooihlYzfmqUSbYOmqSonJO9zYmzOFmZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757291538; c=relaxed/simple;
	bh=5QKsspVif7bTrYaXP3FasAnwvrnmS/iu0NY6fV7OK0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/j4ZaTJOc7OKdYOgIFeffQfhMmKvGb9wGH3qfOQBbasvFVElQ5C/B+1iLmf2aq3pMkcFDfDPSJ5YfmgEMWX99rx7ohvkGOVY904+NpPQXrKNBlVqDf4UHpm8n2R2jwLR18T+Ua+b5uFNFHS8COqovygVGArGyHF9Jf9AT8/Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zya+nmmb; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zya+nmmb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757291520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V84IucEUJyCvbiT+ZRJpmbheHpQNezq37q7p3Eb6jMg=;
	b=Zya+nmmb7/SLrAgIGuwQZL4zv4do2oePvoALMwGotmLIPGKS1TXo0e920NVfjCVh0jcTNK
	NHKGhafcpslhaidvLJtiMZSyWvh2h0k1INsOl8m/oMAHQDkDYpBar4gXJAIgJYyDZQFhpZ
	5hZNhwVfCGLUn7xAYiUfEQABfuHMJk4=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun.feng@gmail.com,
	urezki@gmail.com
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()
Date: Mon,  8 Sep 2025 08:31:55 +0800
Message-ID: <20250908003155.557070-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the srcu_gp_start_if_needed() is always be invoked in
preempt disable's critical section, this commit therefore remove
redundant preempt_disable/enable() in srcu_gp_start_if_needed().

Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutiny.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index b52ec45698e8..417bd0e4457c 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -181,10 +181,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
-		preempt_enable();
 		return;
 	}
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
@@ -194,7 +192,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
-	preempt_enable();
 }
 
 /*
-- 
2.48.1

