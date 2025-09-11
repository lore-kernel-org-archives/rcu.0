Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFB3570C5;
	Thu, 11 Sep 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608100; cv=none; b=jYcDciE0o39yzkWSazn1KXTqdTsLcpQdI3PJBV1AAuBb/jAVvJKGGRbjj6LzclQRwrCBzdWNS1IieVRB9u3xo2ULJ0ptny45PY3ZYSbVHK5e6SJT7yBThtZ8c57GGzBY41mGlzotHwb5jh96TroC+MDAYVIDYWu1WFA4WD1wymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608100; c=relaxed/simple;
	bh=0U2XYAgTUHtubCy4XmKchLUF2K2afWGwNzkFU3Waqeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pIXOExgOCy9vkdzn2CmSL2Oo0MHrSRUbzi4K2+aqKR4BnsbtpgAK148Mm8yYMuC2Qyny+labmK/BflbvkM7Rcdb6+lFyBDzSkwaPplYlvjQyc3YunPIqk1ifwxApaneUDt2BLEmajosAMoeXLovAYRdKiFc3bg76INHZBboRdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SofNKtWY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SofNKtWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757608099; x=1789144099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0U2XYAgTUHtubCy4XmKchLUF2K2afWGwNzkFU3Waqeg=;
  b=SofNKtWYUAZXygh4ltTjccVTMyfC15roSlxWoYT5DjSwka+2TVa/esYq
   dcg+x1++l3qI/qmFsMd3L604l+TDmMDgcpxRr3/EaORr7mz8s+aarbSlv
   o+Q/gatzvo5b5Pk8qnS9p8HRL45fj3Ogp5b717/0ZquqYwCLWdYN6KUXz
   MH2zJ6P/aYxGXkmEgHnHP7pGaKC90l/I+kIEV2FAXyMaJhUNLxHo8J/hm
   vA2mz8bXF5N1o+MTDcNTH9owe4U/Di6e7a+DiDd4bgUi2QQw2PY3/3NV9
   BQ1SKVuAOHpl+LauIglOrQgLGkgA19TdiKEU6iHdUr/Y8tV16n3x1fX2O
   w==;
X-CSE-ConnectionGUID: 8Glp9RvESnyxkrFOa558Mw==
X-CSE-MsgGUID: 4ZlUofDSSpWNibXYreVUrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70566383"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="70566383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 09:28:18 -0700
X-CSE-ConnectionGUID: oDRI0hMXQ9ujkyEdob4mAA==
X-CSE-MsgGUID: ISGZkmtjTfSqPrxsw/ikmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="177765580"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa003.jf.intel.com with ESMTP; 11 Sep 2025 09:28:15 -0700
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
Subject: [PATCH v2] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Date: Thu, 11 Sep 2025 21:56:41 +0530
Message-Id: <20250911162641.796716-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use WRITE_ONCE() for rclp->len decrement in rcu_cblist_dequeue() to
maintain consistency with rcu_cblist_enqueue(), which already uses
WRITE_ONCE() for rclp->len increment. It maintains consistent access
patterns to the rclp->len field across both enqueue and dequeue operations.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Revised justification to focus on code consistency rather than
  concurrent access claims.
- Revised commit message to use imperative mood throughout per kernel
  documentation guidelines (suggested by Markus Elfring).

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

