Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89402652B4;
	Wed, 10 Sep 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493490; cv=none; b=evqszAWRInV4WpHk+jw3+zsM2AiFeM7K/DTeIWlA/uTa945NfTsP8oqPm5LjHWpX0zK7pSOYTRkxV/VLfFkgm7zHLUD8seOA5nNmJXLWhvX2O3XRhIGCu1fw4kJX2Jm9CE6AO99hwXLzSqyfeTsdeVDLcEwbftG4fdPz3H8CzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493490; c=relaxed/simple;
	bh=XBDNBJDNr0UJjLQYcndQN6qQVg9Go32A+2tj/Iq5mCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iM4pieJ1iMrYAgXarR3xhc4efsYKrlsss5kMzRbSxsfaGAY+VjCI5YkNf5xqJclp01mwyNvXd9e0iUnK6jOjdGvSfrjLf+INsYUbKri2+huo8nQRMvOBB681Q9ZKDP57zZEUCB4OwhjPjbQfXcQQiKJfiYf0XHLx5Q4WY13lDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/j2GoIt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/j2GoIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757493489; x=1789029489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XBDNBJDNr0UJjLQYcndQN6qQVg9Go32A+2tj/Iq5mCQ=;
  b=N/j2GoItqatyiLpnMCWMtQH5JzGWyZysz+VZVJQnOcrZ1zy/ScG95Dgd
   PHLHMxHtnMKZJr51CqOYgPnLrdTeEd9CDDHE4c0fs20fH5kBjLhE39les
   seS7IGZB+VdLkGkbud/YARBxf8ub1nZaK7MxCYpDO39yvbZvpgs7MyCsG
   sJXONdw32rMaLmx5I9HTPbot5bd8qvM/NUpMZfHEjDrjYCqtVLEa9JL+d
   BXGhbGns42L6Qf7hbK0tfv0PXGzRvxvj72AosDpKMmk60w87DgghyrcGz
   6K7OLGITYSxkGYMMeOcjNlUd5zL05kTdry7MMPMkcVUV7F5whBiqKJe+w
   Q==;
X-CSE-ConnectionGUID: gPtF5F89TamNs5ZNORUxNQ==
X-CSE-MsgGUID: ECryIo+xQ5iFxq1k/lUM3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63626418"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="63626418"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 01:38:08 -0700
X-CSE-ConnectionGUID: mOXX6+MBRPOQHir+HpMmDg==
X-CSE-MsgGUID: 8gaJWDXoSQyrfbX904jhDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="173239179"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2025 01:38:06 -0700
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
Subject: [PATCH] rcu/rcutorture: Improve error handling in rcu_torture_fwd_prog_init()
Date: Wed, 10 Sep 2025 14:06:30 +0530
Message-Id: <20250910083630.3735022-1-kaushlendra.kumar@intel.com>
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
allocations
in a single condition, making error handling less efficient and clear.

The improved approach:
- Check rfp allocation immediately and return early on failure
- Separately handle fwd_prog_tasks allocation failure with proper
  cleanup
- Remove redundant kfree(fwd_prog_tasks) since it would be NULL on
  failure

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
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

