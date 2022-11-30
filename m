Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D12C4167B
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 03:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiK3DgR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Nov 2022 22:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiK3DgQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Nov 2022 22:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240D7118E
        for <rcu@vger.kernel.org>; Tue, 29 Nov 2022 19:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669779316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knu5cAdyeUDxZbj26wvSd/uArOtHTGtbyR7uBrMeuqE=;
        b=WOJOdsOKxupF1iaVAeyYc5uZThJXfOXXY8dTsTfBmUtObRUaJk59OyIZank+SmdXYq9uaA
        dI9GGo64iN0BYCycl7yMrT2yd37A2+3xfAerJ1XMI6+BMreySNK9jwrpkR5a124u87wV0l
        eKjbmZhzVMJcU7naWAEl+gZwNB7IFiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-N6mVuR1SPGyV_F6EJJIBlQ-1; Tue, 29 Nov 2022 22:35:12 -0500
X-MC-Unique: N6mVuR1SPGyV_F6EJJIBlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9FB2185A79C;
        Wed, 30 Nov 2022 03:35:11 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 030832166B2D;
        Wed, 30 Nov 2022 03:35:06 +0000 (UTC)
From:   Pingfan Liu <piliu@redhat.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCHv2] srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
Date:   Wed, 30 Nov 2022 11:34:59 +0800
Message-Id: <20221130033459.16372-1-piliu@redhat.com>
In-Reply-To: <20221128082816.28518-2-kernelfans@gmail.com>
References: <20221128082816.28518-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
And it is not needed. Because counter_wrap_check has guarantee that both
srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
srcu_gp_seq and no false alarm will be raised by the statement in
srcu_gp_start_if_needed()

  ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)

As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
used immediately, not need to wait for another srcu_gp_end() to update
the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
---
v1 -> v2:
 rebase onto dev branch
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b25f77df9e5e..b0278d1e9c1f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1165,7 +1165,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 */
 	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_CALL)
+	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
-- 
2.31.1

