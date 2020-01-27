Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B112C2D0DB
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462A920CC7
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 17:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq9XQhmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0R6e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:58:34 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38732 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0R6d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jan 2020 12:58:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id m4so3411851pjv.3;
        Mon, 27 Jan 2020 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qg7kiRaR41z6aa68lIG2PQR4oukAllwNZH6einOS8mI=;
        b=Nq9XQhmUJms+NO7UG2IViWd5kF7jDA+JS49Yr/3QjX8BWU4h2w4ZW2jF+Yc9amkOxX
         udNY1Q3IIgy23BA6cG1up1SZcCXryo5xHMROf7o/W3534hsBYQLrGVCrh2Q4JYDsXIut
         MbPWA0RVUFL7K7h3yu198EGM4yE8tPX02HLL9tSQOsE4hBSNoqr3xvzHdZhgz7tbWeuE
         s2cP+ue78lRB4FHk9rDAb+DqVg0fak80fK0KSeA11364Gteb1np3YXXNwQagB0YRho8H
         3ATqOu3VR0W7B6z4h1V4JcXuhpKic1ra/ALBC56LZTTAOaRmE8GfiV1+120Ww8cG6cui
         4RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qg7kiRaR41z6aa68lIG2PQR4oukAllwNZH6einOS8mI=;
        b=g8K90iUKUBAhGNddk0CtHpV6hIqHh+JuMR4rAAgH8DQHi+9I4B4B4TfACM9Z0t1WPf
         HMz0JPpL9tJtsbH+2glVrO92iL16cd5oTwOB4E3DuDAc7jO9ZhVuoPos+Th/1ZjjEpEL
         fUBzEJkcRLRMNQT+d/oPpIe7xyHSxYpsxtGLeEd77IqthSCQ1o/g83XKCGf+tCWjg1Js
         FnNTm76qFWf0uZq++koSCYgRBRg1hYmST4DtG7+RpyC9vcd3sIumWxdKaXUuUDeJqFlT
         tf3LK/KCDGKj6PYmAmIj4CWW/VRsTKXAcAhwEwXdeQ6hYe2v3Ye0HMXcb+tQfgcbu5cU
         AQTA==
X-Gm-Message-State: APjAAAX7UnhMswviByR7R1Dw1QPrdxoUrmeuVEnarRu/FWEwVZK7N3+6
        VC6KWIPaGYMbG0ue1GZ5tg==
X-Google-Smtp-Source: APXvYqwRk+gJc6ZgAm0UuUsbki66uSc9J7Ha+2lH2Q77Sj0VanqIaf3H/pXZ1Rr49zf2F2rs3M0hMg==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr253929pjt.128.1580147913366;
        Mon, 27 Jan 2020 09:58:33 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1ee2:faa0:c576:b7c8:dab8:85b])
        by smtp.gmail.com with ESMTPSA id q25sm16482430pfg.41.2020.01.27.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 09:58:32 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     oleg@redhat.com, christian.brauner@ubuntu.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] fork.c: Use RCU_INIT_POINTER() instead of rcu_access_pointer()
Date:   Mon, 27 Jan 2020 23:28:21 +0530
Message-Id: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Use RCU_INIT_POINTER() instead of rcu_access_pointer() in
copy_sighand().

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..42b71d4a50cb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1508,7 +1508,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 		return 0;
 	}
 	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
-	rcu_assign_pointer(tsk->sighand, sig);
+	RCU_INIT_POINTER(tsk->sighand, sig);
 	if (!sig)
 		return -ENOMEM;
 
-- 
2.17.1

