Return-Path: <SRS0=v0Re=DQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D50C433E7
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC71322282
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 19:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDt+FMw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgJITrr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729280AbgJITrr (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 9 Oct 2020 15:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602272866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lgXKGmJY8FuTXCXdpAoSLX4NBWkvEFcm38oteYITDlM=;
        b=bDt+FMw1IFs0ALzIc7TEbakxKz3gXcvlEkrMsV+ImV2rvHiDstF5fOnTb7JwMvCphekxz9
        21bsMyN8aRWCCWGjL8NX+Ba2+con1IjjgxY3lfimIpzc7pjj/QYoXLnZM1NYK+d9SZEQL2
        hHrX7O6uRcRoiDMa2/fe0+OfcV3lMbE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-aWI6HtLfONugSkWldZBqiQ-1; Fri, 09 Oct 2020 15:47:44 -0400
X-MC-Unique: aWI6HtLfONugSkWldZBqiQ-1
Received: by mail-oo1-f72.google.com with SMTP id q75so4448653ooq.16
        for <rcu@vger.kernel.org>; Fri, 09 Oct 2020 12:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lgXKGmJY8FuTXCXdpAoSLX4NBWkvEFcm38oteYITDlM=;
        b=CpDqGzbveKd9R/sT9LDlXBzX6j/qsEfp+8zzvJ7JzT/SflEVKC3z6T0bSj6RovP5iD
         OOXHvFZeFYe0jHKYG0jyD3WFZ+IyS6m8+CueDIP7D5cvtn0LNAvk8MXvUvwNVl2UpE2k
         9ukXG9K7bmRZNX+n4JZsfAL/fjMLTW54orchk/i9xv1wDB/blKv+IG+JwWrlm3R10cCu
         uKjI/JkUG/z83IzZgLFs88LjsC6B05aI/q4B3Blid+rdnRKdYpr4/095BgcKEmtXhnz7
         pxq1pQJON7Bv/71i6vlheFNQ5VKVAYFl6cv+cLMKiziXKzv70ujxgkwWQI/0MCv0lu24
         bIhg==
X-Gm-Message-State: AOAM533tYUEVBDVgtPwzrclcDSTaVvLu7kR3wj4dbzMnOGxjX1GtpNXE
        z5SIaDMwC7IxJ6isud7fkRIg35yzvOcukDSe4eN4x5Xnp5iKfot4DAdMiY7jajS6OcmR2ZlvWuh
        ihp3KcBrMUAPm
X-Received: by 2002:a4a:e08a:: with SMTP id w10mr10404066oos.18.1602272863906;
        Fri, 09 Oct 2020 12:47:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQflYEfbzuxtLITg+Up9jg2c8kNCLAPz8wTSQCn0w7U0e6jYxqCjicPoPfd05rsY6eO5cFCQ==
X-Received: by 2002:a4a:e08a:: with SMTP id w10mr10404056oos.18.1602272863697;
        Fri, 09 Oct 2020 12:47:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s20sm8164861oot.15.2020.10.09.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:47:43 -0700 (PDT)
From:   trix@redhat.com
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] rcutorture: remove unneeded check
Date:   Fri,  9 Oct 2020 12:47:36 -0700
Message-Id: <20201009194736.2364-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem:

rcutorture.c:1999:2: warning: Called function pointer
  is null (null dereference)
        cur_ops->sync(); /* Later readers see above write. */
        ^~~~~~~~~~~~~~~

This is a false positive triggered by an earlier, later ignored
NULL check of sync() op.  By inspection of the rcu_torture_ops,
the sync() op is never uninitialized.  So this earlier check is
not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index beba9e7963c8..6efc03a1d623 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1989,7 +1989,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
-	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+	if  (cur_ops->call && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
-- 
2.18.1

