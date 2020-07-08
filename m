Return-Path: <SRS0=Ut75=AT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F61C433DF
	for <rcu@archiver.kernel.org>; Wed,  8 Jul 2020 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A441320774
	for <rcu@archiver.kernel.org>; Wed,  8 Jul 2020 12:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DRqLZb6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgGHMdz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgGHMdy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Jul 2020 08:33:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F3C08C5DC
        for <rcu@vger.kernel.org>; Wed,  8 Jul 2020 05:33:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e11so41325432qkm.3
        for <rcu@vger.kernel.org>; Wed, 08 Jul 2020 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=a9k7anVARO5a2XjKh+ZNLzlqgc+LtzUHtnvpewyB1Z8=;
        b=DRqLZb6ewBAysZ55gFQdSenqYp72lWdjRsGapaa2heeC47bgvqui0/x65ObyDLbtiP
         2VG/dEd4qgcTEf0W3Y+/ePGQ3pHI1C/afzlWYUFyQL/lHaA7I1M7+g3TpDkeV58G2RAU
         NQJekmf7lMv86oJrZS+akJQBOQDcDhvoVmOJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=a9k7anVARO5a2XjKh+ZNLzlqgc+LtzUHtnvpewyB1Z8=;
        b=QtOiu6eshHO76uCmVwhxB9HH3DT2R+3KkGsIUOFIfU+YvFnj6PnXy0da9jzRz9hnhG
         snJFAyVto56n9IqlYDeytrvLDwvxfUlci07HliB3maRUeUouqb626o2TXARtkMRcAEiV
         fCLXpWQK4RnfaUqNpmjzs4JDJMDtzQlVvBMXJsZZ6hCqyYHFj9jQ2+5BhKuiLh00G4b2
         pNglw3HZUTq67fP6Morpa2eW16NB2PZ8ro+NZTiTblnO9haGLLVNLnxY0zwqaAeM5ISE
         Ckrado83t+TFMwlYdpLbtonlKXnaawSoaMF25POBFmlcY6V8HuO9iSkeWZMt3sZhMvDZ
         5v3Q==
X-Gm-Message-State: AOAM530cEEWcOqufFsS0iAllxyzBgzHeYQaUNVJ3Zgm1nSJvmL2VQvPL
        X9vVAjilX9lWhr87sbWim8nkpA==
X-Google-Smtp-Source: ABdhPJxO0/iKeUOep8yCrb9tA1qJ5XpHSPOncUJMspEAax3PNjskz+MfK1OhikWwvzNHUeBt9LEcWA==
X-Received: by 2002:a05:620a:2f4:: with SMTP id a20mr57833576qko.227.1594211633648;
        Wed, 08 Jul 2020 05:33:53 -0700 (PDT)
Received: from [192.168.1.19] (c-71-62-121-229.hsd1.va.comcast.net. [71.62.121.229])
        by smtp.gmail.com with ESMTPSA id o4sm1759988qtf.92.2020.07.08.05.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 05:33:52 -0700 (PDT)
Date:   Wed, 08 Jul 2020 08:33:49 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20200703140828.7016-1-madhuparnabhowmik10@gmail.com>
References: <20200703140828.7016-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] rculist : Introduce list/hlist_for_each_entry_srcu() macros
To:     madhuparnabhowmik10@gmail.com, paulmck@kernel.org
CC:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
From:   joel@joelfernandes.org
Message-ID: <D24A0BBD-9A1A-4480-B36A-691C3AD1ADD5@joelfernandes.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On July 3, 2020 10:08:28 AM EDT, madhuparnabhowmik10@gmail=2Ecom wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail=2Ecom>
>
>list/hlist_for_each_entry_rcu() provides an optional cond argument
>to specify the lock held in the updater side=2E
>However for SRCU read side, not providing the cond argument results
>into false positive as whether srcu_read_lock is held or not is not
>checked implicitly=2E Therefore, on read side the lockdep expression
>srcu_read_lock_held(srcu struct) can solve this issue=2E
>
>However, the function still fails to check the cases where srcu
>protected list is traversed with rcu_read_lock() instead of
>srcu_read_lock()=2E Therefore, to remove the false negative,
>this patch introduces two new list traversal primitives :
>list_for_each_entry_srcu() and hlist_for_each_entry_srcu()=2E
>
>Both of the functions have non-optional cond argument
>as it is required for both read and update side, and simply checks
>if the cond is true=2E

Looks ok to me=2E Could you update the comment below to also clarify that =
in regular read side usage, the traversal can be done by also passing the e=
xpression srcu_read_lock_held which is also a lockdep expression=2E

Could you post the user-patches along with it? That gives more context to =
reviewers=2E

Thanks!

- Joel


>
>Suggested-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail=2Ecom>
>---
> include/linux/rculist=2Eh | 44 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
>
>diff --git a/include/linux/rculist=2Eh b/include/linux/rculist=2Eh
>index df587d181844=2E=2E04a7e5791c39 100644
>--- a/include/linux/rculist=2Eh
>+++ b/include/linux/rculist=2Eh
>@@ -63,9 +63,17 @@ static inline void INIT_LIST_HEAD_RCU(struct
>list_head *list)
> 	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
> 			 "RCU-list traversed in non-reader section!");	\
> 	})
>+
>+#define __list_check_srcu(cond)					 \
>+	({								 \
>+	RCU_LOCKDEP_WARN(!(cond),					 \
>+		"RCU-list traversed without holding the required lock!");\
>+	})
> #else
> #define __list_check_rcu(dummy, cond, extra=2E=2E=2E)				\
> 	({ check_arg_count_one(extra); })
>+
>+#define __list_check_srcu(cond)
> #endif
>=20
> /*
>@@ -383,6 +391,23 @@ static inline void
>list_splice_tail_init_rcu(struct list_head *list,
> 		&pos->member !=3D (head);					\
> 		pos =3D list_entry_rcu(pos->member=2Enext, typeof(*pos), member))
>=20
>+/**
>+ * list_for_each_entry_srcu	-	iterate over rcu list of given type
>+ * @pos:	the type * to use as a loop cursor=2E
>+ * @head:	the head for your list=2E
>+ * @member:	the name of the list_head within the struct=2E
>+ * @cond:	lockdep expression for the lock required to traverse the
>list=2E
>+ *
>+ * This list-traversal primitive may safely run concurrently with
>+ * the _rcu list-mutation primitives such as list_add_rcu()
>+ * as long as the traversal is guarded by srcu_read_lock()=2E
>+ */
>+#define list_for_each_entry_srcu(pos, head, member, cond)		\
>+	for (__list_check_srcu(cond),					\
>+	     pos =3D list_entry_rcu((head)->next, typeof(*pos), member);	\
>+		&pos->member !=3D (head);					\
>+		pos =3D list_entry_rcu(pos->member=2Enext, typeof(*pos), member))
>+
> /**
>  * list_entry_lockless - get the struct for this entry
>  * @ptr:        the &struct list_head pointer=2E
>@@ -681,6 +706,25 @@ static inline void hlist_add_behind_rcu(struct
>hlist_node *n,
> 		pos =3D hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
> 			&(pos)->member)), typeof(*(pos)), member))
>=20
>+/**
>+ * hlist_for_each_entry_srcu - iterate over rcu list of given type
>+ * @pos:	the type * to use as a loop cursor=2E
>+ * @head:	the head for your list=2E
>+ * @member:	the name of the hlist_node within the struct=2E
>+ * @cond:	lockdep expression for the lock required to traverse the
>list=2E
>+ *
>+ * This list-traversal primitive may safely run concurrently with
>+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
>+ * as long as the traversal is guarded by srcu_read_lock()=2E
>+ */
>+#define hlist_for_each_entry_srcu(pos, head, member, cond)		\
>+	for (__list_check_srcu(cond),					\
>+	     pos =3D
>hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
>+			typeof(*(pos)), member);			\
>+		pos;							\
>+		pos =3D hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
>+			&(pos)->member)), typeof(*(pos)), member))
>+
> /**
>* hlist_for_each_entry_rcu_notrace - iterate over rcu list of given
>type (for tracing)
>  * @pos:	the type * to use as a loop cursor=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
