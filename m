Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62583ECAAA1
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 03:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiIFDHN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Sep 2022 23:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiIFDHK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Sep 2022 23:07:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058D6BD50
        for <rcu@vger.kernel.org>; Mon,  5 Sep 2022 20:07:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x5so7133459qtv.9
        for <rcu@vger.kernel.org>; Mon, 05 Sep 2022 20:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Iof3uBcXac1OYnK64M0AGcn2zYxIce4MLzQivYg+G8I=;
        b=ha1poO5zWbhEaZKUgA8TxySFc3/vws2jUihXcjUuExpPQwbl8xVSos3TONo6CUTFia
         7fKZdMWbVHbGLFk97gnXZsb0uotv/dWxGnDewNqy+RpoAcvvczlHmGO17z/iPch6eegK
         SvZFdIz9FNUh80v4b884QXTlKvhE3AWjauvMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Iof3uBcXac1OYnK64M0AGcn2zYxIce4MLzQivYg+G8I=;
        b=6b2imaz0yebrPmJYxSKHmDukCQfGdRVMxg5da/mMWmOCWs2e3KwZAFi7MnlNRHwKDr
         Sho5I7rZuL3bVGXGlW8Uwegjt8UjU5E1GFLdekpNnKL17maqAHIdICBS7lkcda6a/wpv
         Va8fYhNr8sVueSWSMIS3Yf0+xS3oPY9zMlE1mTUJpDlh986j9FutRWB/ZibS9A+bNYov
         SZYpN9ua8XjB1uXDPHxOyvmG/h8KHoAEEzZb4kvD0Q5c1r5QqWgjU7TiDfNSIkwa23lh
         8OAqtSnJkL8x1cPwFcr15Scq7FF1WDI8+CKOteXOeUNmZQPhgL2GIsxZNr9EyhU+9fF+
         aTkA==
X-Gm-Message-State: ACgBeo3yNynu/b7NaZ8SBsexd7v4/K6G2gb+PktqislKNqeSfTqrBGFK
        yWO4AkqyBjENE36aI5AInVcAKV1UdVJ05A==
X-Google-Smtp-Source: AA6agR4ltdgdqPGHRrF4utjX7sVSXd/S+WYKGkbHWU246ikvc8x+/mInugwob/XCXHxA7YLgbGF93Q==
X-Received: by 2002:ac8:7d13:0:b0:343:33d:f03a with SMTP id g19-20020ac87d13000000b00343033df03amr42352278qtb.500.1662433625868;
        Mon, 05 Sep 2022 20:07:05 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u16-20020a05622a199000b0031f0485aee0sm8714928qtc.88.2022.09.05.20.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 20:07:05 -0700 (PDT)
Date:   Tue, 6 Sep 2022 03:07:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass
 cblist happens
Message-ID: <Yxa5WVwwcDmCL9Dw@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221720.1105021-5-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 01, 2022 at 10:17:06PM +0000, Joel Fernandes (Google) wrote:
> When the bypass cblist gets too big or its timeout has occurred, it is
> flushed into the main cblist. However, the bypass timer is still running
> and the behavior is that it would eventually expire and wake the GP
> thread.
> 
> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
> soon as the flush happens. Otherwise, the lazy-timer will go off much
> later and the now-non-lazy cblist CBs can get stranded for the duration
> of the timer.
> 
> This is a good thing to do anyway (regardless of this series), since it
> makes the behavior consistent with behavior of other code paths where queueing
> something into the ->cblist makes the GP kthread in a non-sleeping state
> quickly.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Here is the updated version of this patch after review comments from
Frederic:

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v6] rcu: Fix late wakeup when flush of bypass cblist happens

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

[ Frederic Weisbec: changes to not do wake up GP thread unless needed ].

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484..4dc86274b3e8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -433,8 +433,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
-			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -447,7 +448,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		// The flush succeeded and we moved CBs into the ->cblist.
+		// However, the bypass timer might still be running. Wakeup the
+		// GP thread by calling a helper with was_all_done set so that
+		// wake up happens (needed if main CB list was empty before).
+		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
+
 		return true; // Callback already enqueued.
 	}
 
-- 
2.37.2.789.g6183377224-goog

