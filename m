Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CF9C4332F
	for <rcu@archiver.kernel.org>; Sun, 18 Dec 2022 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLRTNY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 14:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiLRTNW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 14:13:22 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577DB86F
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 11:13:20 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h26so2955225qtu.2
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj6H6w9xKIP6KzPO24qnEpNiKICnr312xMbSiquwZ1w=;
        b=pt4vXBs6yibcCzpDPgkrFJCClB6mn1GvJAD4rIJtqm5ruo1W3/yInjv/vqqLoHGWV7
         AF+fvogP7zG+31uqmGJp3tTlhfgpy9pDMUfo5H4aip1QWDMpt9fDgZNiuTaRExct1+WF
         hxgnAhD75gKG4kh/Il0+8ELUmXdFXEhTwAHq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj6H6w9xKIP6KzPO24qnEpNiKICnr312xMbSiquwZ1w=;
        b=awqd5oFFAan7IvTpXl0MFX+/a0x3s8+7cFRdBFdZPqqnTUMetd1HLGtDCyQ9AHomgW
         LAD9tiMZuau17kvQ80jTFFawl4Rf9MRDaoJ1ipD6Zf4GS2o3F4D7ahV6Ywt0U/y7p2Fw
         adx1PGoAxGPxkP+J3O41zuEyE6JIjX3dIVh+VtSiDaiyqbhsEcgnPFaL/tyM+QYO3GZ6
         dQSQORWtJmdrD7ejYHBqGGkfg+9m527ynHBVcGbYiM0K29x18SL+Etv8cEokn3A5BLBP
         RvW3vauZtK+azTHU9S0xV3UJzaW7wjidvcVAIK+10aTzIR/ggCoBXc0RHlmtz9d3n9yg
         6z6w==
X-Gm-Message-State: ANoB5pl6aDBbYLEaruzQqR+cIvlzxlX80W3Me1zgPtWbm20vX/fcSnvc
        +deeRDFA/E2vBmuVwiS9HWZDJg==
X-Google-Smtp-Source: AA0mqf42snSRGMzcQvB7R3GsQPL2CIth1zNWtzZ5ziKLDE9SS8vmD/GNAmyZghshkyxYgXjhroqn6w==
X-Received: by 2002:ac8:5292:0:b0:3a7:f183:7f66 with SMTP id s18-20020ac85292000000b003a7f1837f66mr54074448qtn.22.1671390799594;
        Sun, 18 Dec 2022 11:13:19 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id cq8-20020a05622a424800b003a591194221sm4952864qtb.7.2022.12.18.11.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 11:13:18 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC 2/2] srcu: Remove memory barrier "E" as it is not required
Date:   Sun, 18 Dec 2022 19:13:09 +0000
Message-Id: <20221218191310.130904-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221218191310.130904-1-joel@joelfernandes.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During a flip, we have a full memory barrier before idx is incremented.

The effect of this seems to be to guarantee that, if a READER sees srcu_idx
updates (srcu_flip), then prior scans would not see its updates to counters on
that index.

That does not matter because of the following reason: If a prior scan did see
counter updates on the new index, that means the prior scan would would wait
for the reader when it probably did not need to.

And if the prior scan did see both lock and unlock count updates on that index,
that reader is essentially done, so it is OK to end the grace period.

For this reason, remove the full memory barrier before incrementing
srcu_idx.

6 hours of testing shows all SRCU-* scenarios pass with this.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d6a4c2439ca6..2d2e6d304a43 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -982,14 +982,6 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
  */
 static void srcu_flip(struct srcu_struct *ssp)
 {
-	/*
-	 * Ensure that if a given reader sees the new value of ->srcu_idx, this
-	 * updater's earlier scans cannot have seen that reader's increments
-	 * (which is OK, because this grace period need not wait on that
-	 * reader).
-	 */
-	smp_mb(); /* E */  /* Pairs with B and C. */
-
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 
 	/*
-- 
2.39.0.314.g84b9a713c41-goog

