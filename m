Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D916C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6CC20732
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glosnH0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgC3P0Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:26:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44529 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgC3P0X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 11:26:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so18526100lji.11;
        Mon, 30 Mar 2020 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVWvL7FJyDvpdpi9pdPsA+dA31nRe8ZldG9T16F8HKA=;
        b=glosnH0e6FfWsIsKrwJ8AICvpDu35pUliQYSOvxP1Qd5VojmLntXe5TzcNBOtvEroT
         JIs7u2t29W6EaP/xGUYgxKW8qwFckqSLqHUot+EjDzcmU5H0xNxsWmcysiub3M4sy0sV
         vSXDgyH41YTZwXSOH441UCWwB7DgaMnX9nZxZOHGY2mpDWZaqbjJBXJ9/hbWDWeEmbyg
         jMPUus3xGs2m94x/fgAM76S83BFaOVFVJfRxFSXTVtdmW/pc/44drlMIdC23x6iOwvyA
         Oy2rgOmz7SjcnZ54YmPJoKc/N9MStSaZRoC7T1mmM41W6qeSEWADgIuw699rTjvqxE1G
         /5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVWvL7FJyDvpdpi9pdPsA+dA31nRe8ZldG9T16F8HKA=;
        b=Cqro4S2wkWjB5oTqZ1KoS8jEa/j/YC5VI5gHBsUajGzzqjHzKvTHY9AzYNBD0S/UmY
         qJTWWn3uHg0w0qF4DNWg09O62ccB1XLcM1Tzrp6KeeTRze6Rlhh9CPYngtDfml4BBC6G
         pRmiALcinOYtq8NbrVTRtPotgEtnwb0SqY+BBL/J1E4vdRDH3Lv1KRPKwfaEryVirBNa
         fYAvhtVAa1GSsDhmXnf7tK7OlNJtRf60C3/3fTTc5FupUwIzag4B05+bChxtklB42RVd
         ckJrNpxSAZkf0QDLfUIbn65cxoVn+bYY0+388rXN1RVPFclfllvVN/OCf9QQRNLLPDEz
         16rw==
X-Gm-Message-State: AGi0PuZf+rwGckBfff3a4HMz3uAOkkptNqueroPZcvJSIfIkbm5HQsJ4
        0Oxrm7fwDjAPnJsBX0aG59xXtY5lXZU=
X-Google-Smtp-Source: APiQypJoZeLuF4bX2VOMhyn6o5V1uGe0P+PRsAai8rXV//JPFkiBtlMyuWmI5l2SxflsMHjhswAkqw==
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr1026823ljn.173.1585581980829;
        Mon, 30 Mar 2020 08:26:20 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c2sm3930891lfb.43.2020.03.30.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:26:19 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] rcu/tree: include mm.h where kvfree() is defined
Date:   Mon, 30 Mar 2020 17:26:12 +0200
Message-Id: <20200330152612.2455-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix build error, due to implicit declaration of
function vfree() by just including an appropriate
header file.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d6536374d12a..27ed119a9027 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -57,6 +57,7 @@
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/clock.h>
+#include <linux/mm.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
-- 
2.20.1

