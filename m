Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BF8CCA479
	for <rcu@archiver.kernel.org>; Wed, 13 Jul 2022 21:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiGMVdH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGMVdE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Jul 2022 17:33:04 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF5E25C58
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:33:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x11so1749qtv.9
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3O1R4PngG29TlFcQzhwFaFF5IR57wiy1m7Uci4zEx44=;
        b=emYhn4d3wA2NjN8cIwTR1D8sL8c9zIAv0fzpgJ1kGjUzxa5i8/LPG26hwH6ccAnNI1
         BjviqF9HWALy7xIEkVgvG9IbrZLPFD1rOh/dtO9ESgIlk3ic4f4wvkjKsZyOpQhvvuKa
         kNCWjy9zMeybygrAN+hrmxnmGgsDAsSQhSD5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3O1R4PngG29TlFcQzhwFaFF5IR57wiy1m7Uci4zEx44=;
        b=c1LK3NlEs8f3J5K0xvJ0JpRUpLlJGMKhg4lMJS1cZaRS1YdtU7ukCwZgrqQkXzMoWK
         Yr8lK7B486Yj4ksOs+HWib6AmHUrTccekOavykVr6YD8iltSwU9YRK27/0ompeOHJ/k8
         KIhmxNMlsE5FB2thnyUNNmZGCgc06SlCpijmnlkEvihwCzma8fy/JhT76WFZiWufD+na
         6BTBelHu3+Y6YTFr3VYh1ybwm3LfMCWr9/Ocpzcxz7QjhEWty+BM1cm+d6FG49seqghr
         mssu2pWrixdoCQZsq+xw22eV+gPKQWenvUCj4ZKS6tHHGoYmQIUtjaiYDzjXyY69MB+3
         Q83w==
X-Gm-Message-State: AJIora+op4x1PoDBPOyMDDsDh+yhqrAqQl+YB/cOsXpYd2uAGVR4ghM4
        BZSO3XofpvMorLP2+lruFIOMdlrvCcK1Fw==
X-Google-Smtp-Source: AGRyM1swwdwLojY4Cgz/79d9bZYOx1/xt7ZQA1pXnddOZtU4uSyE4gBGH51kfYVoC5sCFCA0qlLUWw==
X-Received: by 2002:a05:622a:448:b0:31d:3e0d:4527 with SMTP id o8-20020a05622a044800b0031d3e0d4527mr5101802qtx.354.1657747981771;
        Wed, 13 Jul 2022 14:33:01 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006b5988b2ca8sm6791163qkn.40.2022.07.13.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:33:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4/5] fs: Move call_rcu() to call_rcu_lazy() in some paths
Date:   Wed, 13 Jul 2022 21:32:36 +0000
Message-Id: <20220713213237.1596225-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220713213237.1596225-1-joel@joelfernandes.org>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

When testing, we found that these paths were invoked often when the
system is not doing anything (screen is ON but otherwise idle).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/dcache.c     | 4 ++--
 fs/eventpoll.c  | 2 +-
 fs/file_table.c | 2 +-
 fs/inode.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..7f51bac390c8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -366,7 +366,7 @@ static void dentry_free(struct dentry *dentry)
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		if (likely(atomic_dec_and_test(&p->u.count))) {
-			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
+			call_rcu_lazy(&dentry->d_u.d_rcu, __d_free_external);
 			return;
 		}
 	}
@@ -374,7 +374,7 @@ static void dentry_free(struct dentry *dentry)
 	if (dentry->d_flags & DCACHE_NORCU)
 		__d_free(&dentry->d_u.d_rcu);
 	else
-		call_rcu(&dentry->d_u.d_rcu, __d_free);
+		call_rcu_lazy(&dentry->d_u.d_rcu, __d_free);
 }
 
 /*
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 971f98af48ff..57b3f781760c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -729,7 +729,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
 	 * use of the rbn field.
 	 */
-	call_rcu(&epi->rcu, epi_rcu_free);
+	call_rcu_lazy(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 5424e3a8df5f..417f57e9cb30 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -56,7 +56,7 @@ static inline void file_free(struct file *f)
 	security_file_free(f);
 	if (!(f->f_mode & FMODE_NOACCOUNT))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+	call_rcu_lazy(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
 /*
diff --git a/fs/inode.c b/fs/inode.c
index bd4da9c5207e..38fe040ddbd6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -312,7 +312,7 @@ static void destroy_inode(struct inode *inode)
 			return;
 	}
 	inode->free_inode = ops->free_inode;
-	call_rcu(&inode->i_rcu, i_callback);
+	call_rcu_lazy(&inode->i_rcu, i_callback);
 }
 
 /**
-- 
2.37.0.144.g8ac04bfd2-goog

