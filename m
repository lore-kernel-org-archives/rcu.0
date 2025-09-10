Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F22417F0;
	Wed, 10 Sep 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517358; cv=none; b=udoU/ZwEoH5pzhtu56QAAfPe+scbSI7EWGSTMkDyhV+sXfpGzbJBm8bakE1WREH387VBXygFlZmwU/dZ74nKKCnDwUNcRLEsHbOjzG0AH474O/r8PZOA1OLfDlQFSj7FlxR+JvsjVDzfHmaE4C/Wprib5SFt2LTbD0rapUCQiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517358; c=relaxed/simple;
	bh=3V2RhjkO8Zues0nf8PudCy3D2eUe0xtHPXbYJiuCv58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohz5L+oGor35qblBAOevwMFLfxSFFMvXdgeCDVFR9CdQM1t+pbmRxGHYvCimlW8XuAGNw689cWdhGpnMq9AIYU7pBHHbcvnxbF/+jMVBotYfoClkjxu3QxkXYtjfikW5ek1dUlwr7QssFc3pKygs7gVd2CHIx8yxoRAjQsLqyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfowFosm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfowFosm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757517358; x=1789053358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3V2RhjkO8Zues0nf8PudCy3D2eUe0xtHPXbYJiuCv58=;
  b=RfowFosmf8uMJvu2voDGNYAG2WrFweLedE3XgMoqhFP4DOx2hAxuKTYy
   mEVIDjkaJL8dU+eu5V9R9tWtVgKkeAqOjDDQAqY4TfwHbdVZNl9Y1lrMa
   xPN6ixSgO3B7UltmwKnDyYCNvz9nqY2G4SKuhGMGLc1JbCd7rLHrW9gEP
   2jPviJBtRuDRzYMLwbo0f3j4MTXkBAuhHR/JfG58T78+btOez3lk2+Ua4
   YpvxGKIi+UMIsj1IafKHnYw22GfSsXpCfZCiKGSfuGg8K41Z+gQ+JtFTJ
   azV3AuJ4gtgfCV8d7OkRHjaznYf62EN2UjrosrR3THK1k18/lHrhY7LGu
   A==;
X-CSE-ConnectionGUID: Wyi+6Jp2SI66x1dUk+o67g==
X-CSE-MsgGUID: fwidlMz3RtO9L8qyj79/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70449459"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="70449459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:15:57 -0700
X-CSE-ConnectionGUID: 34v2EslQReK3eKvufQjeSA==
X-CSE-MsgGUID: cBSYEwz5SAeBrBLDLGfbPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="178624714"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2025 08:15:54 -0700
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
Subject: [PATCH v2] refperf: Remove redundant kfree() after torture_stop_kthread()
Date: Wed, 10 Sep 2025 20:44:19 +0530
Message-Id: <20250910151419.3762048-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary kfree(main_task) call in ref_scale_cleanup() as
torture_stop_kthread() already handles the memory cleanup for the
task structure internally.

The additional kfree(main_task) call after torture_stop_kthread()
is redundant and confusing since torture_stop_kthread() sets the
pointer to NULL, making this a no-op.

This pattern is consistent with other torture test modules where
torture_stop_kthread() is called without explicit kfree() of the
task pointer, as the torture framework manages the task lifecycle
internally.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Corrected commit message based on review feedback

 kernel/rcu/refscale.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2c2648a3ad30..2bfa987f4ba9 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1050,7 +1050,6 @@ ref_scale_cleanup(void)
 	kfree(reader_tasks);
 
 	torture_stop_kthread("main_task", main_task);
-	kfree(main_task);
 
 	// Do scale-type-specific cleanup operations.
 	if (cur_ops->cleanup != NULL)
-- 
2.34.1

