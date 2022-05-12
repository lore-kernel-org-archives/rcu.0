Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFD4C433FE
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbiELDFV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiELDFO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2923C1FE1F2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x9so3446261qts.6
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VguBeQ+12qdz5ORPPz8A3LziW7+dOXzz8U6/Bhny2s=;
        b=g3sd8zXr4eY3YPK7kiTFuglS9ynRQb3gfdlxBVFgd+S29k9TT5QtDXpPjGGe/iRsCz
         ik9dY9qNonxIBRQhFScSfkZmvPRlt8rhsl09x4lq10E0aAOkHdj4I1y4a3UlHHBG+zYN
         rcEXbO8LeByperlUP551BQE038Vg4u7MUf0Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VguBeQ+12qdz5ORPPz8A3LziW7+dOXzz8U6/Bhny2s=;
        b=JAtMN6MIT8wjk0fUo+hNN+8NycYmnTJRrqHF2uVFX3LcfLBZ3a6RatvLGNe5SmfNK9
         aRGnZTd8VyMIOuZgCedq5rfCectCEdkhQVjx3yzKOeV764B6sflDaryfwbkEIF+mtfnX
         Kc7S+T17hkS0VEhCMefIZUnx8oycsXnBvS+10TXIS3ZQJ/iIgA/dSkPF9POVfLwFQajL
         3k++0YQRqYt6NZtSUam1UcUWsRiwPGTl24/rfcH1/gPQ31W88MD647o2kMMbGeYg8URk
         Gf4AW/5grEd/wyJqK58Xj53AfI5g0MpDF0emEC/q+6ppdRu5OXEp9hbBwgvupjd5wTQr
         MMsw==
X-Gm-Message-State: AOAM53016sj2MuokR9bAE1iDf63IdYDtAIrnopMjLZB9rlm8ZX2xHh/Z
        GtoOhhaT3Is/koc87rsUmI4BSSHsFTDJsA==
X-Google-Smtp-Source: ABdhPJy3hdaEwQV6kb236TcQN6B2ZwyBAK4FV8lCkQvL4nZHeVDWGM7FQhBwpyoQmxmXzFO1h0ZTIA==
X-Received: by 2002:a05:622a:15cb:b0:2f3:f90f:1939 with SMTP id d11-20020a05622a15cb00b002f3f90f1939mr815053qty.374.1652324712078;
        Wed, 11 May 2022 20:05:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 13/14] rcu/kfree: Fix kfree_rcu_shrink_count() return value
Date:   Thu, 12 May 2022 03:04:41 +0000
Message-Id: <20220512030442.2530552-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

As per the comments in include/linux/shrinker.h, .count_objects callback
should return the number of freeable items, but if there are no objects
to free, SHRINK_EMPTY should be returned. The only time 0 is returned
should be when we are unable to determine the number of objects, or the
cache should be skipped for another reason.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3828ac3bf1c4..f191542cdf5e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3637,7 +3637,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
-	return count;
+	return count == 0 ? SHRINK_EMPTY : count;
 }
 
 static unsigned long
-- 
2.36.0.550.gb090851708-goog

