Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62291C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 15:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F65520786
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 15:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaawdlSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHYPU6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:20:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727115AbgHYPU4 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Aug 2020 11:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598368852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUrg+txlOo0JbF4kQi+3PlVRqQ+yb6z0n/ACBb1Ji2w=;
        b=ZaawdlSk3ckT8tmqBi2wRu2+kWbkPPhWEC7u3wR2vz8LdixP/JbFNRjZucyOJGpXTPbShe
        0iY2sTQT//+1595Qlrbb43JgbbdOGxocmYcXxMU2+aRQ9Vmg+Bj0eZCBG3Y8nD6nc9J04C
        JNVOU53J4M0OYdQAgrQsDRfziHWK/xo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-BYx6dJ5MNEeLU5R0H5Lfpw-1; Tue, 25 Aug 2020 11:20:50 -0400
X-MC-Unique: BYx6dJ5MNEeLU5R0H5Lfpw-1
Received: by mail-wr1-f72.google.com with SMTP id u10so3924965wrp.3
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 08:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUrg+txlOo0JbF4kQi+3PlVRqQ+yb6z0n/ACBb1Ji2w=;
        b=W/7TGFfAARFFjQrUhqfw7jd4793EuV9dYNqrkrgooeNzt62vxnZzmzsKMjsq+dfJ5m
         Bvmqh4rXbqvUFzOGepTqXE+I6+pdD/uKO7yhpa8A3+SXYud8sETimuGn7tgVx3K+n79J
         Zs0tVE7yipqPCFKbLa2to2b1v0w5vetamPpEMW0/DN6BFTqBdxAXOgSJrCx35cF98KA6
         KxAk64W9eRySrovwAAYU4C2Gpds3gV1momlSV6mezXyTzlHzy6qQmGkpwPLQ6G3sJ/pc
         VXQH6f9HEnGksTZ2r0F4fd6K4N+tCyVYf6pr0zUmUf1geKlnZTkNU+BCFDUMIqODL5d4
         U5XA==
X-Gm-Message-State: AOAM531D89jwyEtdbBvQoWJt3Xp2k1NnqoAkAk0m0bHbWVCno0pQzxak
        WmSf488XUEQsRIN7CgmDxz77ArmNKHRxQTVvZvP8TDnWro2mC95RvNlldOdSuu8+TO9Lt3aFl7u
        jzRONt3rm7tsv
X-Received: by 2002:a7b:c197:: with SMTP id y23mr2517794wmi.48.1598368849541;
        Tue, 25 Aug 2020 08:20:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJLRkHczeEEXtB+BrYv3W/eAUw8rFeOIB6SZt5KYdkxrIvmwX6J0ZHl5ExV04HZx+eWTX6sw==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr2517773wmi.48.1598368849338;
        Tue, 25 Aug 2020 08:20:49 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id t4sm28372514wre.30.2020.08.25.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:20:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH 1/3] selinux: simplify away security_policydb_len()
Date:   Tue, 25 Aug 2020 17:20:43 +0200
Message-Id: <20200825152045.1719298-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825152045.1719298-1-omosnace@redhat.com>
References: <20200825152045.1719298-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Remove the security_policydb_len() calls from sel_open_policy() and
instead update the inode size from the size returned from
security_read_policy().

Since after this change security_policydb_len() is only called from
security_load_policy(), remove it entirely and just open-code it there.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h |  1 -
 security/selinux/selinuxfs.c        | 12 ++++++------
 security/selinux/ss/services.c      | 21 ++++-----------------
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 505e51264d51c..839774929a10d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -218,7 +218,6 @@ void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
-size_t security_policydb_len(struct selinux_state *state);
 
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d1872adf0c474..fc44c4b8c0692 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -417,16 +417,16 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 	if (!plm)
 		goto err;
 
-	if (i_size_read(inode) != security_policydb_len(state)) {
-		inode_lock(inode);
-		i_size_write(inode, security_policydb_len(state));
-		inode_unlock(inode);
-	}
-
 	rc = security_read_policy(state, &plm->data, &plm->len);
 	if (rc)
 		goto err;
 
+	if ((size_t)i_size_read(inode) != plm->len) {
+		inode_lock(inode);
+		i_size_write(inode, plm->len);
+		inode_unlock(inode);
+	}
+
 	fsi->policy_opened = 1;
 
 	filp->private_data = plm;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8381614627569..ec4570d6c38f7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2331,22 +2331,6 @@ err:
 	return rc;
 }
 
-size_t security_policydb_len(struct selinux_state *state)
-{
-	struct selinux_policy *policy;
-	size_t len;
-
-	if (!selinux_initialized(state))
-		return 0;
-
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
-	len = policy->policydb.len;
-	rcu_read_unlock();
-
-	return len;
-}
-
 /**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
@@ -3915,7 +3899,10 @@ int security_read_policy(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return -EINVAL;
 
-	*len = security_policydb_len(state);
+	rcu_read_lock();
+	policy = rcu_dereference(state->policy);
+	*len = policy->policydb.len;
+	rcu_read_unlock();
 
 	*data = vmalloc_user(*len);
 	if (!*data)
-- 
2.26.2

