Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138BEC6FA82
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiIAWSp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiIAWST (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF958091
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a22so212563qtw.10
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Uetgjnmco7XMjJ0pPvFMMYQeK2oqyNBCbg9zI/9WK6U=;
        b=Qlh767M6LCeX0fcTUExKI0vDqoTRBfz2hg5EurE23Vs4l8vVL/qjU47CREwknrDU0m
         rLGyL/hdoXaQ3k8Vo5xqmJuRolH5BcV8urpgipRpHre9ncZoZRuwvvGiH/z84Xkf9PKx
         w32OhzRkeqYAp5tKbH/fi2wbMWp9nPLv/U/O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Uetgjnmco7XMjJ0pPvFMMYQeK2oqyNBCbg9zI/9WK6U=;
        b=r36CPxqCkqkHs21H0VSXOEjeiBL70qX8lHgwo/KiUqKCfd/vM62/tt8Tr1BwHrVC97
         x/jrpiX+CxJIyzvrDEvhpEGwIcgptMjQHjcoUpxcUZhpgWfiQEKlt4Q2iJ+eIFX3rwBE
         WQb6LRxSzV3bd64Kdvw/4Iiq6SjNOElFTkCbXvyHANBocW6SXgQmGo6cEdbwdRBxo0g/
         RGacD4zVZZTeAohVqF6JE2UDepRNPjJVNbKJYM/+VchQRRix/5SSzf2Yx8jwBfncRfLM
         phiV7+iWNjNp4EycboTLfKyOZDydwDM3z0OGAoqM7qH2AnyE3a6S9YH2ZU3zRXdMA6GE
         cE1A==
X-Gm-Message-State: ACgBeo3nchGnBMabLBKHqNz2X9HUsy38qiO7fVUIzp+DafLh9zIOuJKX
        BbUCahyeN0ig5QQD/dT1n28aO0Z6itiEXg==
X-Google-Smtp-Source: AA6agR7NX0LPVmvfR8AYnY7HzxGSlvcrW6s4HEA32zP4sXGb6qTrqmmBag2GXgdyln10oQkqNMt8zw==
X-Received: by 2002:ac8:5a96:0:b0:344:b3be:6931 with SMTP id c22-20020ac85a96000000b00344b3be6931mr25930091qtc.509.1662070687197;
        Thu, 01 Sep 2022 15:18:07 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 14/18] net/core: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:16 +0000
Message-Id: <20220901221720.1105021-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index bc9c9be4e080..babf49e413e1 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt)
-			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+			call_rcu_lazy(&dst->rcu_head, dst_destroy_rcu);
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
2.37.2.789.g6183377224-goog

