Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A1C32771
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA64C20702
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 08:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgA0Ivl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:51:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:31594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgA0Ivl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jan 2020 03:51:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 00:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="231359133"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2020 00:51:38 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iw07O-000FEM-0l; Mon, 27 Jan 2020 16:51:38 +0800
Date:   Mon, 27 Jan 2020 16:51:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [RFC PATCH] rcuperf: mem_begin can be static
Message-ID: <20200127085112.4em4vfyydx6h6rf2@f53c9c00458a>
References: <20200115224225.246061-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115224225.246061-2-joel@joelfernandes.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


Fixes: e4b6bfefb245 ("rcuperf: Measure memory footprint during kfree_rcu() test (v4)")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rcuperf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index c41f009acbbb5..4f642e7b25fa6 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -617,7 +617,7 @@ DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
 DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
 DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
 
-long long mem_begin;
+static long long mem_begin;
 
 static int
 kfree_perf_thread(void *arg)
