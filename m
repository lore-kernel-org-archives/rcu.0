Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0EDC433E0
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 17:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894F42078E
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 17:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405622AbgFXRrp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:47:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:12713 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405546AbgFXRrp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 13:47:45 -0400
IronPort-SDR: F3OQ+/MH8OUCZx0jW0Og2HSO8f7clPPsnLzzaKcuLLRITzz0UmT1wEm3OHO7LlmgeMWXC7dLRU
 J8xM1f5x6+Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143679704"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="143679704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 10:47:44 -0700
IronPort-SDR: pKwC9gtocdlLFRVNqwiu4eEK/TVuPpGstDTDgDtFS9FnLpEss229oT3wRUnqPuHb97byjQcD7o
 Jh2QMM3g8MuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="479195279"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jun 2020 10:47:42 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jo9Ur-00013r-Ng; Wed, 24 Jun 2020 17:47:41 +0000
Date:   Thu, 25 Jun 2020 01:47:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] refperf: __srcu_struct_srcu_refctl_scale can
 be static
Message-ID: <20200624174709.GA165567@6b4061f35fb6>
References: <202006250116.MYIhw039%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006250116.MYIhw039%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 refscale.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d9291f883b5428..4097b53867b33d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -159,7 +159,7 @@ static struct ref_scale_ops rcu_ops = {
 };
 
 // Definitions for SRCU ref scale testing.
-DEFINE_STATIC_SRCU(srcu_refctl_scale);
+static DEFINE_STATIC_SRCU(srcu_refctl_scale);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
 
 static void srcu_ref_scale_read_section(const int nloops)
