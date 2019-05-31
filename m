Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FFFC04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3A22CD9
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 15:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lkxz0A16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaPS1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:27 -0400
Received: from m12-17.163.com ([220.181.12.17]:46125 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfEaPS1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 11:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8W7ENsaBm3XqtBuJbq
        Ogw/BG5/TWAFJpxFCQ0nKATDQ=; b=lkxz0A16l6W8nAv0uEx0mvALgZMO7oqxK2
        erZW02oNvBc2Y5TqLgI8wLTEHRDKwo0OI43gGnqshwNXk4KoH5cozaQvbZyJczPm
        UtpwgneoLdqOLqYxinujHIt9jmI9738Wf/pASS9LkHs/Uxrlb+udkl4kX0Zh7fsH
        FYbVyPzeo=
Received: from RHEL7U5GA_Intel64.localdomain (unknown [114.224.173.228])
        by smtp13 (Coremail) with SMTP id EcCowAC3jQQ1RfFcs3leIw--.15589S2;
        Fri, 31 May 2019 23:16:05 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Cc:     rcu@vger.kernel.org, Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH] rcuperf: correct a example of perf_type
Date:   Fri, 31 May 2019 23:15:45 +0800
Message-Id: <1559315745-26570-1-git-send-email-ice_yangxiao@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: EcCowAC3jQQ1RfFcs3leIw--.15589S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW7Wr1Duw1kWF4DAw1kZrb_yoW3KFcEg3
        yxZr1kCw4UZFWj9w17J34fZr1Fqry5uF1DC3sI9rs2qr98ArnIyaykZr95Z3s3Ary8ZFZ8
        J3sIgFyDKr47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjzBT7UUUUU==
X-Originating-IP: [114.224.173.228]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiEA-FXlWBl-ym9wABsr
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_bh type has been removed by commit 620d246065cd("rcuperf:
Remove the "rcu_bh" and "sched" torture types") and only four
types(i.e rcu, srcu, srcud, tasks) are supported currently, so
use srcu as a example.

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 kernel/rcu/rcuperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b..4513807 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -89,7 +89,7 @@
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
+MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, srcu, ...)");
 
 static int nrealreaders;
 static int nrealwriters;
-- 
1.8.3.1


