Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B21C433EF
	for <rcu@archiver.kernel.org>; Wed, 22 Jun 2022 22:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359741AbiFVWvs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiFVWvq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F741303
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:51:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q4so15321643qvq.8
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+kSqBl3RB9I7OY9hm0XkeWhykcK3oDF7t29sGiTzsw=;
        b=UXqJkdf/KUdA/7F69IfFzfqaGez+SJKEsYw7nuoWGBu0X1hTbSLO5mv5SvEHwxyffi
         v6O/+XZ6kAy6ihIhq5dQgHhxeYv1dabpAGdmOWyyEl2imSX0RJXhmRwGEI5Yg9J0bB3R
         MPHCpMk4uVaFRmEAqQ1tWKl/a8e4oKq/zkQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+kSqBl3RB9I7OY9hm0XkeWhykcK3oDF7t29sGiTzsw=;
        b=nje2ki/z/V748mxmvLis2Vlh3cuFAIfmApmCLcnGK2xGFaGNocPkF0JLXxuKzPlfxh
         s20tGqYBiwJcg2rAS+0OpshQusJcZX39bM/Hb3+lggRnZTi3+Sb5Qq/rNL23gT4qchLs
         z87AUXG/wzl/J84gMNcVPTmc8JWGuYXJQO+F785pXi5k2x0eZE3+Pb6P7fJdR6oW1VJx
         LCLC1QhAUrX48gH6+CHA9+20brJkf6x2JnmOT840cg4qL6TYWqvFk7Q70d9tZ+03vM4O
         2vA10Rk9eFxddcL2iQwu6en0eNyOo2iB+JbnkW8rvY4m73q+Z7wtIIU0j1eTrRD2UQiX
         uzEQ==
X-Gm-Message-State: AJIora/dM3VVJ4MIVWWX8URpT7A74LvOoQ4u3ImYgwRqyVv9eaN38I1U
        3v8ncAuFrBToqUD1zewsVJ9UbPABmNHJEg==
X-Google-Smtp-Source: AGRyM1uuVGVPfaJ0Ie+qNySjbSbMPeGHjQQx1Ig5cgUKgMzyi+kfvrEg7TFmRbp9baN9SneC9y1kag==
X-Received: by 2002:ac8:594d:0:b0:305:1a14:de6c with SMTP id 13-20020ac8594d000000b003051a14de6cmr5135737qtz.677.1655938303882;
        Wed, 22 Jun 2022 15:51:43 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 3/8] fs: Move call_rcu() to call_rcu_lazy() in some paths
Date:   Wed, 22 Jun 2022 22:50:57 +0000
Message-Id: <20220622225102.2112026-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
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
2.37.0.rc0.104.g0611611a94-goog

