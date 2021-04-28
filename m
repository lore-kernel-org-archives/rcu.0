Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D912DC43460
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A037761443
	for <rcu@archiver.kernel.org>; Wed, 28 Apr 2021 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhD1Npy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbhD1Npx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Apr 2021 09:45:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF3C06138A;
        Wed, 28 Apr 2021 06:45:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b23so16761489lfv.8;
        Wed, 28 Apr 2021 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PetZkrnst5DMR2wou63SgbhmwqaPVRJGY+ZrQK1pWUo=;
        b=Ps/zpYSMEUFnuBDI2NNY2lBlr6Zl9DeFpStsqo5UDWuS4H0AcUpDDRWKIgrQgSTVs8
         s0spQcZEv9+9Pi9gq1uUquHrm+FoipFhYic0Ym/cbZADkC5cPmlffEDsRIZFyNIcpLwX
         BwpSa+T2sYeXBVzmn3UGthZzmctExx917Rp4FbYm375WqcqXRihDZ9YvmRaIwDPpVzAE
         Zhf/3ubtKdthcwFZVMEIV9BcfPAFTL8O3ow3Va0VR0996syL3x6E77HSbKr+2GnvZ079
         9Mc9Uc+e+QaOYiYk4iBbtMYRSp0iaZ1xsT4hOb95ma+qzGHz6iqckvrUZbThbz3L9RmA
         74Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PetZkrnst5DMR2wou63SgbhmwqaPVRJGY+ZrQK1pWUo=;
        b=DrUUv0hS+k+W0f7Df3aF8uMOXO6UOTTUPAtvG5CLWneIYoJz4FODiB/IRKoOnwAOW1
         IPuo13wCJTu3P+FxyX05L2OZMtWfLumbZxuvrvnBugKe7rMpQGbsuY/ZRzN8yly5JNfO
         MelbdP5jgvTMbF7UZUriCioR4JPT5LY1eqteJ4nHPRF4e3difEdpXnh8mEwdXE3KudNq
         LiLEDtx+SfsQ4Wh9WJkKei7auu5M82F6L7FOAh/rmyCjSLUDCmCMi83fGVqqLusMFvmi
         //i0my1sB7F9gGo3H0eS98tUo3Qlf5kOikrq/TbNYjrb/rCSJUKnLKC/TZdkdk5JTm7t
         cdqA==
X-Gm-Message-State: AOAM532KhB0VTbA95/nFrp0gQJAR1T+2IDzkTEwP5rHUt1RX2oNLrYYf
        zq2PIu68Wz9QpDLCTnXE3d9SHYOH/y+QfHwcRQ0=
X-Google-Smtp-Source: ABdhPJyXfA9Z64n3+sKR5K+VmvpzmCAlkOiDlEuB4hwZUQzimcO6gnLRsiJREL+RBQgtpZcoJxXH3g==
X-Received: by 2002:a19:c210:: with SMTP id l16mr15614087lfc.56.1619617507198;
        Wed, 28 Apr 2021 06:45:07 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o16sm730253lfu.228.2021.04.28.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 06:45:06 -0700 (PDT)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v1 2/5] kvfree_rcu: Switch to vfree_bulk() in kfree_rcu_work()
Date:   Wed, 28 Apr 2021 15:44:19 +0200
Message-Id: <20210428134422.1894-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210428134422.1894-1-urezki@gmail.com>
References: <20210428134422.1894-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Replace calling a vfree() in a loop per object by the
vfree_bulk() variant. In that case we just need to pass
an array of vmalloc'ed pointers and number of elements
in it.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ea1d4eef1ad..6bf170d01cd5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3280,7 +3280,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head, *next;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
-	int i, j;
+	int i;
 
 	krwp = container_of(to_rcu_work(work),
 			    struct kfree_rcu_cpu_work, rcu_work);
@@ -3313,13 +3313,7 @@ static void kfree_rcu_work(struct work_struct *work)
 				kfree_bulk(bkvhead[i]->nr_records,
 					bkvhead[i]->records);
 			} else { // vmalloc() / vfree().
-				for (j = 0; j < bkvhead[i]->nr_records; j++) {
-					trace_rcu_invoke_kvfree_callback(
-						rcu_state.name,
-						bkvhead[i]->records[j], 0);
-
-					vfree(bkvhead[i]->records[j]);
-				}
+				vfree_bulk(bkvhead[i]->nr_records, bkvhead[i]->records);
 			}
 			rcu_lock_release(&rcu_callback_map);
 
-- 
2.20.1

