Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74C22A7E5;
	Thu, 11 Sep 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560790; cv=none; b=SoFN/V9D5/oPcmeuKuQ8bC5jvCfmyGSByiGaZ+zI1bs7nYRDw8GlGNS1o6yR0wpE4b4Svfmnl8fBKDb6EUtQ3MxLHJFigNGGnWFTmOXSFt6sb16IlHkKG95d/jUe2Cr9dboNBnZorwLA6Vmglm7AsSmuQL0+hE4zRH6iS1ViVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560790; c=relaxed/simple;
	bh=CnWcfRdhDm44FrdS21Owr4K7j5aEacKDDnY4mWRjHDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g76s9xsOtg8hBdZcGy5w1t4lv0MOIhHk3685bzc3+zaS0FuJYPWfBifHcZIr/RlPxD3BHrs73P4cVy3t5zDhsHWyJvTFmJCHSuaiWTzlpDnE8FSSB/IT1D2/vuztgdxZe+aPe5lLW0J/um/DsjvkiwXGO26tSn8H6eNA0S6xSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG7EX1EG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG7EX1EG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757560789; x=1789096789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CnWcfRdhDm44FrdS21Owr4K7j5aEacKDDnY4mWRjHDQ=;
  b=PG7EX1EGi03fVvDafxVz7mLMEM++n3jxuz2+NBRoXwmDXQz0m32JL8eP
   Qs+Tcbzc9/phWOkSoDdB5iCyUBMatlNt9qfFVWkZytfy5cmsrs2g0GwwO
   ftJ82PMlzQQxmeGVo3AcsRUXB9JYcanW8jkzsIyNcFW7L4ntA2BNBVb2F
   Wy+3SJdX+Lns1xWMxCimp/MStTAC39UVkK8M6ALqqAhdtHWHvsmEGVEbQ
   cEdeFdHk1KUUsRtEwm4zF3lP2M3pHPMX/1rUmGHXp5Km0LnWSzZAPOZ3p
   IVyyx3+hukRAr3U1aViYZEEvRRze4fdwARvsC8yN39eOqpJlSBsp/7CtK
   A==;
X-CSE-ConnectionGUID: /bukOLPtS2Kq+S7oWgNJzw==
X-CSE-MsgGUID: 6zaaIjoDT0yjI8SPgjS0QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77491909"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="77491909"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 20:19:48 -0700
X-CSE-ConnectionGUID: H6+uf7lFTc2+Zf3cK+EDjw==
X-CSE-MsgGUID: SSF9dG1aQjO7JELEq6ObZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="178767698"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa005.jf.intel.com with ESMTP; 10 Sep 2025 20:19:45 -0700
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
Subject: [PATCH] refperf: Set reader_tasks to NULL after kfree()
Date: Thu, 11 Sep 2025 08:48:11 +0530
Message-Id: <20250911031811.681694-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set reader_tasks to NULL after kfree() in ref_scale_cleanup() to
improve debugging experience with kernel debugging tools. This
follows the common pattern of NULLing pointers after freeing to
avoid dangling pointer issues during debugging sessions.

Setting pointers to NULL after freeing helps debugging tools like
kdgb,drgn, and other kernel debuggers by providing clear indication
that the memory has been freed and the pointer is no longer valid.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/rcu/refscale.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2bfa987f4ba9..47486dff43ca 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1048,6 +1048,7 @@ ref_scale_cleanup(void)
 					     reader_tasks[i].task);
 	}
 	kfree(reader_tasks);
+	reader_tasks = NULL;
 
 	torture_stop_kthread("main_task", main_task);
 
-- 
2.34.1

