Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03929C001DC
	for <rcu@archiver.kernel.org>; Sat, 29 Jul 2023 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjG2O2F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jul 2023 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjG2O2C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jul 2023 10:28:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A1E7A
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:28:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-348f5193c12so9783725ab.2
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640879; x=1691245679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=w+eXq0b+xVCeRwLimsIFDmDvgRjcNTvCTtckAuYL+NxLFVlICU0f2/cWdwaY8mOG/Z
         q9zwNJwGGpEOV3xOiYldmz0Ht7ao1zWta1BbZEEjXcNOnH9EHP0dAD99T3uBoMbvXql5
         a9TVjh54Y30EGW5rDrtC/vX3tjxDAXxWkwGk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640879; x=1691245679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=SUTM2Dlt52Tpc+vSXu7/1GCgMp9Laj1R+A5k1Cazr4EmGfs3fWaadu3IR0Uy3dbu9p
         54f7NnYrxX7yyJo8r+TVYivLsjcl4xBHCbUIKCqmJI8Swb2xYwOw2Q2kM7g4nh0ZCtIp
         GFhLjNdJxJb/jGetFuOr44oC1HwAgRi2Df5uZSQTHdFpDXyN2VR1yGly4Ww91RaJb4kS
         rwWjfUna545D7lrG7g2h2nb5SdeoJjZKEDZ5n4/hS28LnNperjyUCLuJ6Nc/SZlaicIx
         Da1JkOPIYcuRvLKVpwUVWfdwOxJxB465kwGALzKfIZw52tx1JOq0nBN6CzUcw8slHzDZ
         iBfg==
X-Gm-Message-State: ABy/qLY4u/TIuAuyoqiX0O/+nOAWp7H2cDjOkiLgZqX6UKv1aOxrvRH1
        TYkaNXY5oJoVOf40bKdur++8dA==
X-Google-Smtp-Source: APBJJlFNIZPWUROiB89przJra0uGXRoZjzPe5M07xGkhX3SWIVZXoL08l9IiN4nUOnSpcobgTvOV7A==
X-Received: by 2002:a5e:d717:0:b0:790:9460:6304 with SMTP id v23-20020a5ed717000000b0079094606304mr657721iom.5.1690640879700;
        Sat, 29 Jul 2023 07:27:59 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API used"
Date:   Sat, 29 Jul 2023 14:27:35 +0000
Message-ID: <20230729142738.222208-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The check for single-argument kfree_rcu() is no longer needed as all
users have been converted.

This reverts commit 1eacac3255495be7502d406e2ba5444fb5c3607c.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 scripts/checkpatch.pl | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9841148cde2..528f619520eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6422,15 +6422,6 @@ sub process {
 			}
 		}
 
-# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
-		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
-			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
-				ERROR("DEPRECATED_API",
-				      "Single-argument k[v]free_rcu() API is deprecated, please pass rcu_head object or call k[v]free_rcu_mightsleep()." . $herecurr);
-			}
-		}
-
-
 # check for unnecessary "Out of Memory" messages
 		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
 		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
-- 
2.41.0.487.g6d72f3e995-goog

