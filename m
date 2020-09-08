Return-Path: <SRS0=z7K1=CR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E443BC43461
	for <rcu@archiver.kernel.org>; Tue,  8 Sep 2020 18:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BEB2078E
	for <rcu@archiver.kernel.org>; Tue,  8 Sep 2020 18:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="CHlchrub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbgIHSTx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgIHSQO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Sep 2020 14:16:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F901C061573
        for <rcu@vger.kernel.org>; Tue,  8 Sep 2020 11:16:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so208047wrr.4
        for <rcu@vger.kernel.org>; Tue, 08 Sep 2020 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=N8TtjF7op38Ipqdy8ruAYnD1+q0nv/cwpgUpeRIlsl4=;
        b=CHlchrubAIs2/TXBCYJlGSccVe9N3WapZsFSCeBRMAT5eqVJ1Sto6lGc1Qm4aHLvKZ
         77fyP2eOqYSrVurkxn6cJ1AGLN6eCJ8cSO+zNkLYiiUhwyHLQZHhgEVOMvYdGm8G0ZMC
         BI4fdF9wJLg03IznD6Fq0zC8BqWjXhU8LP+yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=N8TtjF7op38Ipqdy8ruAYnD1+q0nv/cwpgUpeRIlsl4=;
        b=XriXgYvQQpkxQv773kImzhaZwVwUVfTH+0Jvm8lfhViOnACRof9a1CDJRI87rSiMdN
         +J6Z1k+oSxG7fflgozvjPEVMSSvECpttCTCOpPUtNgDdReH97ts/180uPp5XTTHkAP8V
         AvmZybL0K90qadZ8cU5ehCsxXybEwpKYb2VNbOpdHogzjA7rYBoSVLjjb34P5w0rFOzT
         DATqHG/0z5F24sQflOFYMRB/wk0Eq6qge+W1ikKMwXoAtUTmp3uvM+BOCb2Y4CUV5Lvx
         FNVo7TrAV0TXLXMYJruhD27DlvJ0m+tsRT6d3cQta5B5/D5pKuGnhjnsWMWcQ5sbAa59
         PGqQ==
X-Gm-Message-State: AOAM531xzVdItc0RfzN+L927jT3lerFdyf3UX3vcEAeI0cHZQ4enydXP
        a3/ckOQyXS3w0FvltPfRbDjkPg==
X-Google-Smtp-Source: ABdhPJzbN47yDdBOPE080tCOdGXZ05JHWTv5GvJlEr+LWJF2CDWB4rLzZDRfY9ynGEmyFVzR+kbsNQ==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr877997wrp.298.1599588960755;
        Tue, 08 Sep 2020 11:16:00 -0700 (PDT)
Received: from localhost ([149.62.205.110])
        by smtp.gmail.com with ESMTPSA id p11sm262199wma.11.2020.09.08.11.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:16:00 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:15:56 +0300
In-Reply-To: <20200908173624.160024-1-kuba@kernel.org>
References: <20200908090049.7e528e7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <20200908173624.160024-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] rcu: prevent RCU_LOCKDEP_WARN() from swallowing the condition
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
CC:     netdev@vger.kernel.org, paulmck@kernel.org, joel@joelfernandes.org,
        josh@joshtriplett.org, peterz@infradead.org,
        christian.brauner@ubuntu.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        roopa@nvidia.com
From:   nikolay@cumulusnetworks.com
Message-ID: <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8 September 2020 20:36:24 EEST, Jakub Kicinski <kuba@kernel=2Eorg> wrote=
:
>We run into a unused variable warning in bridge code when
>variable is only used inside the condition of
>rcu_dereference_protected()=2E
>
> #define mlock_dereference(X, br) \
>	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
>
>Since on builds with CONFIG_PROVE_RCU=3Dn rcu_dereference_protected()
>compiles to nothing the compiler doesn't see the variable use=2E
>
>Prevent the warning by adding the condition as dead code=2E
>We need to un-hide the declaration of lockdep_tasklist_lock_is_held()
>and fix a bug the crept into a net/sched header=2E
>
>Signed-off-by: Jakub Kicinski <kuba@kernel=2Eorg>
>---
> include/linux/rcupdate=2Eh   | 2 +-
> include/linux/sched/task=2Eh | 2 --
> include/net/sch_generic=2Eh  | 2 +-
> 3 files changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/rcupdate=2Eh b/include/linux/rcupdate=2Eh
>index d15d46db61f7=2E=2Ecf3d3ba3f3e4 100644
>--- a/include/linux/rcupdate=2Eh
>+++ b/include/linux/rcupdate=2Eh
>@@ -320,7 +320,7 @@ static inline void rcu_preempt_sleep_check(void) {
>}
>=20
> #else /* #ifdef CONFIG_PROVE_RCU */
>=20
>-#define RCU_LOCKDEP_WARN(c, s) do { } while (0)
>+#define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
> #define rcu_sleep_check() do { } while (0)
>=20
> #endif /* #else #ifdef CONFIG_PROVE_RCU */
>diff --git a/include/linux/sched/task=2Eh b/include/linux/sched/task=2Eh
>index a98965007eef=2E=2E9f943c391df9 100644
>--- a/include/linux/sched/task=2Eh
>+++ b/include/linux/sched/task=2Eh
>@@ -47,9 +47,7 @@ extern spinlock_t mmlist_lock;
> extern union thread_union init_thread_union;
> extern struct task_struct init_task;
>=20
>-#ifdef CONFIG_PROVE_RCU
> extern int lockdep_tasklist_lock_is_held(void);
>-#endif /* #ifdef CONFIG_PROVE_RCU */
>=20
> extern asmlinkage void schedule_tail(struct task_struct *prev);
> extern void init_idle(struct task_struct *idle, int cpu);
>diff --git a/include/net/sch_generic=2Eh b/include/net/sch_generic=2Eh
>index d60e7c39d60c=2E=2Eeb68cc6e4e79 100644
>--- a/include/net/sch_generic=2Eh
>+++ b/include/net/sch_generic=2Eh
>@@ -443,7 +443,7 @@ static inline bool
>lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
> 	return lockdep_is_held(&tp->lock);
> }
> #else
>-static inline bool lockdep_tcf_chain_is_locked(struct tcf_block
>*chain)
>+static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain
>*chain)
> {
> 	return true;
> }

Ah, you want to solve it for all=2E :)=20
Looks and sounds good to me,=20
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom>

