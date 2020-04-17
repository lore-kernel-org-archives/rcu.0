Return-Path: <SRS0=YclE=6B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C68C2BB1D
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 21:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B962137B
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 21:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIHO9lYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgDQVkB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728087AbgDQVkB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 17 Apr 2020 17:40:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A8BC061A0C;
        Fri, 17 Apr 2020 14:40:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k11so4680411wrp.5;
        Fri, 17 Apr 2020 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BX33Nlq2rNRQa3TPS+MKAJHFMMQ9tszkDs8MRHulQEo=;
        b=mIHO9lYzoEk0nC+E43MFKDhIVzbEx/1UEXaDSzp1LhuwJzXr+DTJtyxGXdVUaBVgoK
         y4mauhwmxJW0XVQMBmW0iZwPVb0wQuxD/zlGkqckFVt8rXcZiJufzFlRHNzDoTErptGj
         R/y4gUO+Wfb77d3/W0ALeMx+7/Nz3mH9JOuQAkBCrA1L2tJd3J6W4qvC4OIlS3Z9QXaU
         gsB1UwkhyCKnFHIt2NgwyMHPMlXP6pQzRBKsmpVMwaY8YhBotD8+dQBOFOIhWdOkE93m
         78QmaNqLg/EdkZcF2gZwBs+7oNDoRtX/uer5H4PaqkOmOQb0V/r9bESDv6oBW2IjdUGE
         eR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BX33Nlq2rNRQa3TPS+MKAJHFMMQ9tszkDs8MRHulQEo=;
        b=e5jyhHRPcXrR++841p6VOCD8PYdLapnPPcbmF29l6+1dXkdlDY4e6NeYdIGTSgF06r
         laRd5Ru4DJz3DtzAM0gZnz53DVGTdObIJ5L7L2dPc8F/fz8m+CM55T1MHsjrOfpgqwig
         IE/v3re60S0cWJ4nAdXiylyhpFWucpXFe87w/eRnK47dsq8cXqUEs+ROUpUun2mk3ytw
         5lnGqBQbdnndVrpaUn1UxZC2LQ8XdiHCx9JNTxlJGZeJChEZd3NLnujEeOoFELKu8d5r
         XHIYYZcmBf0GdIv4qOFRJByacZHOSoDZ2eF6huJ88/nkQ9sg489UWWcovqorESdU66rn
         UKMA==
X-Gm-Message-State: AGi0Pua1Kz2igEahNeEYj/YSJtXwS71L7Y7Sm9ZwU5JurLgTwBwU9o1q
        /lW7q+uNspgguZyq53A65m0=
X-Google-Smtp-Source: APiQypIDbikGNvjS42cYjvWs56Usv6lW8ne0pCO96idfnwqixzfmMM1zaKYnbjC4rxFS0Om1yU67Fw==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr5877118wrx.408.1587159599795;
        Fri, 17 Apr 2020 14:39:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v16sm9079325wml.30.2020.04.17.14.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 14:39:59 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] rcu: simplify the calculation of rcu_state.ncpus
Date:   Fri, 17 Apr 2020 21:39:51 +0000
Message-Id: <20200417213951.29837-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is only 1 bit set in mask, which means the difference between
oldmask and the new one would be at the position where the bit is set in
mask.

Based on this knowledge, rcu_state.ncpus could be calculated by checking
whether mask is already set in oldmask.

BTW, the comment at the last of this line is mysterious. Not sure it
could be removed or not.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/rcu/tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2..f0d9251fa663 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3364,7 +3364,6 @@ void rcu_cpu_starting(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
-	int nbits;
 	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -3381,10 +3380,9 @@ void rcu_cpu_starting(unsigned int cpu)
 	rnp->qsmaskinitnext |= mask;
 	oldmask = rnp->expmaskinitnext;
 	rnp->expmaskinitnext |= mask;
-	oldmask ^= rnp->expmaskinitnext;
-	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
-	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	if (!(oldmask & mask))
+		smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + 1); /* ^^^ */
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-- 
2.23.0

