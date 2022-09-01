Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EEECAAD1
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 15:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiIAP1M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiIAP0n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0378753AB
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXJ3eu32792Tz+PNWkqX8ynt0TaLdrtHwSsiZCTO97I=;
        b=PnGwi4lxz3tqrGvsyb4zkD2gjSkXZjCR/TZ+V6O8peI5zNcQPPQXFiKFaDle4kHA4sRy4a
        kApBx7SoOjKSht+8G4ZkerI2jNAZUIAInGtP9GyaLszSBc5rzfTxu9UxD3xWL9pE0CxGBK
        dQKa7O7ZdQEhtHvEJxVcpNCuJFDFAus=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-Ry-R5uOKMQmrUQRnoJsKwg-1; Thu, 01 Sep 2022 11:26:36 -0400
X-MC-Unique: Ry-R5uOKMQmrUQRnoJsKwg-1
Received: by mail-ej1-f70.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso6950676ejc.5
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xXJ3eu32792Tz+PNWkqX8ynt0TaLdrtHwSsiZCTO97I=;
        b=HAW9rtncLzqURHJdJm1raSMi0vv/dAPDi6+vHRfyoS0T78UWdiRQGakHCxTS3bqTbQ
         Qjt31VZS4L0qi82hlQFDLWpVQmtcw9FxBPeV7gcSn0VCAXORBcJltK+b+G49eFN0Ll5D
         2nImpr+n2fSkKcaX6sBoweX5piElb45HCBidEr5qYYOolvmcn8oXeEZcYn3qAZ2jCiEW
         iO6VWHItM/j2Xqf22QozrtngSVlNwaojQidfAJ8CjZIXGCL7y/rMhesuhb/ZJwVaWgxy
         RgdMQbZDYDhye4TD1YoLBETIn1kNu6oTyTd21Od/cZfHk58W0SiGlsbYppqMmUovoc8i
         BCQA==
X-Gm-Message-State: ACgBeo2z3Wj2I5D4QCBEKp8lT+Al7NWhfWyfQ29UGEfLOOoKzosPgHjB
        OqlS82au0v89y/nfAfAYic2dhVAU9g05hCEyrhqq1fslz7MTRD4hFtzFsq7/KOLUlc57DbvaBiy
        uVmDYnk5tkNI+
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr24608325ejy.13.1662045995522;
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FRde2+0Kq+Aw/cF6maS0iAuZMFCEh7wb5iWZ1StV35X9kMHScj7jMEScvxLEBUmONF9VBmg==
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr24608307ejy.13.1662045995247;
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 1/2] fs: convert simple_xattrs to RCU list
Date:   Thu,  1 Sep 2022 17:26:31 +0200
Message-Id: <20220901152632.970018-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901152632.970018-1-omosnace@redhat.com>
References: <20220901152632.970018-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Use the RCU list mechanism instead of a simple lock to access/modify
simple_xattrs. The performance benefit is probably negligible, but it
will help avoid lock nesting concerns for an upcoming patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/xattr.c            | 36 ++++++++++++++++++++++--------------
 include/linux/xattr.h |  1 +
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index a1f4998bc6be..fad2344f1168 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -22,6 +22,8 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 
 #include <linux/uaccess.h>
 
@@ -1030,8 +1032,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 	struct simple_xattr *xattr;
 	int ret = -ENODATA;
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		if (strcmp(name, xattr->name))
 			continue;
 
@@ -1044,10 +1046,18 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		}
 		break;
 	}
-	spin_unlock(&xattrs->lock);
+	rcu_read_unlock();
 	return ret;
 }
 
+static void simple_xattr_free_rcu(struct rcu_head *rcu)
+{
+	struct simple_xattr *xattr = container_of(rcu, struct simple_xattr, rcu);
+
+	kfree(xattr->name);
+	kvfree(xattr);
+}
+
 /**
  * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
  * @xattrs: target simple_xattr list
@@ -1094,11 +1104,11 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 				xattr = new_xattr;
 				err = -EEXIST;
 			} else if (new_xattr) {
-				list_replace(&xattr->list, &new_xattr->list);
+				list_replace_rcu(&xattr->list, &new_xattr->list);
 				if (removed_size)
 					*removed_size = xattr->size;
 			} else {
-				list_del(&xattr->list);
+				list_del_rcu(&xattr->list);
 				if (removed_size)
 					*removed_size = xattr->size;
 			}
@@ -1109,15 +1119,13 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		xattr = new_xattr;
 		err = -ENODATA;
 	} else {
-		list_add(&new_xattr->list, &xattrs->head);
+		list_add_rcu(&new_xattr->list, &xattrs->head);
 		xattr = NULL;
 	}
 out:
 	spin_unlock(&xattrs->lock);
-	if (xattr) {
-		kfree(xattr->name);
-		kvfree(xattr);
-	}
+	if (xattr)
+		call_rcu(&xattr->rcu, simple_xattr_free_rcu);
 	return err;
 
 }
@@ -1169,8 +1177,8 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	}
 #endif
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		/* skip "trusted." attributes for unprivileged callers */
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
@@ -1179,7 +1187,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (err)
 			break;
 	}
-	spin_unlock(&xattrs->lock);
+	rcu_read_unlock();
 
 	return err ? err : size - remaining_size;
 }
@@ -1191,6 +1199,6 @@ void simple_xattr_list_add(struct simple_xattrs *xattrs,
 			   struct simple_xattr *new_xattr)
 {
 	spin_lock(&xattrs->lock);
-	list_add(&new_xattr->list, &xattrs->head);
+	list_add_rcu(&new_xattr->list, &xattrs->head);
 	spin_unlock(&xattrs->lock);
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 979a9d3e5bfb..3236c469aaac 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -86,6 +86,7 @@ struct simple_xattrs {
 
 struct simple_xattr {
 	struct list_head list;
+	struct rcu_head rcu;
 	char *name;
 	size_t size;
 	char value[];
-- 
2.37.2

