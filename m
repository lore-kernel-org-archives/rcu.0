Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4267DC32792
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351756AbiHSUtW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351547AbiHSUtR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEBCB7EC5
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j1so4188686qvv.8
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=426wMCJsiGTV85lu42+JZPwXusrFJ9i/3rufNlqDqLk=;
        b=Zf0eIAQmZsTmWin33rp1mlGvqcz+m2sPSmH3oNADGIUsHoKnVEiH9xF+s1jb97xCiO
         J0knpuEdwimm+Im9nIVGP8G1P07+5I5eQ4bVNmf31TVrIf/xuxXXdRoMQb4VbNXObzhg
         F0hJq6xJ6mrwwj1riPdTvVJnS5dP5eb/go24s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=426wMCJsiGTV85lu42+JZPwXusrFJ9i/3rufNlqDqLk=;
        b=gr9WKu7xjydAsNxvEt7UsJ5uL0QaD6JSs5Yos27PeVFxStg7IshIAElZfo8/fv38PB
         RFQIa0UMrvOZWl0WLDIae+0CiJzT7uEp6lQ1YKidAldOHVBuScw2X7vFqKm6L2sqigTp
         sco+6ULq2h94b61pyoEp7QG8JBaBYZwakQnVZEHFW+CtzPKxHQYWV2a9ixSUEPYnh1jY
         uN1OrPaIxJ1g6dqBz9DrbGvn84vkazRpxXj5T6n17MwCCiFHQZrxncMclH2eYzUWVgeS
         joAhV0p60Ocg2/0RVuZhKgpjtFnhZ/X7cDuRg2pfqmU+rMAgw7dOdWQ4YV0JX5SWXTRy
         xhIg==
X-Gm-Message-State: ACgBeo12JOOteEOWW9LlIdctHtCQkdBwQUts6OImT4oYPxU4UIiI8NpR
        VAgVqC86pBA18LCmBBPkBX04rw==
X-Google-Smtp-Source: AA6agR7qo/QCjvB0s7nlcW0al3t3YGKIAXKBT2yMiuCoFuRaib2mPR2/P0JockuC08afh9Yxq6314A==
X-Received: by 2002:a0c:8ecc:0:b0:473:2fa4:df7c with SMTP id y12-20020a0c8ecc000000b004732fa4df7cmr7842135qvb.55.1660942149873;
        Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 08/14] security: Move call_rcu() to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:51 +0000
Message-Id: <20220819204857.3066329-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 security/security.c    | 2 +-
 security/selinux/avc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index ea7163c20751..d76f4951b2bd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1053,7 +1053,7 @@ void security_inode_free(struct inode *inode)
 	 * The inode will be freed after the RCU grace period too.
 	 */
 	if (inode->i_security)
-		call_rcu((struct rcu_head *)inode->i_security,
+		call_rcu_lazy((struct rcu_head *)inode->i_security,
 				inode_free_by_rcu);
 }
 
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..381f046d820f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -442,7 +442,7 @@ static void avc_node_free(struct rcu_head *rhead)
 static void avc_node_delete(struct selinux_avc *avc, struct avc_node *node)
 {
 	hlist_del_rcu(&node->list);
-	call_rcu(&node->rhead, avc_node_free);
+	call_rcu_lazy(&node->rhead, avc_node_free);
 	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
@@ -458,7 +458,7 @@ static void avc_node_replace(struct selinux_avc *avc,
 			     struct avc_node *new, struct avc_node *old)
 {
 	hlist_replace_rcu(&old->list, &new->list);
-	call_rcu(&old->rhead, avc_node_free);
+	call_rcu_lazy(&old->rhead, avc_node_free);
 	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
-- 
2.37.2.609.g9ff673ca1a-goog

