Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615E308F38;
	Wed, 10 Sep 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496601; cv=none; b=Sr8EzDTbDRB1LLeL4qZpzHaezTktgumQZcRKVg/wkOXmoCwN0PGU5QLCjKuuBFsmN7ZEZx/JXNucYavcCDtqib1DWxp4DluCK8ZWPUMycwIrDbhc44ZcQ5AdQlxU7GZPIf/Vf8zBSV7cIPuFILPaGvgRHagKdr5i7q+5f3Sg+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496601; c=relaxed/simple;
	bh=kv801gF345C4oB+f+aQrqm6mpUznJyW9VneKUbtHrJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePokqRAG46exutauhG/KaJfPVEvGBcnprDez5Wy0MqVU2wcDcRUBdR8wRkSV6OVSL5UKoSPuz72R4DXkzE6tQYgd7bd98Yw2eh+7AeLnaiY+f+L6KKrVo4Ch3GXDK5bpgUWS8+W9muetqJL3dTGjpRcLcN3EV17AdLcYaI5a3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQwukn2D; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQwukn2D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757496600; x=1789032600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kv801gF345C4oB+f+aQrqm6mpUznJyW9VneKUbtHrJM=;
  b=YQwukn2DTLSc7FfB1P2gGWFo0jYIWdmS4OyKdGjjCpdcAs1tpzsq8Dxh
   rQOhHn5LUDshxbMr6z8HbtitWviKIkWbE4H23e4WgtatSh1XJwejnlwcV
   sad83t0jPEnI9UchiNTSnwG8FzD1qRd2PpdWlLJuuA3tHlXbIMUMSH5iB
   IipeCRTsrKGe2cdOaAN2KV0U60yqVMjzMqGBVdFE948NMK7aHLWaJJRlc
   3/ZEsJX5b8G2oGJCSt8Rh0Si/YRsBszLtaNgCrFI/3e/SOKnrdJ0R2DlU
   +hbT5ixhWzRNPdyrXA/xjArmlCGFjHhTy7M+uC970VMfE9xzmbsCEMQQx
   Q==;
X-CSE-ConnectionGUID: NGzgq0G2R9WR+HpeswV74A==
X-CSE-MsgGUID: ilTYxnqwSxOYbhpgB9Q0hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77257126"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="77257126"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 02:29:59 -0700
X-CSE-ConnectionGUID: UjLmF5dtR3eP67o4uAu2Iw==
X-CSE-MsgGUID: AOlBc/kCS7CIl0vTvM13Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="173724380"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Sep 2025 02:29:56 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] rcu/rcutorture: Improve error handling in rcu_torture_fwd_prog_init()
Date: Wed, 10 Sep 2025 14:58:20 +0530
Message-Id: <20250910092820.3736526-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure error handling in rcu_torture_fwd_prog_init() to provide
cleaner allocation failure paths. The current code checks both
allocations in a single condition, making error handling less
efficient and clear.

The improved approach:
- Check rfp allocation immediately and return early on failure
- Separately handle fwd_prog_tasks allocation failure with proper
  cleanup
- Remove redundant kfree(fwd_prog_tasks) since it would be NULL on
  failure

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Fixed word wrapping in commit message to follow kernel guidelines
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 807fbf6123a7..6af0d207adba 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2995,11 +2995,11 @@ static int __init rcu_torture_fwd_prog_init(void)
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
 	rfp = kcalloc(fwd_progress, sizeof(*rfp), GFP_KERNEL);
+	if (!rfp)
+		return -ENOMEM;
 	fwd_prog_tasks = kcalloc(fwd_progress, sizeof(*fwd_prog_tasks), GFP_KERNEL);
-	if (!rfp || !fwd_prog_tasks) {
+	if (!fwd_prog_tasks) {
 		kfree(rfp);
-		kfree(fwd_prog_tasks);
-		fwd_prog_tasks = NULL;
 		fwd_progress = 0;
 		return -ENOMEM;
 	}
-- 
2.34.1

