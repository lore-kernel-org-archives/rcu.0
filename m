Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F3C83008
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0ED8206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9Fr9GlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD1U7n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbgD1U7n (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40DC03C1AC;
        Tue, 28 Apr 2020 13:59:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so257333ljl.2;
        Tue, 28 Apr 2020 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WD1ujdDPaZr2tel/SdXaMCcHYNwfEhTtkcv7u+ya4TM=;
        b=p9Fr9GlCZWdBfVeNmGFGRectLCP0tawZJ6HOk4/26gkt2xbuGisjL5HWK8oxenMLc3
         WK7CFb3ruKHCtZ7DW6Lp8Fpzt4GHk+CGxiYQtgWPSlUcZZhyrkXg+x7Q/f57QULeG4g7
         KBX/5c90KxyqqsIIlo8SJO7E7uG+2zSYj8AOCV2Ylk8oubDLEsK3ADImk2flhGOFkXI+
         87KwKJ/zH2FkeTIOkSsL2VQzig4qfyW01BDbny+JHyYdb8TNIJn+W5fs5fV4eB76ibiO
         CcBQtvZ48ahRBPCdPeE5xo7HRSuwQn5iX+QgHsxVfkr1T4EZH49PkqEz1HmXrNUWClic
         bbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD1ujdDPaZr2tel/SdXaMCcHYNwfEhTtkcv7u+ya4TM=;
        b=U0YdinzbDKzElZ38VcoPbNb194Duh3Cm1Xr5sfDhfl5xbJPmkiZg7FfrN41vJbHW4c
         Cd2WPK08+yWfn2QLerMhMuqLMPI9ZRqa1WWRUqyLIR3bFZTOeCaxpdSg0j7+q6mEG7+W
         Ni+u8xCCRMA18etwUGfipGzRXzYgk6795SSLJkEbITwx2UCaBR+bFRpY5KM+2Cz2PaWf
         pqieh4Wolbmg7WIY1rEoWCbmnOIBe11wMaWLnipUrc+AIkqEpv31qIPFoFPtBTTDume0
         eAB0o9aiRMd5UCLpxQ4MSUY6eAffmKMrGB1JBbSm+Z08/ijmAjGZQkS6SihkiR/LaJ8c
         Oglg==
X-Gm-Message-State: AGi0PuazzyZyUG1xh5UUAS7P3xLdAUmmnsVTOUwChm7/GADJ0sALJUgQ
        nJg/eLx4g1p3+12Oi4/utN3/B1DpMPejgw==
X-Google-Smtp-Source: APiQypJNL/we3uS/PpZeWdXqJOcuZv4g219qgtqBw9a68MWbrzBMMmSnncu/axBnMngVJ8BcXOksZA==
X-Received: by 2002:a2e:b057:: with SMTP id d23mr19244054ljl.157.1588107580807;
        Tue, 28 Apr 2020 13:59:40 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:40 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 10/24] rcu/tree: add rcutree.rcu_min_cached_objs description
Date:   Tue, 28 Apr 2020 22:58:49 +0200
Message-Id: <20200428205903.61704-11-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Document the rcutree.rcu_min_cached_objs sysfs kernel parameter.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 828ff975fbc6..b2b7022374af 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3977,6 +3977,14 @@
 			latencies, which will choose a value aligned
 			with the appropriate hardware boundaries.
 
+	rcutree.rcu_min_cached_objs= [KNL]
+			Minimum number of objects which are cached and
+			maintained per one CPU. Object size is equal
+			to PAGE_SIZE. The cache allows to reduce the
+			pressure to page allocator, also it makes the
+			whole algorithm to behave better in low memory
+			condition.
+
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
-- 
2.20.1

