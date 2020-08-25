Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A81C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E2F20786
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 15:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/MjNPhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHYPVC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgHYPVB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Aug 2020 11:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598368859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QZRmB4/RPxacyHhvYI5pKH3akjxklNb3CEfkDnx3Pc=;
        b=W/MjNPhJ0cGCEM8avGtNCMMhwRo4N+EtJV9uq2wWAiUXJt+ZepFRT41tQqakYvzhl/89Y9
        eu58uszDG3y87DaItxJTbCstk3nTn/Ncb/pC0YCLW3TKdTFLKuPoKdCs2xmdMgT1ohP/Vy
        zZPAob90bnaZbtcjY1LBurWl5LXyBqE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-uLU87o9QOse9UoypRciL2A-1; Tue, 25 Aug 2020 11:20:58 -0400
X-MC-Unique: uLU87o9QOse9UoypRciL2A-1
Received: by mail-wr1-f72.google.com with SMTP id l14so5272154wrp.9
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 08:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QZRmB4/RPxacyHhvYI5pKH3akjxklNb3CEfkDnx3Pc=;
        b=JTLuX3AB6X8YrieqMs73hi/tITQ4SG4I93I6UQKb6pRMonHwLAHl4uyWNgIowDzI3N
         yLGp7e5lYrGufm9AAw6FN6irfl96t3hdFJ9tu3ClyizxZUkYm4JMFVXpWQV1f/vjdAN4
         e83EEtyj2rpunm6g85zvvw+lCCHFmnhhCWE1r60h9xzUJXi15BHhXn/B3BLZH1z0+KtT
         NT7i/dc2kscF+Nvu2TVylDGkQnT5kfiBi5t3sGFtyNa+AnUjLg0wY+G5EsSgAUBylFoy
         J7T4coRlK68EPrE1I5JxmkZl0x6P6PgJZBNrY3yhc/jsxCdto9kqFURGHknpdRxRMdAx
         FfxQ==
X-Gm-Message-State: AOAM5311FhKPGee25+QZJ9l3z4A2XfLea/O4hSjBfy2XxW1EmuEsATzL
        SxYh+6mjF3UitPANXnBhJxPkgr59A9WWW+io8j2Qee6gvsT7/nqLLHaeQxm2A2NRH+k+d74Cuej
        rseYE/J2hR1iw
X-Received: by 2002:a5d:674d:: with SMTP id l13mr11203224wrw.151.1598368855719;
        Tue, 25 Aug 2020 08:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMr0c4TXaDRXBFNlboV/Vpb0E+X4BR0ERWb0Wd3nEDU6zNMOo23BsBFCd3jdqfaicALnzoNA==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr11202900wrw.151.1598368850640;
        Tue, 25 Aug 2020 08:20:50 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id t4sm28372514wre.30.2020.08.25.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:20:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH 2/3] selinux: remove the 'initialized' flag from selinux_state
Date:   Tue, 25 Aug 2020 17:20:44 +0200
Message-Id: <20200825152045.1719298-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825152045.1719298-1-omosnace@redhat.com>
References: <20200825152045.1719298-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

After the RCU conversion, it is possible to simply check the policy
pointer against NULL instead.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h | 10 +---------
 security/selinux/ss/services.c      | 26 ++++++++++----------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 839774929a10d..64aafda76f9ae 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -95,7 +95,6 @@ struct selinux_state {
 	bool enforcing;
 #endif
 	bool checkreqprot;
-	bool initialized;
 	bool policycap[__POLICYDB_CAPABILITY_MAX];
 
 	struct page *status_page;
@@ -111,14 +110,7 @@ extern struct selinux_state selinux_state;
 
 static inline bool selinux_initialized(const struct selinux_state *state)
 {
-	/* do a synchronized load to avoid race conditions */
-	return smp_load_acquire(&state->initialized);
-}
-
-static inline void selinux_mark_initialized(struct selinux_state *state)
-{
-	/* do a synchronized write to avoid race conditions */
-	smp_store_release(&state->initialized, true);
+	return rcu_access_pointer(state->policy) != NULL;
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ec4570d6c38f7..d863b23f2a670 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2142,9 +2142,6 @@ static int security_preserve_bools(struct selinux_policy *oldpolicy,
 
 static void selinux_policy_free(struct selinux_policy *policy)
 {
-	if (!policy)
-		return;
-
 	policydb_destroy(&policy->policydb);
 	sidtab_destroy(policy->sidtab);
 	kfree(policy->sidtab);
@@ -2221,20 +2218,19 @@ void selinux_policy_commit(struct selinux_state *state,
 	/* Load the policycaps from the new policy */
 	security_load_policycaps(state, newpolicy);
 
-	if (!selinux_initialized(state)) {
+	if (!oldpolicy) {
 		/*
 		 * After first policy load, the security server is
 		 * marked as initialized and ready to handle requests and
 		 * any objects created prior to policy load are then labeled.
 		 */
-		selinux_mark_initialized(state);
 		selinux_complete_init();
+	} else {
+		/* Free the old policy */
+		synchronize_rcu();
+		selinux_policy_free(oldpolicy);
 	}
 
-	/* Free the old policy */
-	synchronize_rcu();
-	selinux_policy_free(oldpolicy);
-
 	/* Notify others of the policy change */
 	selinux_notify_policy_change(state, seqno);
 }
@@ -2282,13 +2278,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		goto err;
 	}
 
-
-	if (!selinux_initialized(state)) {
-		/* First policy load, so no need to preserve state from old policy */
-		*newpolicyp = newpolicy;
-		return 0;
-	}
-
 	/*
 	 * NOTE: We do not need to take the rcu read lock
 	 * around the code below because other policy-modifying
@@ -2296,6 +2285,11 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	 * fsi->mutex.
 	 */
 	oldpolicy = rcu_dereference_check(state->policy, 1);
+	if (!oldpolicy) {
+		/* First policy load, so no need to preserve state from old policy */
+		*newpolicyp = newpolicy;
+		return 0;
+	}
 
 	/* Preserve active boolean values from the old policy */
 	rc = security_preserve_bools(oldpolicy, newpolicy);
-- 
2.26.2

