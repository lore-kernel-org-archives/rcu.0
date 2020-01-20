Return-Path: <SRS0=Bg9d=3J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B812C32771
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5832253D
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBq8fcYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgATWmI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:42:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35594 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATWmI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 17:42:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so1219419wro.2;
        Mon, 20 Jan 2020 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ITBcINNYy8cuY+EjN48KeHLH2wyMa+Vm+dTbM0bJoY=;
        b=ZBq8fcYyAOPw1LCn4VC+SUeaCsV5GuCHmZ1Oz6HgtNFSoDhMNsnXs732RN+BL8MBI+
         gRuuiM+nbYj/pOskLF01fH7TqMUc7nxBTBnVXypr3veBXhUjksBxvhcMtDhYOtmaz75F
         yK9ousgYGRJ5FFQOqesWDw+8475puKBGROOMriHQ6m8Mh7yuf4gk2eZ5qTUQIoF5LUU8
         P7y9SB1094pSu0k2VcTHgpLFtly2DlQV0saoH4QlF0eperDq7VB/miYoKJ5TWiXwLpJF
         HYP/cXwSUu4ByK0C+bWjpbx4SoYszfQCCEaOeuv0vgR9Yt/mzlsHnteFMzufLUSBxydQ
         U7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ITBcINNYy8cuY+EjN48KeHLH2wyMa+Vm+dTbM0bJoY=;
        b=szKYLDGKIspYHWwoKafkRcfXfkCcw1BbZvp+XgALmGa0NuF4ro5Ro++8ubxYdyF20d
         ByOXygzVNsB2NAyQRt+qUm4obb+csIBsP7y9IALq5CJcQvjK4RJ+531XgSfztrz+knHh
         7spOBkuA0E8HjCVVtFLVrjZCmYTzLNcn9AScknJ0ldkZdSNaBC4NyDYK5f2Gdo6JGQnG
         bbkn2U9cPT1IXdSp4PAkeTKF7KGoZKW1d05I5k1QUtoE6l0n29l5TkKlK6ysA2/q873B
         6qPLIrY3ELH0gQBpy08OGUrJvqsZJ814h5dccISSoWYr9AL9kQWNf5dWEIIh74x457pg
         R4Qw==
X-Gm-Message-State: APjAAAVGR5MqPWY9/OyHFwPLJeci3pUZX3SlFWCU1M3fNocxRzQf0PAo
        2Vq05Ewe8YgcEzkW8Q8GaZ4zdOw1Yuus
X-Google-Smtp-Source: APXvYqx/Kxut5kmWYYqHaCNwY7t43/DGPZgpwx93/52+q6M/64a3kez+wXCxFiCPTa936ox4mEg7DA==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr1509034wrp.323.1579560126059;
        Mon, 20 Jan 2020 14:42:06 -0800 (PST)
Received: from ninjahost.lan (host-92-15-170-165.as43234.net. [92.15.170.165])
        by smtp.googlemail.com with ESMTPSA id a1sm1053666wmj.40.2020.01.20.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:42:05 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     paulmck@kernel.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, rcu@vger.kernel.org, iangshanlai@gmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 3/5] rcu: Add missing annotation for exit_tasks_rcu_finish()
Date:   Mon, 20 Jan 2020 22:41:54 +0000
Message-Id: <20200120224154.51683-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sparse reports a warning at exit_tasks_rcu_finish(void)

|warning: context imbalance in exit_tasks_rcu_finish()
|- wrong count at exit

To fix this, an __releases(&tasks_rcu_exit_srcu) is added.
Given that exit_tasks_rcu_finish() does actually call __srcu_read_lock().
This not only fixes the warning
but also improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 99f4e617116b..5853f19f0cb5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -809,7 +809,7 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 }
 
 /* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void)
+void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
 	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
-- 
2.24.1

