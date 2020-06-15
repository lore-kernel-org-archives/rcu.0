Return-Path: <SRS0=TgV7=74=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B40C433DF
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 03:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E2220739
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 03:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2ZNveIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFODpK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFODpJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 14 Jun 2020 23:45:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D9C061A0E;
        Sun, 14 Jun 2020 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+aYX2ux/q51eD3HLApqZ1A0eTiLduHqKHnIo16Dk78c=; b=e2ZNveIHqiuDGBlS1FOloZhJPS
        VRJ1Pg1eHn5TOcTlFew4ddJWGv6GiiQxeBqHEWl43VZJyV8Y73VX4ePKj9GiCjx7RIcx0bu07XlfX
        4YCD90ClLLI5pVw9QcTnj/z3lpG8wHXkC8Cf+CypQkDLMG5m5iGipDA2bNdkUwzAt2CDA3ojgLYU3
        1o4L5VX61hgaqrdSB+P2ePvkhE/QH0gNSHF3tW/wGpTe14mX1EEOIicVhLgyS8ZmFgTaiUpOX8LU5
        9DiNHV1uX++tt3urxgIMvb5Jdgnz+F56Wlc0I+oYv/yxDL3qJmY0J1XDZO51ppGZBSEKSjrChlh+g
        l10wcg4w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkg3Y-0006V6-HQ; Mon, 15 Jun 2020 03:45:08 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] <linux/rculist.h>: fix kernel-doc notation & warning
Message-ID: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
Date:   Sun, 14 Jun 2020 20:45:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a kernel-doc warning due to missing a beginning '*' on the
comment line.

../include/linux/rculist.h:515: warning: bad line:                           [@right ][node2 ... ]

Fixes: 35fc0e3b0bd5 ("rculist: Add hlists_swap_heads_rcu")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: rcu@vger.kernel.org
---
 include/linux/rculist.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-58-rc1.orig/include/linux/rculist.h
+++ lnx-58-rc1/include/linux/rculist.h
@@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(str
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */

