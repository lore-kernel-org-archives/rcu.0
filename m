Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C8ECAAD3
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiIAWSE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiIAWSC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492B25809B
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so245555qtu.2
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8tBDdZaeoT3b5CBzqvW/ZB2aZTVcUlmvdmlRm1sAyM4=;
        b=QBkSAea3WwRWmhiRWRuvpOfEw+FTTLufqMSEdc1gAtyAq+xBunox+Nuh8C6IUqQDo1
         +LxFhVcyiQIx4jvB2azfPR7AmGcN5zZvubRtp5adhPS46cT5+VACoX35Em9rNj9ukK+M
         L11Wz8mOl+0mNcbPFv1bMoPDD7RhIAz59Gntw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8tBDdZaeoT3b5CBzqvW/ZB2aZTVcUlmvdmlRm1sAyM4=;
        b=07CbydzWDSn8rcmKSqd3MjgfGVuyzwQBBt0IrM78cWEiFqpeeYLkyToPgFpScpuNdS
         kQtmgJRkaUeHINnMLZj5RMhC1u2aBHAL/Bgaw6qCtoCqlHLUjUa2aIE87l5LJhhr+Tkb
         OaU3x/bUfiThbthubwAkasHHFCYHgZjXnkU+D1HJUzhIfiN8rUuFq4n4QAn66r3ZTIIa
         R/qn0Or21bSvGQ7d+7tdEQPXNjKtKzcHCYy7qdnOENFw6IEEwy56uTcF16hKjOtgfKT7
         EpkPAteffFmSsHdwpvePc8OK+NgvUEjlL0cxRabnYAwcOrSUSRaAwx6aX7ebafIIWvI6
         S4+Q==
X-Gm-Message-State: ACgBeo1k8TvnflZ0xf+ksLX85E/H2CdD1nv1kLPrultG69YIFQ6t4YYb
        cT2QTXSELxWfj19PfNVaTv8KTf8e8/2Bkw==
X-Google-Smtp-Source: AA6agR4RLjnlk0HhdTMZyE6uJDeBeCmArIKBraVqa1sV/k/4xV1xpnGzfyzL2EqEG8NqbDqWrq33bg==
X-Received: by 2002:a05:622a:649:b0:343:7b74:5cd1 with SMTP id a9-20020a05622a064900b003437b745cd1mr26095535qtb.407.1662070680221;
        Thu, 01 Sep 2022 15:18:00 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist happens
Date:   Thu,  1 Sep 2022 22:17:06 +0000
Message-Id: <20220901221720.1105021-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When the bypass cblist gets too big or its timeout has occurred, it is
flushed into the main cblist. However, the bypass timer is still running
and the behavior is that it would eventually expire and wake the GP
thread.

Since we are going to use the bypass cblist for lazy CBs, do the wakeup
soon as the flush happens. Otherwise, the lazy-timer will go off much
later and the now-non-lazy cblist CBs can get stranded for the duration
of the timer.

This is a good thing to do anyway (regardless of this series), since it
makes the behavior consistent with behavior of other code paths where queueing
something into the ->cblist makes the GP kthread in a non-sleeping state
quickly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484..31068dd31315 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -447,7 +447,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		// The flush succeeded and we moved CBs into the ->cblist.
+		// However, the bypass timer might still be running. Wakeup the
+		// GP thread by calling a helper with was_all_done set so that
+		// wake up happens (needed if main CB list was empty before).
+		__call_rcu_nocb_wake(rdp, true, flags)
+
 		return true; // Callback already enqueued.
 	}
 
-- 
2.37.2.789.g6183377224-goog

