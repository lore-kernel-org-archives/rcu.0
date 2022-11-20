Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C34C433FE
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 03:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiKTDka (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 19 Nov 2022 22:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTDk3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 19 Nov 2022 22:40:29 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0151A8C24
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 19:40:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 6so8333009pgm.6
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DTSyWnIae6yVAltEqrEYQOovEV23TqUFithoU/uJC8=;
        b=VAk1eyrw3lO7JkLnYyeAI1AqDc/oMC8i7okXvmBpypXbVZiL9LBc7s6snjnLomxavN
         /wZClFR9SIln2qx4WKPUwC1Snb9TA5lyC5vzLm7+1c8foOCXm7eTrBhoFCNVNb6xFftE
         bwsrAL1uwVaMmqtSdMD9BqDAOGwcBoKiSUWx1onDu+mbaz0e9TxqUqxcA2EwB+Tyh6cM
         dt7YUcwUGFk485LGvkwumJygjDCJLsARvHO8KZ34onVmElCRt6fSUpVD7VrWhzZwtILy
         g5oaoGyW1ws/pdVavJlKzS6TdsaKRzTE4HllPtzQMVg1RjLXtJPdgXHb8Gw+XRj7+vuk
         cfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DTSyWnIae6yVAltEqrEYQOovEV23TqUFithoU/uJC8=;
        b=Hag5dwkSjbYmFhARmrNs0d87ZUblrtBhqDmMZAHDrGxR/ONQRIy7cpDfZwHtXO1LaQ
         lX7gQpzCaSW++Ynl8lPgEl+PsGP266/Zs9HEx9T1I1l6IYXZbZ/Jlq4f/2TIEG+bJ+GR
         mRI7BSNNSa3MLwNdLc5HyQRdzCaJm5ekK2ZEuUSuXLIb2Ro4RS3/S91w+ed/qYlL1dR+
         MkHZD5egy+oWFc5LzNqxWCd/j0N0eb4ggJVP2BBMbv6fcHRM4Yk3b3oBp4DbiHmsLZDW
         cycQbyDYHxXph1+SLBmg9EcnwrV8Ps6FgrtJqHSGMSzQHqNLqpeQdilXUPB8OETAzAnU
         7y3g==
X-Gm-Message-State: ANoB5pk47qz0Hf5GjzAzHxvlOnB2kasO8fHnXW8/gnY5mmIpAXmZz8BZ
        5Vu8BEcWx+GIGVRIV8r2ahHmCMNCLg==
X-Google-Smtp-Source: AA0mqf4sgnlBUn4WoAFQsR3zvresiWhUUM4IP1Wdxuu1lyXWDY7N+rDELsZ63QSSdBVepF6uKjkhGw==
X-Received: by 2002:a63:d547:0:b0:476:ca45:15b6 with SMTP id v7-20020a63d547000000b00476ca4515b6mr12753915pgi.470.1668915627834;
        Sat, 19 Nov 2022 19:40:27 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gq18-20020a17090b105200b0021864cf062dsm5297260pjb.21.2022.11.19.19.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:40:26 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/2] srcu: Optimize when srcu_gp_start_if_needed() holds
Date:   Sun, 20 Nov 2022 11:40:12 +0800
Message-Id: <20221120034014.7390-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This series optimizes and remove some code under the condition that
srcu_gp_start_if_needed() holds the srcu read lock.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org

Pingfan Liu (2):
  srcu: Remove needless rcu_seq_done() check while holding read lock
  srcu: Remove needless updating of srcu_have_cbs in srcu_gp_end()

 kernel/rcu/srcutree.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.31.1

