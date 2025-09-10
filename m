Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3C28C2CE;
	Wed, 10 Sep 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506568; cv=none; b=u/4MERzjYTdlKJ2EYIRSWb3xDSXtyQBVqn0LI8wqFQSTsaA6e4FCnw2FPBTsizI0G5ttz+rmvVZ2su9p6y08ugr4siNdZK5fcl6ar3GDlkaw+MxD2YKYbWgN3B2pdO32qLrIewW7Mma0hQtGH74ouPbL+huKL6K1pR/XfXYNtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506568; c=relaxed/simple;
	bh=g6AyXFzGOOtrtSINboRZHVMduybQL9dPz+W+Dc8Jf8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kzFTYEozHxFOoo2x2q4vesseK860jQ4Jvde/Y2Fd4js/TOttigewamvOmQKyV0MgyGokHa9mxZXVsAkgbWikm/2eqvWnREG1uCePgatKNmRgl8EY/J31Rru0diMljNZLtA9VrZQEvjQStyWcf0OIfwG6uqk8TJ11AHI4fUhNajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRcASHLu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRcASHLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757506566; x=1789042566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g6AyXFzGOOtrtSINboRZHVMduybQL9dPz+W+Dc8Jf8s=;
  b=bRcASHLu88juj0nD2aOJo6qgcYwhys1fOnoyRG0nPF5DMDNYFtaSfi2w
   JYxneHDIPfVn/n0w8k0vc//9t+M4kZI6K7gWcdZhJeAZx58r7VwgkvIS7
   bYeCVlT2GduVTsoBkzs9vcfPrtZxejWoxp+enUT/XcLNdSn//IathD8tV
   EkqAPCIp1O0P9ILkuQ9RQz9GpTK/CV2272iwIg6TbPlp5am2Pzc3fNfNv
   Fp3jJA9O7DZGoHOX9lXO6E/lO63s4SzceJejJ+FcicE5eQwyd6gXJ3quX
   6/LDUKG3w2qPArSFoT475W+nNZ722Ley9o0L/sQ0O8kFoJp3cpW45dNY3
   A==;
X-CSE-ConnectionGUID: 225iJJsCQt67h1seoo8wjA==
X-CSE-MsgGUID: zbBMLNmzTiWQu4Yf9nzzfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59889035"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59889035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 05:16:05 -0700
X-CSE-ConnectionGUID: ezuoy6rDRXabEgsJPctGbA==
X-CSE-MsgGUID: DUfIcSTBRGS1V9044/ofQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="204360475"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa001.fm.intel.com with ESMTP; 10 Sep 2025 05:16:02 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	markus.elfring@web.de,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v3] rcu/rcutorture: Improve error handling in rcu_torture_fwd_prog_init()
Date: Wed, 10 Sep 2025 17:44:27 +0530
Message-Id: <20250910121427.3757718-1-kaushlendra.kumar@intel.com>
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
- Check rfp allocation immediately and return early on failure.
- Separately handle fwd_prog_tasks allocation failure with proper
  cleanup of allocated resources.
- Remove redundant kfree(fwd_prog_tasks) since it would be NULL on
  allocation failure.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v3:
- Fixed word wrapping to eliminate orphaned words (runts).
- Removed duplicate marker line in changelog.
Changes in v2:
- Fixed word wrapping in commit message to follow kernel guidelines

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

