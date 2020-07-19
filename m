Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA542C433E0
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7112020691
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 21:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ArOEP/Bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgGSVFq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:05:46 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:55679 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGSVFp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 17:05:45 -0400
Date:   Sun, 19 Jul 2020 21:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595192743;
        bh=AEf/lKVcafYbJAEyj9uCe9GegX+iiFz2trUb0jWkN3M=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ArOEP/BxVldY3h3OkP+A5Qs/DQlPr1k6qa56jgaMrcOLw91RV+qStWCrPVK4yH6tu
         zgC9Ni8LZCYD2m6wsEJAcOyEkOWH1KmKlES5FiicdG49qo2myX6i+KR1jVWj4lt1tV
         Kkm/BmoE7Mmdk30YVw6FqXN90vzwFy8E/HZfv4l0=
To:     paulmck@kernel.org, josh@joshtriplett.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     rcu@vger.kernel.org, Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH 1/2] rcu: Correct kernel-doc inconsistency
Message-ID: <20200719210533.152080-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Silence documentation build warnings by correcting kernel-doc comment
for rcu_nmi_enter function and kfree_rcu_cpu struct.

./kernel/rcu/tree.c:969: warning: Excess function parameter 'irq' descripti=
on in 'rcu_nmi_enter'
./kernel/rcu/tree.c:3024: warning: Function parameter or member 'count' not=
 described in 'kfree_rcu_cpu'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6c6569e0586c..f38a51b96027 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -954,7 +954,6 @@ void __rcu_irq_enter_check_tick(void)
=20
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
- * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -3004,6 +3003,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: number of objects for which GP is not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3019,7 +3019,6 @@ struct kfree_rcu_cpu {
 =09struct delayed_work monitor_work;
 =09bool monitor_todo;
 =09bool initialized;
-=09// Number of objects for which GP not started
 =09int count;
 };
=20
--=20
2.26.2


