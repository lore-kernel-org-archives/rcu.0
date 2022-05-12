Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7DCC433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiELDFL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiELDFI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B21FD866
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x22so3459861qto.2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlPq9iL7yZbXCRdaYgr9qcrcREB/mxZJb+fO+2O0bUg=;
        b=MzvsJjzbupJa9p2oAyYninBW2dHy++R8QT4mGrPJMnEFtCqV77ok/4eZfMG5f6FPla
         7Xj38x48Z9Q820s9MedRT3iaUMUt3JPdwRCV5HHQxijqRRppIpG2EUKinOIJejXx7ir9
         ScrazMyDrJYcAMoS9Pm+Rm0ML3hgndZSX+O7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlPq9iL7yZbXCRdaYgr9qcrcREB/mxZJb+fO+2O0bUg=;
        b=Ba7P0w6ecE5YECmzfSh78JqG2NtAQYvR0kw+MuPIzfcsDaXEHDheqsp56pp7i7cQ2V
         9GflCm8x18ApW8SDK7Q8gomUtSO+u+C8MIIjzSBhsGqijgP1UkxX8MWCXtfnTv2gTnmQ
         HwmRvKyMJKvLJr6z6OwvPfULCGKv/RmrwXMGNuLcdVA7xv60434NvFhUL26n9Bf5zmWj
         J4M938If1SlxjgKHIhge16j9Kg6YepiBlv4X7v388Wal2DksoXf4qfSGwx3ti+Wyym/C
         c4ekC84ZizwPGSsc7GntYFlFxVL4Ke3kUxU4BHMrmAOWG526OBqN13TlgekwF5jQ85Of
         4GNg==
X-Gm-Message-State: AOAM533Clz/jBDSf6cTw6Ob7UnrO3W9UofU/8MmaKhCyazmwGl+P/KzA
        7DwHwsdKylv/XSXp4aXRAcWAqDgM1RPMpA==
X-Google-Smtp-Source: ABdhPJygGO+SWbl/tzMkaYMcWnVCLIIUzqbRTcmMnO+jNhUP/t27rObsTov9kHAY4rGEfytFp/5t0g==
X-Received: by 2002:ac8:5bd0:0:b0:2f3:bb55:4612 with SMTP id b16-20020ac85bd0000000b002f3bb554612mr26997113qtb.391.1652324706044;
        Wed, 11 May 2022 20:05:06 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 07/14] security: Move call_rcu() to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:35 +0000
Message-Id: <20220512030442.2530552-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
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
index 22261d79f333..42c165631e8f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1039,7 +1039,7 @@ void security_inode_free(struct inode *inode)
 	 * The inode will be freed after the RCU grace period too.
 	 */
 	if (inode->i_security)
-		call_rcu((struct rcu_head *)inode->i_security,
+		call_rcu_lazy((struct rcu_head *)inode->i_security,
 				inode_free_by_rcu);
 }
 
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index abcd9740d10f..8c639c6df955 100644
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
2.36.0.550.gb090851708-goog

