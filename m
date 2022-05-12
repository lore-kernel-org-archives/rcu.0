Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F112C433FE
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbiELDFH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiELDFF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:05 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2211FE3CE
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:05 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f3so3486845qvi.2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=invpnJO/pL9cqkXCSVg2CTU14ipkwGYESRvGU1ShOSw=;
        b=XPyG6kT2eKR/Mt9EfUyGMibPfy5f/CGskcH0N1nkpFc9yt9AIbPp7S1uqqhfsZ+FQd
         Ye2WUQG8v8JOxvOK7mmkTqQcDOi1Op0vRhplB7mWWhyYtDn6xJ8JDqki3XcxD67Wzssc
         8JJsq7ULmKW13yx0wXaxNcP1brDecWNab7TbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=invpnJO/pL9cqkXCSVg2CTU14ipkwGYESRvGU1ShOSw=;
        b=GKJWFjiajm2X2qg/kqejrg4j7ywn+xw58G/m5vjcAb9HogGk6EqsYDRQihXAoMoMuL
         uN9PXoaRKBMgDyiclz/rS3uPksJiCmXyiCp8tpvnOwcn3TkScAdZikJ4EGgwbHUDQYAQ
         uKl7U87epQTx0rzIFPYitkGC9Gh3Hve3LlejkjyKEhqQhght2TzJ7YP7/ESibKgvJ3Qm
         HdDthLqOWBGq5dR4aqfdneluD+CBL973TfvJCeMvRSasegalRmST8bDLeZNk7SS04UbB
         2GWrwfm4NeDOBfVmuTA52tKc6BXeQGPXJB2XwVxPlxLRs6FBGF3svzsnydbwSBW09iVq
         yDUw==
X-Gm-Message-State: AOAM531rjdpGI/J/UFGfRgjElGRlMJv9klbZwW7IhSuvbxQiDhXWwNCg
        79Lp2nuryAvjOpv1ZgKbO81b59NWFGN/Ag==
X-Google-Smtp-Source: ABdhPJz7Qo74KWQjFmgHXsxBlbBgMkDon7y+iEK3xtmizs5I+GQ8De+SZ725yfUpY9nPfniAvlhAqA==
X-Received: by 2002:a05:6214:e6b:b0:45b:474:1035 with SMTP id jz11-20020a0562140e6b00b0045b04741035mr18262385qvb.39.1652324704087;
        Wed, 11 May 2022 20:05:04 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 05/14] fs: Move call_rcu() to call_rcu_lazy() in some paths
Date:   Thu, 12 May 2022 03:04:33 +0000
Message-Id: <20220512030442.2530552-6-joel@joelfernandes.org>
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

When testing, we found that these paths were invoked often when the
system is not doing anything (screen is ON but otherwise idle).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/dcache.c     | 4 ++--
 fs/eventpoll.c  | 2 +-
 fs/file_table.c | 3 ++-
 fs/inode.c      | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..517e02cde103 100644
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
index e2daa940ebce..10a24cca2cff 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -728,7 +728,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
 	 * use of the rbn field.
 	 */
-	call_rcu(&epi->rcu, epi_rcu_free);
+	call_rcu_lazy(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 7d2e692b66a9..415815d3ef80 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -56,7 +56,8 @@ static inline void file_free(struct file *f)
 	security_file_free(f);
 	if (!(f->f_mode & FMODE_NOACCOUNT))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+
+	call_rcu_lazy(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
 /*
diff --git a/fs/inode.c b/fs/inode.c
index 63324df6fa27..b288a5bef4c7 100644
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
2.36.0.550.gb090851708-goog

