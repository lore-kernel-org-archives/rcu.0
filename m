Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC3C001DF
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 23:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGYX3t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjGYX3o (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9A31FCF
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-78360b822abso260457239f.2
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327773; x=1690932573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=T1/qgW80ZW0ruvAexTl3SwPC/VD8efNMinccPq8SOmll1PeYaL7nJcC+rT2y/ICCI/
         Zm7HzPisHr2CWscQ8DNq4ATfmZQ4copg8Byy3hFGTtKvq0+ing3UNCdbIzc4z9yskHeM
         i6XYgDFBYacc8aSIAdToK+pj+H/fS21Ias0jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327773; x=1690932573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=H880LOZW0ZAZzo+rPare5xPE0PU77ByI582ICBiQXVIIpF8dwAAKe1ab9mWBCwY96b
         BDDpjgcPcCHuQKyEalW4sqBmZzut4A7wl37LBTZO0wcCS6z//87VVtndgFZY7d/KMqvc
         VCOYXGXS5+MnP1frDWrljpRlsrRXVOgiZp91CghKMWUd722qNgRru2ClWDtDeNvSQtd/
         PLOhwcmM6b5EIs3nA1RyfAio4lybWxuOTLC5varJmzJhv4UnERstvstxeqUwl2vvJUqB
         oUd0jzGtDZ7Ns6F+7iST4q20WTd/myntQQWzVc8Y0r7HwGmSVM/nNJ57j/jYvPiqaCW7
         J2eA==
X-Gm-Message-State: ABy/qLaSEpatjsIvk59alf8duks8OXtpPWb9hKxkZuefySAi7aTt6tCQ
        SMP8SCtXNMFWdTQdv30AbMumN6Mzl9J6OQWbHE4=
X-Google-Smtp-Source: APBJJlFOYFaGXIDd2DLLQ0HZ+PPI+wBB+NlGxhegixuv5PbL5oqsOrir68iUsUdxnVKRboGwsYrdZA==
X-Received: by 2002:a5e:8a4c:0:b0:787:34d:ee9e with SMTP id o12-20020a5e8a4c000000b00787034dee9emr356394iom.7.1690327773744;
        Tue, 25 Jul 2023 16:29:33 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API used"
Date:   Tue, 25 Jul 2023 23:29:10 +0000
Message-ID: <20230725232913.2981357-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725232913.2981357-1-joel@joelfernandes.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
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

