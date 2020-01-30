Return-Path: <SRS0=LYSJ=3T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A65C33C9E
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 06:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DEB206F0
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 06:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhtpN2xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgA3GUu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:20:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45256 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3GUu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 01:20:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so1083317pgk.12;
        Wed, 29 Jan 2020 22:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zMHEc0flI99qBQqzj4e4DXxEH1EhacSSKhwIiUnp+1c=;
        b=VhtpN2xsAoab5j+OLu9VSC+ZOwi4XRzPI0yYbHyjphZYtfbtU8Jxg+H/BRglroO/f0
         a0ITfk+IK607kmTkp+dIw0/dnJGuYSOXJoeVIDiFio4O0pfs7BE+jXmlKXBI1OZfXFJp
         NATXjkr1AF363UXRaXv1RHERVT9x+3eqmJiDEENZcPVuQsauRJ9YYnt2cCoURmUMIi/D
         AEDIqhUw/JhYlweTSumgx4F/HI2qCKUrvHxxzO5Bh2LmM1rEV/qWR15jZ18BlKGFHNwB
         HxzQuYAeGMKauOLO1w9ci8mb56YK5s78dME+mxfSu8PDKgTzENuuVwSLx8Z5Ll5Hv4Ox
         l/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zMHEc0flI99qBQqzj4e4DXxEH1EhacSSKhwIiUnp+1c=;
        b=M7jSCpvjcTT1gfbPbKIsXPXihvKar6SsxTjYm85Jzln6kEa40sKgyxUIld2+0LxxDi
         kg64DWX1GGMzlJ4Jyiaq+fusLJZUuOt9oFNpJmmwfsCEuI/fsLP+1fyeN1zE5Bb4APKh
         Wg8hh/Wg+w5SULIvPDyvzZfvzXdWvEcHxJfiXTfD5yJEiVoWNMme/8HV5IMJbSgfl92U
         rl1FtnKVfLY3nc2OE7MoWmDETiu0jv9s4/qHQAOypFgzdHrAI/Svs9I7KMRDDrLGEAWO
         IcXXeQFcwonKmmVjurnAjNS9SxCPsFtdKhKbsjh9L6+LFI/yEXHjwJuGam0OWuNYERwX
         9xKQ==
X-Gm-Message-State: APjAAAXUi2YpU+wAn9HdA/7jkdPnnt7dUKmvKYy0dDKI2v1Da7tvPsuq
        SBpfwuYjL3U6Lo4is9+V8A==
X-Google-Smtp-Source: APXvYqw4a2hKiGpcYewgSpLWc2dNqkZ5HkxaNFMcdKHAIBTJy2upjUfpxVclQix8G82rDVwgCtkqJg==
X-Received: by 2002:a63:597:: with SMTP id 145mr2947677pgf.384.1580365249786;
        Wed, 29 Jan 2020 22:20:49 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1eed:fc71:d421:7a49:b2e4:2bd6])
        by smtp.gmail.com with ESMTPSA id s124sm5041496pfc.57.2020.01.29.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 22:20:49 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        christian.brauner@ubuntu.com, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] exit.c: Fix Sparse errors and warnings
Date:   Thu, 30 Jan 2020 11:50:28 +0530
Message-Id: <20200130062028.4870-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse error:
kernel/exit.c:627:25: error: incompatible types in comparison expression

And the following warning:
kernel/exit.c:626:40: warning: incorrect type in assignment

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/exit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index bcbd59888e67..daf827a4aa25 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -623,8 +623,8 @@ static void forget_original_parent(struct task_struct *father,
 	reaper = find_new_reaper(father, reaper);
 	list_for_each_entry(p, &father->children, sibling) {
 		for_each_thread(p, t) {
-			t->real_parent = reaper;
-			BUG_ON((!t->ptrace) != (t->parent == father));
+			RCU_INIT_POINTER(t->real_parent, reaper);
+			BUG_ON((!t->ptrace) != (rcu_access_pointer(t->parent) == father));
 			if (likely(!t->ptrace))
 				t->parent = t->real_parent;
 			if (t->pdeath_signal)
-- 
2.17.1

