Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F3C10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 15:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAB12067C
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 15:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpfYAznv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCLPNK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:13:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46070 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgCLPNJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 11:13:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so6720026qke.12;
        Thu, 12 Mar 2020 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLdhe5zz/3gMVJTRHKdPZxN/mknp2/3uH9yjLxovQmo=;
        b=TpfYAznvfSUfGwL3ajY9TE8po62ymtGjKLjesgAayCDAuwnLR3erM29TwGVUirz1Ps
         jhCOwN31NpO9IWJR4zxb0BULG2a0b1CCEtahCXM8mOP7rQ3tas4e4f5vPPQY2US2DYYS
         yt1DuIMLx+P6Zyg1ajWYr1jCvLD92pvTsScOJ8ycUGVUcqX086/Wu72bQKoe2FcxidX+
         YeXHiMDWTaV92geB8lDnO7WFK+rt24vNnJqLzv/eIiY6u8VBEG/Ij25m6H1iWIL+hPy1
         QoWqJWEYFTkIStLmvVOgq92eH8J19VIj9JENg03shG20h+i8go/4gCcUmosxKafIsa/b
         fNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLdhe5zz/3gMVJTRHKdPZxN/mknp2/3uH9yjLxovQmo=;
        b=OWuN5ZswiXulisL8pwgsfQg1kBCYlZc1mOQXtBklL0yZnaJH9qHwBL6l6iDcLAYRNs
         yvHE7PHzPQlaIK8JqK4bkeaq1/O1DIaG46dG5g3RSB2QmAkWCk0pTOHfoxyACOSIHkcl
         3A9IrFkNh70gqaCsVqe2WoZqi10JodNT7n8YwhTX8Y2olsfeVh9bCeovrtmVJN9ItFPL
         Ajh254OItV7n3a+e69Gw0LSf5rBJXgKtd5xDNfpofo6flPsiac7icOfdFIoI7/+h4nVy
         BNDIx+TG4QItu8JW/L+LVFUDQvp7ws4mDdRS7vRn2Hs7exSxNc/8tST6JianU9mG5s3t
         DBMw==
X-Gm-Message-State: ANhLgQ3+Vau7iK7BKmne/BojzvKnjutqpSAvYbl2Ti6ZhJHHatGwGDiS
        02FYURqiIQ5Yx7NHxIOH7aY=
X-Google-Smtp-Source: ADFU+vtS2GNXQX7nITmn7Cr8XJ4P48Lm0Cjp2BMBSaiepm6eiFK+slkKTYnqxwfyBYQwGZH6u4y0HQ==
X-Received: by 2002:a05:620a:a0d:: with SMTP id i13mr8293097qka.333.1584025987867;
        Thu, 12 Mar 2020 08:13:07 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t7sm3298089qtr.88.2020.03.12.08.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 08:13:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E59A122451;
        Thu, 12 Mar 2020 11:13:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 12 Mar 2020 11:13:03 -0400
X-ME-Sender: <xms:f1FqXuchvcX-ukgbsfVCH1KhnK11ZX_3Bg1O1vV9DZey7fJGU-nWeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefhvffufffkofgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthh
    hpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhn
    rdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:f1FqXsfuFVJM-HCyudEp0cHFp9OAQJv_bNePrzMhP7FPPyKPTp2FTQ>
    <xmx:f1FqXqhh_BrFbW32oqppTUJ5J3H3zKmyT-npL-2tB5bgC3bCBPCyRg>
    <xmx:f1FqXgSOEQNpLZAIYDtmAo2gn2aTH3p7B4oxrY67lDJEaHDC1GR8tg>
    <xmx:f1FqXhm56Q1PUOAeFV9FD7E9esW_LvKY3BH5HYb9qzmQz3MfZnW6wg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id F360830615B2;
        Thu, 12 Mar 2020 11:13:02 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Qian Cai <cai@lca.pw>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()
Date:   Thu, 12 Mar 2020 23:12:55 +0800
Message-Id: <20200312151258.128036-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Qian Cai reported a bug when PROVE_RCU_LIST=y, and read on /proc/lockdep
triggered a warning:

[26405.676199][ T3548] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
...
[26406.402408][ T3548] Call Trace:
[26406.416739][ T3548]  lock_is_held_type+0x5d/0x150
[26406.438262][ T3548]  ? rcu_lockdep_current_cpu_online+0x64/0x80
[26406.466463][ T3548]  rcu_read_lock_any_held+0xac/0x100
[26406.490105][ T3548]  ? rcu_read_lock_held+0xc0/0xc0
[26406.513258][ T3548]  ? __slab_free+0x421/0x540
[26406.535012][ T3548]  ? kasan_kmalloc+0x9/0x10
[26406.555901][ T3548]  ? __kmalloc_node+0x1d7/0x320
[26406.578668][ T3548]  ? kvmalloc_node+0x6f/0x80
[26406.599872][ T3548]  __bfs+0x28a/0x3c0
[26406.617075][ T3548]  ? class_equal+0x30/0x30
[26406.637524][ T3548]  lockdep_count_forward_deps+0x11a/0x1a0

The warning got triggered because lockdep_count_forward_deps() call
__bfs() without current->lockdep_recursion being set, as a result
a lockdep internal function (__bfs()) is checked by lockdep, which is
unexpected, and the inconsistency between the irq-off state and the
state traced by lockdep caused the warning.

Apart from this warning, lockdep internal functions like __bfs() should
always be protected by current->lockdep_recursion to avoid potential
deadlocks and data inconsistency, therefore add the
current->lockdep_recursion on-and-off section to protect __bfs() in both
lockdep_count_forward_deps() and lockdep_count_backward_deps()

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32406ef0d6a2..5142a6b11bf5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1719,9 +1719,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
+	current->lockdep_recursion = 1;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
+	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1746,9 +1748,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
+	current->lockdep_recursion = 1;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
+	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 
 	return ret;
-- 
2.25.1

