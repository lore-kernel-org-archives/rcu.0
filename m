Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5595BC433EF
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADDE61A52
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhKQP76 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238859AbhKQP7y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D7A761BFE;
        Wed, 17 Nov 2021 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164616;
        bh=z2E/+DyJF3ciNAiPoM8UMXFcWTkcpj8thvKrwqg0K6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8pMWFr3bFhS9blhvM9g+P9pcoqN5NMWkz/OmVg5dBdkgrmwe+htybTgdnWTVEB6k
         yC7kl2gqkkp2zWEDFi8omMT31o7K02H5fkiVQExd/WSZAa83O+1j2q6hGDM8OHvd4H
         lMxXe0+DudsPAzLBnz7LKM9mwdWbUF/W9n5pOuZk5WnTb3p0H1SE5EBWg4fpLVn9WL
         xjU+f3+FqaO+lF3CuqlqzvyLsK9R0P2EEmqmYonbPxZQt8TulkcHQ9geI0oF9qGMEa
         zkKDTcwUOWfi1H+l1tNO1/wnuD1wvRtdGZVTRIEOKn08Kp4CsKalDxzHYJU29p6PUb
         VW07LWGxynpLQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Date:   Wed, 17 Nov 2021 16:56:36 +0100
Message-Id: <20211117155637.363706-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117155637.363706-1-frederic@kernel.org>
References: <20211117155637.363706-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If a user wants to boot without any CPU in offloaded mode initially but
with the possibility to offload them later using cpusets, provide a way
to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
the creation of dormant nocb kthreads.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1871f15b8472..3845f1885ffc 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -66,14 +66,16 @@ static bool rcu_nocb_is_setup;
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (cpulist_parse(str, rcu_nocb_mask)) {
-		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-		cpumask_setall(rcu_nocb_mask);
+	if (*str == '=') {
+		if (cpulist_parse(++str, rcu_nocb_mask)) {
+			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
+			cpumask_setall(rcu_nocb_mask);
+		}
 	}
 	rcu_nocb_is_setup = true;
 	return 1;
 }
-__setup("rcu_nocbs=", rcu_nocb_setup);
+__setup("rcu_nocbs", rcu_nocb_setup);
 
 static int __init parse_rcu_nocb_poll(char *arg)
 {
-- 
2.25.1

