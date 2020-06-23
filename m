Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4337C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CE02078E
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871012;
	bh=axAbcbkmrw/8RcIa1j4sVSgbYzOp8E+mMMYo6eFBOOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eqi9QmzdXxrezeatHSTh3XuvcgNm1l7kLXjXmlA3RtEbG0xVv+oo8cCWt5nk+U+sQ
	 E7Z17XfGAJsqZLV66LSSMAi2bg1XGBUZX0XKSI9yylvTM/nwlkn1yfRlmYmpde8JAx
	 9122X9HzIdWedEOppDFo+bv0Q7dXXcnnTadIb9Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgFWAKL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbgFWAJv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13AD1207DD;
        Tue, 23 Jun 2020 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870991;
        bh=axAbcbkmrw/8RcIa1j4sVSgbYzOp8E+mMMYo6eFBOOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0Fuq5eWW7poKIPGxClebIR26M6mTVmQH3h6qYzLokvyoICjdi7nEk5H6pqrANQcC
         mnwXn1kg88ypuWbZf6Jn/pn2ZHt4jLSbua075wUn8nP4lpwyVzLFjFB67o+w24jgrw
         Gl/k9q8ZlaUZ2I5V7/5riiIkAc8KZu9lr/XTI6H8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/10] docs: RCU: Don't duplicate chapter names in rculist_nulls.rst
Date:   Mon, 22 Jun 2020 17:09:45 -0700
Message-Id: <20200623000947.25222-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Since changeset 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst"),
auto-references for chapters are generated. This is a nice feature, but
has a drawback: no chapters can have the same sumber.

So, we need to add two higher hierarchy chapters on this document,
in order to avoid such duplication.

Fixes: 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index d403742..a9fc774 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -10,6 +10,9 @@ objects using SLAB_TYPESAFE_BY_RCU allocations.
 
 Please read the basics in Documentation/RCU/listRCU.rst
 
+Using 'nulls'
+=============
+
 Using special makers (called 'nulls') is a convenient way
 to solve following problem :
 
@@ -126,6 +129,9 @@ very very fast (before the end of RCU grace period)
 
 --------------------------------------------------------------------------
 
+Avoiding extra smp_rmb()
+========================
+
 With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
 and extra smp_wmb() in insert function.
 
-- 
2.9.5

