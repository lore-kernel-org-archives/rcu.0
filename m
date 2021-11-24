Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBCC433EF
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbhKXLGi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbhKXLGg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:36 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5CCC061746;
        Wed, 24 Nov 2021 03:03:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 13so4536682ljj.11;
        Wed, 24 Nov 2021 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mkcpIpQNADy47v7UAKca+3VWMypeY9VF9pVuI+LVzY=;
        b=ey2K3nRcbbZeV/uan6W4S3mEARiTMSaMJ01/DdUVxZIwF57H+GdJU0YpCCiGMuFf50
         9gJhRg6PYTTjyZKniU1PhCR9qdxLT8zipAd2xF3EcIYTZLlYFhxAnmxJ2ns4QgeOBua6
         pxvptbmqRQgt3NkXPvOqQ+5cl6XWnjEeJa3+nZtm0GCu0QrPHwegHqxF1gn3omBFfwaO
         NJgajACvCV7kwIkmDPpmust/l8YYKzcJYI/4OMD0XrYmSXBKRqLaGiY1GD9EyBHO0Dc7
         96OqwowgOXuYjbFYRlCX/84+oCukq+/elVcXfaxBCRp+zSoEO88C4vSH+dlLKiMQwnF2
         Yxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mkcpIpQNADy47v7UAKca+3VWMypeY9VF9pVuI+LVzY=;
        b=zBPIomFNTHAdKSnbQGL6IPp62PiJsJL6137313tefczt1QjtE7UR0/fG6AIjDVSvDk
         U+Pg9TbWAtBOqlmCL3zGFloTZo5HWGYwAT39T9AsBWveTKIAplEovsXnJ9BYmiw26XrD
         ZZzgEcs3HPqBxL81nNtKs+EFUEkSE9ldp7oHCSjouOT7D8CXkwvLiEIvRh1SHMyp8ljn
         qZG+tSa5S8dl2dqkfwc6vsjtz0gL9AImv3xxqj1ODSKAugj9Tp7I5xnr0vTBZ5CutoO8
         fSvuGpieRNbtNHdm2zo9eBeecR+kTv93BYnCOZwj2Nd4zu7/YmoY+izGCtbhicUWnpaP
         jQmw==
X-Gm-Message-State: AOAM530X5vQQQBX4agTVIoX3HYVEaJFd4GcKUbbSvhbMHcJivpgviIDb
        +6kV9jZCuCIOOhz7p8TsAwuJP6uZSI67d1MG
X-Google-Smtp-Source: ABdhPJzrxbCFTXZT1whgakmiIpUUZhz4fomG2WKSaLOLwn/11GPAx1Ls9V3b43pmVd+C2zURw7NO7g==
X-Received: by 2002:a2e:a706:: with SMTP id s6mr14489438lje.370.1637751804801;
        Wed, 24 Nov 2021 03:03:24 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:24 -0800 (PST)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Jon Maloy <jmaloy@redhat.com>
Subject: [PATCH 6/9] net/tipc: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:05 +0100
Message-Id: <20211124110308.2053-7-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

CC: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 net/tipc/crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index b4d9419a015b..c2d16c40778d 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2391,8 +2391,7 @@ static void tipc_crypto_work_rx(struct work_struct *work)
 			resched = true;
 			break;
 		default:
-			synchronize_rcu();
-			kfree(rx->skey);
+			kvfree_rcu(rx->skey);
 			rx->skey = NULL;
 			break;
 		}
-- 
2.30.2

