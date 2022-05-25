Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39124C433F5
	for <rcu@archiver.kernel.org>; Wed, 25 May 2022 04:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiEYEpJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 May 2022 00:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiEYEpJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 May 2022 00:45:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC3D6CAB2;
        Tue, 24 May 2022 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653453907; x=1684989907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wLVrb2mDPuymkjNcS0m02nBtnQXINysoxGjT80/gozg=;
  b=XbVbWFDUYtQrscKCKwbsO00FiD4gEy6iVBfYYEOJhEgtrgn1hw7dFwuN
   aKInIG/pyAktmBIK43XAaDW4YQqdZnwlWlbuIY7bAHLW6EVpbCNdgqzYZ
   7pCxkW7eY9CdJ20SDVCjlFk2Wq5QuhPt5jiVItEfurVSlNAyaXo/NJdvx
   4XTkZxbXB77vZTM2u1QHGUSKP/BzSYX2/duh+riBeJ9lHrBN0O6aYZTTK
   y5yKTMpkwZ5PLTa+jNdsmEGDUSBD/j2cSl6C+mGSW/FGXrxZdVyul/oR8
   g2y2IvxW6mTvkfB/yxZQXOnJy3YZLCzKh2z+Hapg4m4pBJFnX6WKVVlem
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273442996"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273442996"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:45:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745519219"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:45:05 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Add rnp->expmask output to show_rcu_gp_kthreads()
Date:   Wed, 25 May 2022 12:45:03 +0800
Message-Id: <20220525044503.2083630-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, for expedited rcu we only check 'rnp->exp_tasks', however
the 'rnp->exp_tasks' are not always exist for expedited grace period
that not end. this commit add 'rnp->expmask' condition.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_stall.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2464b0eccfd0..5c4df855f2ac 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -865,13 +865,15 @@ void show_rcu_gp_kthreads(void)
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
 		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
-		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
+		    !data_race(READ_ONCE(rnp->expmask)) && !data_race(READ_ONCE(rnp->exp_tasks)) &&
+			!data_race(READ_ONCE(rnp->gp_tasks)))
 			continue;
-		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
+		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx ->expmask %#lx %c%c%c%c ->n_boosts %ld\n",
 			rnp->grplo, rnp->grphi,
 			(long)data_race(READ_ONCE(rnp->gp_seq)),
 			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
 			data_race(READ_ONCE(rnp->qsmask)),
+			data_race(READ_ONCE(rnp->expmask)),
 			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
 			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
 			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
-- 
2.25.1

