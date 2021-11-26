Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC63C433EF
	for <rcu@archiver.kernel.org>; Fri, 26 Nov 2021 19:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhKZTh5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Nov 2021 14:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhKZTfz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Nov 2021 14:35:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC7C0613F7;
        Fri, 26 Nov 2021 11:00:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f18so26431197lfv.6;
        Fri, 26 Nov 2021 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbVvjT6BTM4cuLV45+AKdDv4R9gtdX2cGu1ybizgxi4=;
        b=pndDKkiR05Ugzl9EOl/8X9Hho2Lyb89Hi90HXJYoRbFDjjtoAqfZjNPtGxxqGDiAri
         SDH3rowQo9KvLBCGGax2Jz5LkkcV4W/PcSsPz0ge97hDHpt+aZGM3DVAkSczjbCJ17hk
         QNcdaXEV1/R9nkjxyZs7H3M1vOyX/xl4U17X3MfkOOwaHtqxsaSZRIctkMeB3BhdMt3h
         fcb+DdjVkBWgVwwpcSiCZvEcNJ4M13G6KDhZWOY3Y3XcM1LLUhm36X9RvynKoKpI8C6J
         QK9mAXzPpn6cbcKNX947yyaaBoPWKgncA3VP549ufm+f1bZ+wGaM5e7FTxTJJTJesfvP
         3hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbVvjT6BTM4cuLV45+AKdDv4R9gtdX2cGu1ybizgxi4=;
        b=3TlWCXghdpz48i/qFqLgaDs4POneAZ8/Bpx2V5+qp++1/tE9Rzp02qWRvEKUOOjMMH
         p/hvwKUxUxccdqA2mGRpCnakrBjUyE0gyxNHWntnL9IA/ziRDcu58eca7KgnApZPXmG8
         2pWW5QwOnoFvC6a7JrMgZvLFeif6CPP70i97gVsYDFgzmzRpWdfurP3tDV8F4VhhlO8+
         7a+td0QqCicFt6q2uLwy0+441h00dQnwToVJqgL3KIsLnmY157rIkmPH70dY2aFj7fnK
         ItyORhMM51A7OVfgbeZ69oGDsSvaH9WBB5pLgatebEvRuxa3SIWFtzPLnVD7ZKDRpDlI
         ktaA==
X-Gm-Message-State: AOAM5334IZF9lLYCAgylLBvSsEpy5oqRnMyeO5XymyVazyJptOhGBmyw
        k9XLrrqh9leOV8EKmhcpb16ae95ISoXYWEOO1/TYZw==
X-Google-Smtp-Source: ABdhPJxDbr9Hg9v7B/VEhJY9ZM1EL2mbocdaC4ZiMrYAvjJHyITuYn/QFO5KG0Pm5g39XxCEGUNuZQ==
X-Received: by 2002:a05:6512:3d0b:: with SMTP id d11mr32378690lfv.542.1637953254292;
        Fri, 26 Nov 2021 11:00:54 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i17sm562818lfe.281.2021.11.26.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 11:00:53 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH] rcu: Fix description of kvfree_rcu()
Date:   Fri, 26 Nov 2021 20:00:45 +0100
Message-Id: <20211126190045.1992-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The passed "ptr" parameter might be wrongly interpreted
therefore rephrase it to prevent people from being confused.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 88b42eb46406..9d7df8d36af0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -924,7 +924,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  *
  *     kvfree_rcu(ptr);
  *
- * where @ptr is a pointer to kvfree().
+ * where @ptr is the pointer to be freed by kvfree().
  *
  * Please note, head-less way of freeing is permitted to
  * use from a context that has to follow might_sleep()
-- 
2.30.2

