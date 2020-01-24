Return-Path: <SRS0=Fsgb=3N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3FC2D0CE
	for <rcu@archiver.kernel.org>; Fri, 24 Jan 2020 04:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255612072C
	for <rcu@archiver.kernel.org>; Fri, 24 Jan 2020 04:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgS4/gVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgAXE73 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:59:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37824 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAXE72 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Jan 2020 23:59:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so392507pga.4;
        Thu, 23 Jan 2020 20:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oOSQMwxHrwpswTLtDsPfKJzl+DtBJm84K0zAoJhjCSc=;
        b=LgS4/gVSwk+VUuIpn31qywoCF6O/vIt9PEnG13y9vr0YNNMriFnwVVpWKaztD/TO2w
         HAVvQjQU+mqiW0wF24cqZSOd7H81NKnP7ukMolSGgWZ9gzALpzXmOiBAQDp3wK+cpLx5
         HYFGAyXibXCeUdFp1ILPs3oHyynj9I52glMPJ/L4Cr8J3QSJEQVyfgBhiPoe5Q071jNi
         5+A2y2Bn7SARBRQpM/cCFo6AlBVbi1mTWZIbWcCUDIvbuCmtwt3FE5eoFzWF/8lQ9s9H
         xV/R2Rx5R9ZD7tRoCbRBGvAf5qq289qt2nurAZL7S8EKrsq5CX6miuQihItnmc/mDIJH
         HB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oOSQMwxHrwpswTLtDsPfKJzl+DtBJm84K0zAoJhjCSc=;
        b=UzEwi5eUfBRYxmcR+SwA/8zp90ouW9g6Ghb2x8Jz6f42ZBcsP2m750uCFXyutq3/Ev
         NrxdRGmIm0GbZDbvYX5mdI0Pg1kY1RP5wzZed+qC+oc2xaKeZmlpQm8TgvXkJmXLNUWg
         hnwGkB32z0wWD42R8A7eYKp9bm6J4lJIoV/P2og17mxAzeNl6yjFX7O4wm0uT4QkDHpX
         x2A6ghz44Tv21XuEYzzGGpdR/Y1rGLV4N5fDP6QgjM9lXc6GTB9blGUcgQ2RdGDOeaQm
         Rw9lI++OenlJ1JPaOwrCysVwINTcDDdYclhoCBTPZL8QjrFRgYMYnRgo2LkLprT3GsFA
         Uf2w==
X-Gm-Message-State: APjAAAU1hkZTwws4O5sa+uS6QmuZ6abJexIDP5AaFRMUoy9KtUbFs0sj
        q/Wkrcpo5bcKp873xwTFaA==
X-Google-Smtp-Source: APXvYqzZmm/J/2bN7SPdZkjqtyzQWQPFVFUb3O9enD9Larc5uGqsZiP5cy3GcbEniXFpRsttYfbCbQ==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr2003067pgt.432.1579841968170;
        Thu, 23 Jan 2020 20:59:28 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee5:e37b:209c:91b0:b68a:515f])
        by smtp.gmail.com with ESMTPSA id m22sm4949610pgn.8.2020.01.23.20.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 20:59:27 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, paulmck@kernel.org
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] sched.h: Annotate sighand_struct with __rcu
Date:   Fri, 24 Jan 2020 10:29:08 +0530
Message-Id: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse errors by annotating the
sighand_struct with __rcu

kernel/fork.c:1511:9: error: incompatible types in comparison expression
kernel/exit.c:100:19: error: incompatible types in comparison expression
kernel/signal.c:1370:27: error: incompatible types in comparison expression

This fix introduces the following sparse error in signal.c due to
checking the sighand pointer without rcu primitives:

kernel/signal.c:1386:21: error: incompatible types in comparison expression

This new sparse error is also fixed in this patch.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/sched.h | 2 +-
 kernel/signal.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b511e178a89f..7a351360ad54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -918,7 +918,7 @@ struct task_struct {
 
 	/* Signal handlers: */
 	struct signal_struct		*signal;
-	struct sighand_struct		*sighand;
+	struct sighand_struct __rcu		*sighand;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
diff --git a/kernel/signal.c b/kernel/signal.c
index bcd46f547db3..9ad8dea93dbb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 		 * must see ->sighand == NULL.
 		 */
 		spin_lock_irqsave(&sighand->siglock, *flags);
-		if (likely(sighand == tsk->sighand))
+		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
 			break;
 		spin_unlock_irqrestore(&sighand->siglock, *flags);
 	}
-- 
2.17.1

