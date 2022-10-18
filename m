Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531FC433FE
	for <rcu@archiver.kernel.org>; Tue, 18 Oct 2022 01:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJRBcw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJRBcv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Oct 2022 21:32:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51AD88;
        Mon, 17 Oct 2022 18:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666056770; x=1697592770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HU32EIXN4wgKHTDbR87eVWv30iu9Y/xR0IE3CNJy6TU=;
  b=FkCoaLILXtiWxzkcweXlG4iLlbrBtpyQPYYIUM96XWjTU6aZI6MKtIYN
   syAPf1spXfqRzq9MB3prPfSUHtx+DFPMqGnbBM+Qw9iDiomehvWNWTnYn
   MnIhLDrf0Ss0MlDqtX0riqrB1LjwJPky3VQuEfOhJoSz6zs8DQ3ICiuPs
   4h84lddVQMD26cbD9X9ehNKOUt0TGwBQR57tTOHa1HpxAygRuc7R5fsYg
   l023NO8X9S4fzCu9XJU7d3VQ2WCCph8L4QTA52MPpJNYAyB1p/gn5bCRL
   V1LO/FJGdCHQuVU5w3+sq46nShPRPcZg9kYLwX4vTySuCkVEvhEE3zaaz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392267428"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="392267428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:32:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="770986851"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="770986851"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:32:49 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
Date:   Tue, 18 Oct 2022 09:39:06 +0800
Message-Id: <20221018013906.3890007-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When enable CONFIG_PROVE_RCU and built modules, the following
error appear:

ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!

This commit fix it by exporting the srcu_check_nmi_safety().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 382236dd5e46..bcd629f5f902 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -651,6 +651,7 @@ void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 	}
 	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
 }
+EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
 #endif /* CONFIG_PROVE_RCU */
 
 /*
-- 
2.25.1

