Return-Path: <SRS0=BMES=2A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A7C2D0BE
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BC720726
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951628;
	bh=BDReUdnaJUFqWGBCbhb2xo/YCPUh9AgdHIKKe3dNJIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDI/JrkIdsDPkKkkXmXfgSQSb+dBoaeA5FN8UOHEB3NHkhn8sEGF5HE07oDKXlByB
	 CPBDnPk4TeUdObnTZImigqxMr/pG/cxh6JdH5UjimPkqR3QgOKwJ/pnphLpPXB4kNx
	 Wj8+7lxOJS6rAcTXlBWjuD0H6sGKUk0a2SA/AS7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLJEU1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfLJEUJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:09 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617C3214D8;
        Tue, 10 Dec 2019 04:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951609;
        bh=BDReUdnaJUFqWGBCbhb2xo/YCPUh9AgdHIKKe3dNJIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vntOJ4Sl9DUwzaJFTfWQcNNtlSgaTHE68Rk3Vluw7nO6azGtrIOGxn94cdVN0Sjwj
         kU2shBe4vqNSEr2teo/N2u9AxjOxyLLwOIdMUKXqbrXGO0LoCQAKPjIecfrHV37CVI
         48qJ4Anyp2O+PbiA3UIgZAftRTZI7GtkOGm6Cgqo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 7/9] rculist_nulls: Add docbook comments
Date:   Mon,  9 Dec 2019 20:20:00 -0800
Message-Id: <20191210042002.3490-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch adds docbook comment headers for hlist_nulls_first_rcu()
and hlist_nulls_next_rcu() in rculist_nulls.h.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 517a06f..25952c4 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 	}
 }
 
+/**
+ * hlist_nulls_first_rcu - returns the first element of the hash list.
+ * @head: the head of the list.
+ */
 #define hlist_nulls_first_rcu(head) \
 	(*((struct hlist_nulls_node __rcu __force **)&(head)->first))
 
+/**
+ * hlist_nulls_next_rcu - returns the element of the list after @node.
+ * @node: element of the list.
+ */
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
-- 
2.9.5

