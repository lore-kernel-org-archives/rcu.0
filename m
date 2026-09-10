Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B91381E9B
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030004; cv=none; b=Kl2g+XcncfmFzxnE4JDh08Eig/x+HPs3TaBwSrbJ3MKCxk3HQh06JBl7OxrE6e/QBdUzQyuj0BUHhwUA+m8YeV1Qko4W3lQndlbqAy1huEIY97b+MK2VGg8nym+vlxP2ScVnKDUN5TL3w758AqDxtET3psV2PrIIpntslnLiVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030004; c=relaxed/simple;
	bh=hbUh3rQBfS0CEmvKw72oTQ12KrtwMOmgyVSeu+dRcrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bq8HziSHl3IJq7dBXoYVJ2KfVKEv1YTGRJR+D9/ABat+Z/vpy/jttClBtecrCxvr53mBJR/Grk8cB9NmqUOODGmU09r1KPUc7vnPl2Jh9mIyqhRlyINHhBD9bPE9ICm5jUr3NdhAb2h80DH6o0Q4idzR2/09B7MqIcL8YaTfG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDEE6bFB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDEE6bFB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso2744020a91.3
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789029999; x=1789634799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FxV1JJHCtnNs5CLImEqWnGTFS1sK8xpOR5qbgGdf074=;
        b=jDEE6bFBxFtxXarQyvubqu3U8/G5/P0M3iZRLsN27mQhR1/Fj0LkIo9ULUq7kKFyUz
         TItNDZaSKbZSPJiqVD45bVG2MyjyfCXW1n2q/TL/R5Gq8uJ+uuM7WQAddsc66SrACn52
         7BPsZXYcKpp4KFeG+FovJ+upuZWdC2V3tJJ/xOuM8VgnR2C4OvVUOfWEQ0UYi5VFZmfP
         8q9EmpCZ0RAoShDCiN/8sFSj8GzZRuJtOb3hlxpzrbzn4Tq2GxVf20jZMSiKpLj8Txfa
         ah3FGwpuKbKGLbucQSRGPtlZFPl/qHE8x0xHiDA7HwAuZQzOAlylqtwWI1YDiDqsRh8+
         REMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029999; x=1789634799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FxV1JJHCtnNs5CLImEqWnGTFS1sK8xpOR5qbgGdf074=;
        b=US03VVCI9bWKwtkcf7QIHPvDJbzKGqczBkcn30V4cuiFCbq52YgaiPxQkqXQmMGk3q
         uAdmfgEo7AgndOtTQbjed5b+frMM2Axem0jRFOPaSvB6FnvIJoDgI6JYy7Hv3tkTNlEo
         LPbl+RJHXx4oftBHPoE93BUI4c5yMLV84MAQjEAlY/h9pz+7bdy2818qnJCVEPjzl9pr
         otm1P0KGOfHaxY+pYFfY82j6Qu8KyepmswxCaYFN1cEDU67xQjRtYvOAYCGRttaFZfFt
         DTMFzmuhFfzZ+TEanrJgKNxj63n9GPfZ8tVpaLH78QJBxv92MEebNQmyWwOQhn0962VW
         C41A==
X-Gm-Message-State: AFuF++m0sdaVam+CDiO55L3Wzd3C9P28G2W5CDqpbCLgFVxKbJCzXUna
	YK5UMduzqKFhADCcyQfiSR45NgDoPn/PRAs/mfmayF9kV/3KcuQtVUIy
X-Gm-Gg: AYBFou3FVgnuWIuYj9Cxhvv8T6gCuOv6FpdF/8+5/rJOaUPgKaG4eLCmaJtjLGUeTNJ
	vfVd/dqpShK8q/IyaqjurLCHo2hzfP4Q7hIg4wdf7xvdUkrtYai1Y6DwZxA93CpyGWF6aiMAm6x
	5fl5ZcrzJ40ocx8c26CbgqrfW6h9/sMV4fRnEsL8YB3ji957JLJ+6a9W+5s3S1czfZKPsYjQq/5
	MioEE5MFn5nkIZNx4o4X3SG04N3kBpkjxjD+EvYyK1CoyC7409xdC7bYb+XLjI1K2EnX1hNkq37
	p/etbE/gVLZ9YI6RW8UU1hIKt1QEy4SXV1JgbrgFmNA7rryEIQMrKzA7MNXi+X2XaACyxvef5I5
	N+XbbIu5F6V2Id6Pzeh1sKrGOaFIRj0oD9mQ8EkwkA7UGG3bfBI+hICAdpInDZYO1Gmdp5lGj5u
	hr2V+iezgU3qc7mVjTXKHCPAQoqjJC+czodp48+jL1JzaaYrRFVpWey25pRC2buUENihV5lrdj5
	llBST2epQki9AZTuuGDgdIGQ9GH
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr60867730a91.24.1789029999202;
        Thu, 10 Sep 2026 01:46:39 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7738f40dsm4551860a91.4.2026.09.10.01.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:46:38 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2] srcutree: Add WARN_ON_ONCE() for atomic SRCU in srcu_gp_end()
Date: Thu, 10 Sep 2026 16:46:29 +0800
Message-ID: <20260910084629.3695383-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic SRCU remain in the small size state, so add a
WARN_ON_ONCE() before the transition check to catch any future
code path that might violate this invariant.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
Changes since v1:
- Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
  per Paul McKenney's suggestion.
- v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 84c022ec8e09..68441c32cebf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1074,6 +1074,8 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	}
 
 	/* Transition to big if needed. */
+	WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
+			ss_state != SRCU_SIZE_SMALL);
 	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
 		if (ss_state == SRCU_SIZE_ALLOC)
 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
-- 
2.43.0

