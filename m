Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A83C6FA82
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiIAWSv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiIAWSm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60EE6BD68
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cb8so281104qtb.0
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8gmIjQiZKF8ycgdoC5ApOjU5UIrSl/T2FqJa/TgPO1I=;
        b=Gi604wSkIg+z78h4KmndskftB7f3p4DdvyE1ILism9RQ5yjlyt75A9qW/StOXfb+fU
         pDy5O0BpNJsnx5TS3sl3liH6GLjNaUxC14UjaYlRGEFOLzqWV+fbldv/OdhgigmrP6sa
         icbHfTEFZStTZC5sYgXRiVe8Q6pqgB7yD7VlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8gmIjQiZKF8ycgdoC5ApOjU5UIrSl/T2FqJa/TgPO1I=;
        b=12Hhz+R3h8ob8vavJwogjKYs01Ac0JXiezGZaWBCtCcd3o56nCFd6AZqdP63/pjyAH
         Bf/BTBjGnYsJ3C8nYz2Ycx36wS/bnQjRC+6IrlYGppLlw2FdPxCjI4c2FUs1eMZSxw7Q
         50thMXi1e3FrhYdImxE3ZDqV3NDtMOUGqU+ogX6Yvbb5HtOj5TFpmDi8utgZBAlCgnft
         ucFG3O3jWh2IVUoqwhZTJUzLzF2qtCJgRigf310ut1aLTJ/PBk3vTB78r6huwMIWpxQh
         xEOVyH1WYCaqlLjD9thFk7yZxirueez81lDvnqIW4ZmWXvN/OEXxTLmcJoPM9so41JCC
         JBbg==
X-Gm-Message-State: ACgBeo3wiUQmjAOYDaptnU3E2tnjNNvz5F2UgGLcaAQCmiMv1B22827P
        CTmtNAZHnebOFAOsjP54j4788Wnbcawu5g==
X-Google-Smtp-Source: AA6agR7ds55vxuronbAkhPvG+w3tnnySL6akfA2/bMY5WcFbqrnJ09MHDN2EqtY3lODJWuD4wHe3wA==
X-Received: by 2002:a05:622a:198b:b0:344:7de5:c516 with SMTP id u11-20020a05622a198b00b003447de5c516mr25834335qtc.7.1662070690604;
        Thu, 01 Sep 2022 15:18:10 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 18/18] fork: Move thread_stack_free_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:20 +0000
Message-Id: <20220901221720.1105021-19-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..08a2298b1f94 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -226,7 +226,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 	struct vm_stack *vm_stack = tsk->stack;
 
 	vm_stack->stack_vm_area = tsk->stack_vm_area;
-	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+	call_rcu_lazy(&vm_stack->rcu, thread_stack_free_rcu);
 }
 
 static int free_vm_stack_cache(unsigned int cpu)
@@ -353,7 +353,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 {
 	struct rcu_head *rh = tsk->stack;
 
-	call_rcu(rh, thread_stack_free_rcu);
+	call_rcu_lazy(rh, thread_stack_free_rcu);
 }
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
@@ -388,7 +388,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 {
 	struct rcu_head *rh = tsk->stack;
 
-	call_rcu(rh, thread_stack_free_rcu);
+	call_rcu_lazy(rh, thread_stack_free_rcu);
 }
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
-- 
2.37.2.789.g6183377224-goog

