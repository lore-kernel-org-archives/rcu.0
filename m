Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F8C433EF
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhKXLGc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbhKXLGb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D9C061574;
        Wed, 24 Nov 2021 03:03:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k37so6199909lfv.3;
        Wed, 24 Nov 2021 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZW8+xeSwCMOYjSj3pDlaqgDK0lGktqF29FEzDv9VYE=;
        b=qEu+OSDX8gbrBCLebcUBiZtu8sSuYZGvr7A6oBjRmt7ItcSlnThuBkZNWJ9bLBZ8kv
         4M9eVAS4MJqKUs2bWgedaszQVOtckSJEpz7dVOmPuQIxEWBaXHQs+Xdnpm7QQ2RN/DV+
         epozdLPQ6lZGwmKiWHaBSEsUguwi1vHgucsJLqpDEta6m6IECMKV1/6qj1myrbt0a+/v
         WyLIxdTLprt/015yTccC4pfsTz2MFpFXftVOxK3FJ0t0Zro6B5KvvKWPE8Cpdwjqdk+d
         SY80IJy0chLwsnxi+tOxNLt/6UmvGsC5YSkYSPmcEPUFjLq53vjiuXA9XMZ/RgJqANd8
         SIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZW8+xeSwCMOYjSj3pDlaqgDK0lGktqF29FEzDv9VYE=;
        b=fV+xv5uD8Vf+ugnKZq5s/4MMHVJK/VE+upJLNkD3TRYnDz40v+ZCamxc4bqZdoCUpr
         WzJVQeF2u6z8hq2plTKT5426mQgir8m00dJzSlXI7Gkq42TOb6MQ2EkO05Glkbmfrz8B
         2a7EjtsDs2z+Y7s27xi49f/wQo59ndYYjShhsNE4mumoBzE8xPxvjtDlrTy+8l289MVP
         pmM6MNPsr/Z3/6AM1AC9r6M47kltx6ua0xAXtx4cbs2Lk/3g0wL5bAaopJuIM/T3D2wC
         caqH7XmfF4S+fgJk1Loi9a5OU3MRjcEdnDpuQhip17rW3l8aVNYs7Q0VtTf+1c5WYsAQ
         3tbw==
X-Gm-Message-State: AOAM5333OqDJsSX27YF/L6z/ToS9TnniDQd0+YIJqGyVxOcIv7kfwzCl
        Mnzu4aIf/MOnDTzsVabfj7/Z4yjfdK5NhPXL
X-Google-Smtp-Source: ABdhPJwA0OW7PSM1hwKB8IGt6yynewCwvg35TT9DjKm++Lcn/fPumA6ukE3QTvzN1XPmkwYsHrWpvw==
X-Received: by 2002:a05:6512:70a:: with SMTP id b10mr13306510lfs.32.1637751799162;
        Wed, 24 Nov 2021 03:03:19 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:18 -0800 (PST)
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
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: [PATCH 1/9] ext4: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:00 +0100
Message-Id: <20211124110308.2053-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

CC: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
---
 fs/ext4/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4e33b5eca694..111b0498a232 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1886,8 +1886,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 		return -1;
 	}
 	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
-	synchronize_rcu();
-	kfree(old_qname);
+	kvfree_rcu(old_qname);
 	return 1;
 }
 #endif
-- 
2.30.2

