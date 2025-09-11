Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6F145A05;
	Thu, 11 Sep 2025 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567510; cv=none; b=AWBVLakyWzkabottOru7BWZlL101gMckXOBTRSi2t77us1Ve3oCMGQLijhjDpxCBNCTNE4EKb6G5AV6sGga3ZGkkage8NxSybbbpIWnwCPPy8inkw+D8eK7+8VjloiqxJU+dohXIYDKc4wUCLjOT+RWaCIAqDrvR69R0KSzWtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567510; c=relaxed/simple;
	bh=DZNDEhomn2dKx6sp8yYVz04Whv+Bm9aI/vTXFX2pAmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JBC3UEzfxaMSpqIhbKD883zAtJtx78qIYruqOYcA/bPU8NVAGrTVyTUxvhy056e5mBNLJXD12L5viRCmcN7V+DL/KxzgBDLnMfm0iEAlYZtqKz7wnBerKcAPH8QKGQUkwNDcSuqVrOSpOb8K+aFE0dO0wDFozKF7nIVx0WaVBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc0hLAlR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc0hLAlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757567508; x=1789103508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DZNDEhomn2dKx6sp8yYVz04Whv+Bm9aI/vTXFX2pAmA=;
  b=Sc0hLAlRXMhCqwRixj4EuwXz2r0Sc7W8SfggBjAoc66aJTFrur3NJ57X
   kYHRZCPjVsOtww+X1txjeDPKNIVfDxl2uA3JI3mWE0ssIwNucUokSK7ln
   Ag0ivyQEFjtlv2e9tx/ohHwUuc0sVQffv4RgIbWlM6izsvv1mC+lh/s0C
   a5kaebpZMvyOqHI2xOs/gGZ+hHj0SAlwAQu1T9lJSeQTFlt5AQr17l7YV
   nN4W9lRXSI0prasQWQjvpllIqUOvsg+kO1ypuJsWfPUVUdOkIQYVNSE2Q
   I3wzI9EP3fOL35Sxcw6WlUieIL6qPY0752LYl6QBLw/xmgoVe9t6vmhwo
   Q==;
X-CSE-ConnectionGUID: Lik+YQeHS8WGoiauXr0N7A==
X-CSE-MsgGUID: TQwAsNHiTtyQjuWFaK1YWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77498371"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="77498371"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 22:11:47 -0700
X-CSE-ConnectionGUID: NGY4dk6VQNGWhxY6v2gEaQ==
X-CSE-MsgGUID: xQpm+ZrlSP+CAQ3+4NLRmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="177629367"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2025 22:11:44 -0700
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
Subject: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Date: Thu, 11 Sep 2025 10:40:09 +0530
Message-Id: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rclp->len field is accessed concurrently by multiple contexts
in RCU operations. Using WRITE_ONCE() provides the necessary memory
ordering guarantees.

This change ensures that the callback list length is updated atomically
and provides consistent visibility across different CPU contexts,
maintaining the integrity of RCU callback list management.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 1693ea22ef1b..e10b36e9de54 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -71,7 +71,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 	rhp = rclp->head;
 	if (!rhp)
 		return NULL;
-	rclp->len--;
+	WRITE_ONCE(rclp->len, rclp->len - 1);
 	rclp->head = rhp->next;
 	if (!rclp->head)
 		rclp->tail = &rclp->head;
-- 
2.34.1

