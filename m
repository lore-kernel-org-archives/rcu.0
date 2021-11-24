Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC70C433EF
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhKXLGs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbhKXLGh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC4C061714;
        Wed, 24 Nov 2021 03:03:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b1so6065086lfs.13;
        Wed, 24 Nov 2021 03:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMTiHU3cgrSgPMLy2yiHVTmkv2bt6oam8wL/EGQ/+vA=;
        b=hTyCoL87Rm/8sh14su+5AXLivbEsww9xE5MvU8DVFRxkDnh94xNXdO1eJ5idHFRJTL
         fym+drUcsiy9RUVtEB36NGVkh20JrF2a76SxSRNbMloXpAP6YL8Fagp14m7AASJvQbTq
         URJicLS3vrgmHM7AWosWnRG77DDlCEe0sURY5Ci/jXT9uz7vV2ukkXnFhMqE/BGuCmPl
         wycrwvhff4L59vrG2X35WKaZyLnd/1+CE52wlIn8jXE1Qw2bXIZ54WX3axpST7kRMv9e
         iybESIEsAQq1clti8lKiHuTSCge4yEIT4BFFrycb2zVt3H3Ha+xwovei7sZZwoisEz+5
         5irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMTiHU3cgrSgPMLy2yiHVTmkv2bt6oam8wL/EGQ/+vA=;
        b=lXzyT+No5lWSnH+f3EROEsh4pVLTtsy6NFOkZZZl/Uhj0bXc8Ft4b/RaYAFrHofqcj
         Kl6f2VqvgBgrW4lCb1YtVgBeboJfMu9Xe3XWJ5uLabi1/MHa9JEJDm2Itn65B2J7v30o
         4XB4sSZnuuGSsL2DvKMixexuI7TSb/H3lBjm7jd3Z6kUoXRqGMwrj/hJMz4p0F5HhB4p
         MGGJHlJFUT+mYJk4AKoRIqQQtZzjdIYWhXPCh+mqenSH0H3xnLWpqdNxdssXD+OXGRT+
         9HeCPK1F8sAL2Yw63i8e0TBNaVvibHpfkL8iYVu85sPUk6E4VAYlsOk+ZJDfvCz42JGx
         MITQ==
X-Gm-Message-State: AOAM530qU8o+PMJHKdk8OkOe3JAQd+32BFlZ/DRch6wD8SH2gWJnLJgr
        +3UUHXo928wH1nnaLbR9ZRJAuVOrKMLG+OEj
X-Google-Smtp-Source: ABdhPJy3TN6Mrsz3q0XJqFqU793XQG0j9RRQGpd0Rw2cXJFB6efenlxv/ngospXjR5noxs3pe/K8Ww==
X-Received: by 2002:ac2:5e79:: with SMTP id a25mr13711368lfr.355.1637751805830;
        Wed, 24 Nov 2021 03:03:25 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:25 -0800 (PST)
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
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 7/9] net/core: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:06 +0100
Message-Id: <20211124110308.2053-8-urezki@gmail.com>
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

CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 net/core/sysctl_net_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5f88526ad61c..8b4ab9a6e2d7 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -141,8 +141,7 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 				     lockdep_is_held(&flow_limit_update_mutex));
 			if (cur && !cpumask_test_cpu(i, mask)) {
 				RCU_INIT_POINTER(sd->flow_limit, NULL);
-				synchronize_rcu();
-				kfree(cur);
+				kvfree_rcu(cur);
 			} else if (!cur && cpumask_test_cpu(i, mask)) {
 				cur = kzalloc_node(len, GFP_KERNEL,
 						   cpu_to_node(i));
-- 
2.30.2

