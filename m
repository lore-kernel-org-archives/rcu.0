Return-Path: <SRS0=TgV7=74=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B43C433DF
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A269B2067B
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203738;
	bh=a4n/BPdOkDbvDmgaE3yBM9LRJio/PspIgVLZ/Qy/444=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EPE0k3nEIZHLslsXDI9M5jQzcbzAMf4jMzbNRle3Q68v4WFyXIr7Dkz2/bLleP8u
	 eLYNQ8An7FcogBEkvOnaQDYohCWhjfMdt3QLfKESPw/MPBofJlVMFcVKG0R7aBRTSA
	 gKuJfUZpscGEygKwIbPWL7bnZi67Cu/1cABtWzkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgFOGrO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgFOGrN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:13 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAC02083E;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=a4n/BPdOkDbvDmgaE3yBM9LRJio/PspIgVLZ/Qy/444=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nubpUEZmnCHJck92I9MHv2PTLviZpuuSsuJOuO2nlqtNozSMYnDH3Uud5mazM5yk
         qZ6Oq0gANbUHOVIT0rRudzJ/0v2+JdgIqF91ffGgvEzC2QgFXv3mL4zQm8to7cVulS
         sfbi1Ujn4aO406jvOoyHBeKhVjB4sXBZDjIrdieU=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmb-LR; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 10/29] rcu: fix some kernel-doc warnings
Date:   Mon, 15 Jun 2020 08:46:49 +0200
Message-Id: <442c913556cba30f2f411e54efedcb97508f01a9.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
	./include/linux/rculist.h:517: warning: bad line:                           [@right ][node2 ... ]
	./include/linux/rculist.h:2: WARNING: Unexpected indentation.

Move the comment for "count" to the kernel-doc markup and add
a missing "*" on one kernel-doc continuation line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d181844..7eed65b5f713 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */
-- 
2.26.2

