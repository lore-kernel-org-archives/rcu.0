Return-Path: <SRS0=xcwz=6D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4DAC38A29
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E8B218AC
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 21:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKzuADid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSV51 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSV50 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 19 Apr 2020 17:57:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885FEC061A0C;
        Sun, 19 Apr 2020 14:57:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so8821773wmk.5;
        Sun, 19 Apr 2020 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LUhndsPRRQPi2HaWdF48vPxwYi+a+dm3uqeYN1c8FzA=;
        b=TKzuADidOYpJW5KBPOlVdsOUC2Uk2LXbkJrXazh0e1AJ6X/3Dq6M6YTx4qButqPhHa
         6dQw56XqWfM3oXq0PR+FVV6yxOYlyN3LXlrnl7TzadsWc95QMbqYTPie4BoR19/XC/ZW
         161Cgmr/kqsJjqi/L9jLWPlTp6Ezm9gkaQqYOqVKjJVAlwqb85E/BZbsCRtyeQYKUuwg
         bSn8NgdH4QoOd8kfEh+sbt7jLJzmMWCzctyn/XJBWB6BW52DXLuIsMXvIxdG97yh/5SU
         vPtsnXD6qkQuy6ufw+YfAyTSJkp/l0DhPcmVBlVTL2uek9AqHA9+xYvQvIb7sFSnLXby
         rhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LUhndsPRRQPi2HaWdF48vPxwYi+a+dm3uqeYN1c8FzA=;
        b=BF7mPe045rGNT3hCly7ExWDTUHMdJJg5kJHG7LmI43a92WyUXGuzjWPm/1KrOl9G+3
         4AiyYn+oYh+f1xJt2krXtiSegbBXBnigDbiUWQTBJ5ZtcmORiJVeeCcmjdESGIJ7roO4
         hu/s06SI5ZNgvPbQ8UI5wtRnfEzzgNkNlaGm7wtGWFbKGf0XHSo4slAm0oyibGMsvSyL
         nIZP7JegRgUGGqm2AkDcY9yFanGSP4v93JYnNt7SJQ8UpDem3NkwrqzSAFdoJEVGrkYK
         iikIAaKLFBn8MHPnDuli8rtMPhaT+SBonb9Nz+wDLXopMwJakAtPNpTYvpoht3V6sgih
         Fbrw==
X-Gm-Message-State: AGi0PuY/4M+jYgVUMszJ7fL6KTfo7gZdHfE6kIoaTMHY7ouosUasltp3
        FdffhyzhOTnTeZL8S0AtI80=
X-Google-Smtp-Source: APiQypIZRr0sRFDC7uZDn1GVFRciegCPqv5Sr5AEzNhGZMBE9cUcr62pYihWOQReVQH/cC2vftlJXg==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr14824117wmf.85.1587333445342;
        Sun, 19 Apr 2020 14:57:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a67sm18086031wmc.30.2020.04.19.14.57.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 14:57:24 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2] rcu: simplify the calculation of rcu_state.ncpus
Date:   Sun, 19 Apr 2020 21:57:15 +0000
Message-Id: <20200419215715.21071-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is only 1 bit set in mask, which means the difference between
oldmask and the new one would be at the position where the bit is set in
mask.

Based on this knowledge, rcu_state.ncpus could be calculated by checking
whether mask is already set in rnp->expmaskinitnext.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2:
  * trivial adjust based on Paul's suggestion.
---
 kernel/rcu/tree.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477ee1c2..6d39485f7f51 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3732,10 +3732,9 @@ void rcu_cpu_starting(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
-	int nbits;
-	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	bool newcpu;
 
 	if (per_cpu(rcu_cpu_started, cpu))
 		return;
@@ -3747,12 +3746,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-	oldmask = rnp->expmaskinitnext;
+	newcpu = !(rnp->expmaskinitnext & mask);
 	rnp->expmaskinitnext |= mask;
-	oldmask ^= rnp->expmaskinitnext;
-	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
-	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
-- 
2.23.0

