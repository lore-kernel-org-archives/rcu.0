Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F452C433FE
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 08:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK1I2n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiK1I2l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 03:28:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90A10FF8
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a9so6291068pfr.0
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIBDLgNJm6wq8JPRfLn4tYQ2/kM5jTjowjk1QH/M24Y=;
        b=GS2eIcifCybLrprEOJlMXWZn+7EY4b7bEQq/w68MwoYSYReSyAFbHl/G64eduCAGvK
         YepPY2NbtsgydgaGxSl7B9EC/E0NPk2xoeslUk66bqo87Hjac0vU+LsAIcse1DKe3FQz
         gFLx4GaJVl4AU0CGl6eeXHOpEX+jKIU22QObFr+W34PeOUo445/8yy5kn2DNs9HZFzmy
         b9KYDYKbVxFL/1BzXjhpB9PcACXfOATv1JG7wHQDpM60qsZzdaspM8HwYH9J2qkdarHO
         lMS7HHQSagJ5CW0oZPGx+UH8wfDNoJEewTC6PxVUHmzSpIiY5fPOTRsugdR+D5XQ+VaH
         F35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIBDLgNJm6wq8JPRfLn4tYQ2/kM5jTjowjk1QH/M24Y=;
        b=CPHJAUA/lsrTdH0s+nOdIgkT8ekLDtnQrv9vQqmKVvwoEgOspA3e7i3vkXkBvZV9Q2
         La+cccn1FeCeG5fqxIY5CpoiEuwivaHNZZfatq3hEPIn775VR+9hbIrDUw7fKqf3TUeW
         o7uySMA3VYE5JGyg0AC1GwWp1+K3Gx9VJkg1z6knC+OK3zgmqC81eiy8CZIldkpJzh+0
         ZSmd/lBcXWue5fHahBzMQNoLPJuM/o0w9JSSRvvb07ZSLHLabnwjnTCqC93gNbCcZCHa
         9GGZZi/0VBsvQ18mvCTlC/qxUoZUS8R3j8b57odjzcfUNBo57xJb4VvjrQg9htg49R3d
         2UtQ==
X-Gm-Message-State: ANoB5pn+0PGRtcx9/GQgNAbbp/drrG3ItVgrLxJp4kmg4e0NEcKdLDQP
        IF4EgHF9eBSWbRPdpv9PbTIuzl5Nfs4I
X-Google-Smtp-Source: AA0mqf6l6hAvEgEjw9h11Sb6OBxfa2aL30hXk2m5l8NJvv/qfIVaBSyeYXAF0EB6K2MfjMaCjav74A==
X-Received: by 2002:a63:cd52:0:b0:42a:9ba8:8c6b with SMTP id a18-20020a63cd52000000b0042a9ba88c6bmr45053646pgj.407.1669624119823;
        Mon, 28 Nov 2022 00:28:39 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79494000000b0056f0753390csm7601637pfk.96.2022.11.28.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:28:39 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH 1/3] srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
Date:   Mon, 28 Nov 2022 16:28:14 +0800
Message-Id: <20221128082816.28518-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128082816.28518-1-kernelfans@gmail.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
And it is not needed. Because counter_wrap_check has guarantee that both
srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
srcu_gp_seq and no false alarm will be raised by the statement in
srcu_gp_start_if_needed()

  ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)

As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
used immediately, not need to wait for another srcu_gp_end() to update
the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..fe0759d89c2d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1092,7 +1092,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_CALL)
+	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
 		sdp = per_cpu_ptr(ssp->sda, 0);
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
-- 
2.31.1

