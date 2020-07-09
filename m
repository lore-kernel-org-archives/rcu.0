Return-Path: <SRS0=ITGo=AU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C107C433DF
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 17:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BD92077D
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 17:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AToluhOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGIRG0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGIRG0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Jul 2020 13:06:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABDC08C5CE;
        Thu,  9 Jul 2020 10:06:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so1240232pgc.5;
        Thu, 09 Jul 2020 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHcclfYYBKIHnSq5Q0GT/hqn8J1lxzpRSKLQ942O9vk=;
        b=AToluhOGiT9776vm4oXRGg9NB5hy0sUFBt2Ho/l3PSRaKfHAcwd1/lTaKYNUn1x4nv
         LRe5AomMs20Vjo7IMeYcsmK4kZMbmqB6PRxBHfJa/nNE/JcixTLSc2S5FQRJQbi4CxVN
         bZ8a64mRM+VxdezDuASQX1rFQa2ReYdWF6XJXqkMTGS64cD9TuU3OStcl9p0aMIikHSz
         /N1RyLDHIwPGj4Mq+vxD+XZVSgU+ZpWCFXKVtgxcz6vCwN2yTgb84x9ytJLliZk8qnEA
         pzvHwwDTKRh7PRaAS6CiCMj4sczp4smqCs6b50IiG/FRhrCjHzYvEczZiuDQxR8DxGEI
         9OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHcclfYYBKIHnSq5Q0GT/hqn8J1lxzpRSKLQ942O9vk=;
        b=rjbCntYVSMMA6y2NWMpdCkce3XdhjkZMGgSDBD0cQkdJcYGNY2rT2QVtPVF2FAUSSp
         sK36YzDxAz0IutZlWNCApdugBmT7sQmSEFCIexOX56TQojgetISO46ECx7Bb132ZSyco
         N2CgfRN8gJCN5JCBby8xfJVNgnj/ZotcqlrYkQ16kpv57BA28sMfma8on+1bc/Ws36T5
         nU2ABQYkjaOLrZqiQvgSzYk48BIBZil6bTaNAzdyHAeLs5xSjbFJsfpebJxexf1l5XbO
         bNSPglsuHRhfxSUtRXMdTpPVecogBlNfhebqS4jbo8xJ6kWnSy9GEUjnSyChlf6napkA
         2AqQ==
X-Gm-Message-State: AOAM532Ik+CtWBCUBcd1t5gE5UJifAoE8bsyV+B4HOTFHZ4kBjDPnQGx
        d6SIprP29nX9A90PpnGVgQ==
X-Google-Smtp-Source: ABdhPJx65fFMEVa6K8tlsWpON7il/xJthSo47Q9EJ2xaggH3GjZ3MrwYEtdqUiR2HcvlZy08931/Iw==
X-Received: by 2002:a63:5b63:: with SMTP id l35mr53811605pgm.34.1594314385452;
        Thu, 09 Jul 2020 10:06:25 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:cfe:de9d:4919:edd3:5dbd:ffec])
        by smtp.gmail.com with ESMTPSA id i13sm3229973pjd.33.2020.07.09.10.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jul 2020 10:06:24 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 9 Jul 2020 22:36:18 +0530
To:     joel@joelfernandes.org
Cc:     madhuparnabhowmik10@gmail.com, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, frextrite@gmail.com
Subject: Re: [PATCH] rculist : Introduce list/hlist_for_each_entry_srcu()
 macros
Message-ID: <20200709170617.GA19062@madhuparna-HP-Notebook>
References: <20200703140828.7016-1-madhuparnabhowmik10@gmail.com>
 <D24A0BBD-9A1A-4480-B36A-691C3AD1ADD5@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D24A0BBD-9A1A-4480-B36A-691C3AD1ADD5@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 08, 2020 at 08:33:49AM -0400, joel@joelfernandes.org wrote:
> 
> 
> On July 3, 2020 10:08:28 AM EDT, madhuparnabhowmik10@gmail.com wrote:
> >From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> >list/hlist_for_each_entry_rcu() provides an optional cond argument
> >to specify the lock held in the updater side.
> >However for SRCU read side, not providing the cond argument results
> >into false positive as whether srcu_read_lock is held or not is not
> >checked implicitly. Therefore, on read side the lockdep expression
> >srcu_read_lock_held(srcu struct) can solve this issue.
> >
> >However, the function still fails to check the cases where srcu
> >protected list is traversed with rcu_read_lock() instead of
> >srcu_read_lock(). Therefore, to remove the false negative,
> >this patch introduces two new list traversal primitives :
> >list_for_each_entry_srcu() and hlist_for_each_entry_srcu().
> >
> >Both of the functions have non-optional cond argument
> >as it is required for both read and update side, and simply checks
> >if the cond is true.
> 
> Looks ok to me. Could you update the comment below to also clarify that in regular read side usage, the traversal can be done by also passing the expression srcu_read_lock_held which is also a lockdep expression.
> 
> Could you post the user-patches along with it? That gives more context to reviewers.
>
Thank you for reviewing the patch, I will make the changes suggested and
send the patch along with the user patches.

Regards,
Madhuparna

> Thanks!
> 
> - Joel
> 
> 
> >
> >Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >---
> > include/linux/rculist.h | 44 +++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 44 insertions(+)
> >
> >diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> >index df587d181844..04a7e5791c39 100644
> >--- a/include/linux/rculist.h
> >+++ b/include/linux/rculist.h
> >@@ -63,9 +63,17 @@ static inline void INIT_LIST_HEAD_RCU(struct
> >list_head *list)
> > 	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
> > 			 "RCU-list traversed in non-reader section!");	\
> > 	})
> >+
> >+#define __list_check_srcu(cond)					 \
> >+	({								 \
> >+	RCU_LOCKDEP_WARN(!(cond),					 \
> >+		"RCU-list traversed without holding the required lock!");\
> >+	})
> > #else
> > #define __list_check_rcu(dummy, cond, extra...)				\
> > 	({ check_arg_count_one(extra); })
> >+
> >+#define __list_check_srcu(cond)
> > #endif
> > 
> > /*
> >@@ -383,6 +391,23 @@ static inline void
> >list_splice_tail_init_rcu(struct list_head *list,
> > 		&pos->member != (head);					\
> > 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
> > 
> >+/**
> >+ * list_for_each_entry_srcu	-	iterate over rcu list of given type
> >+ * @pos:	the type * to use as a loop cursor.
> >+ * @head:	the head for your list.
> >+ * @member:	the name of the list_head within the struct.
> >+ * @cond:	lockdep expression for the lock required to traverse the
> >list.
> >+ *
> >+ * This list-traversal primitive may safely run concurrently with
> >+ * the _rcu list-mutation primitives such as list_add_rcu()
> >+ * as long as the traversal is guarded by srcu_read_lock().
> >+ */
> >+#define list_for_each_entry_srcu(pos, head, member, cond)		\
> >+	for (__list_check_srcu(cond),					\
> >+	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
> >+		&pos->member != (head);					\
> >+		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
> >+
> > /**
> >  * list_entry_lockless - get the struct for this entry
> >  * @ptr:        the &struct list_head pointer.
> >@@ -681,6 +706,25 @@ static inline void hlist_add_behind_rcu(struct
> >hlist_node *n,
> > 		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
> > 			&(pos)->member)), typeof(*(pos)), member))
> > 
> >+/**
> >+ * hlist_for_each_entry_srcu - iterate over rcu list of given type
> >+ * @pos:	the type * to use as a loop cursor.
> >+ * @head:	the head for your list.
> >+ * @member:	the name of the hlist_node within the struct.
> >+ * @cond:	lockdep expression for the lock required to traverse the
> >list.
> >+ *
> >+ * This list-traversal primitive may safely run concurrently with
> >+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> >+ * as long as the traversal is guarded by srcu_read_lock().
> >+ */
> >+#define hlist_for_each_entry_srcu(pos, head, member, cond)		\
> >+	for (__list_check_srcu(cond),					\
> >+	     pos =
> >hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
> >+			typeof(*(pos)), member);			\
> >+		pos;							\
> >+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
> >+			&(pos)->member)), typeof(*(pos)), member))
> >+
> > /**
> >* hlist_for_each_entry_rcu_notrace - iterate over rcu list of given
> >type (for tracing)
> >  * @pos:	the type * to use as a loop cursor.
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
