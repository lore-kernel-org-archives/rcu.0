Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D7BC2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E394D2222C
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IE9deQQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgKDNhm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:37:42 -0500
Received: from z5.mailgun.us ([104.130.96.5]:45369 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKDNhm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 08:37:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604497061; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=l+WhZZ4F3dbTvWKIZavLAYwgyG0TsaQW6rFgBMp6jAw=; b=IE9deQQKMTE7Cov3blFdilB7K23vrqu7853TvU8ulYg4FSOYxYOGS+WvgNkSEe4VmZrfSE3r
 ZRrUXiZF+ukNjNPolNZeLRQ7HUbh09FhKP1wUpQQyUxPckUJlhCipM2MPGsEmNxQ7ZdRCRxF
 /3GibMRXDT3DpMmlmRNiVQKr+BE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa2aea41f154ab1e4dbc4ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 13:37:40
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0920C433C6; Wed,  4 Nov 2020 13:37:40 +0000 (UTC)
Received: from [192.168.0.103] (unknown [124.123.167.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B5DDC433CB;
        Wed,  4 Nov 2020 13:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B5DDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v9 2/7] rcu/segcblist: Add counters to segcblist
 datastructure
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-3-joel@joelfernandes.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <1348227f-2a23-8bd5-2565-e5d7e65d5895@codeaurora.org>
Date:   Wed, 4 Nov 2020 19:07:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103142603.1302207-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/3/2020 7:55 PM, Joel Fernandes (Google) wrote:
> Add counting of segment lengths of segmented callback list.
> 
> This will be useful for a number of things such as knowing how big the
> ready-to-execute segment have gotten. The immediate benefit is ability
> to trace how the callbacks in the segmented callback list change.
> 
> Also this patch remove hacks related to using donecbs's ->len field as a
> temporary variable to save the segmented callback list's length. This cannot be
> done anymore and is not needed.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>

>   include/linux/rcu_segcblist.h |   1 +
>   kernel/rcu/rcu_segcblist.c    | 120 ++++++++++++++++++++++------------
>   kernel/rcu/rcu_segcblist.h    |   2 -
>   3 files changed, 79 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index b36afe7b22c9..6c01f09a6456 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -72,6 +72,7 @@ struct rcu_segcblist {
>   #else
>   	long len;
>   #endif
> +	long seglen[RCU_CBLIST_NSEGS];
>   	u8 enabled;
>   	u8 offloaded;
>   };
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index bb246d8c6ef1..357c19bbcb00 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -7,10 +7,11 @@
>    * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
>    */
>   
> -#include <linux/types.h>
> -#include <linux/kernel.h>
> +#include <linux/cpu.h>
>   #include <linux/interrupt.h>
> +#include <linux/kernel.h>
>   #include <linux/rcupdate.h>
> +#include <linux/types.h>
>   
>   #include "rcu_segcblist.h"
>   
> @@ -88,6 +89,46 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>   #endif
>   }
>   
> +/* Get the length of a segment of the rcu_segcblist structure. */
> +static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> +{
> +	return READ_ONCE(rsclp->seglen[seg]);
> +}
> +
> +/* Set the length of a segment of the rcu_segcblist structure. */
> +static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> +{
> +	WRITE_ONCE(rsclp->seglen[seg], v);
> +}
> +
> +/* Return number of callbacks in a segment of the segmented callback list. */
> +static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> +{
> +	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
> +}
> +
> +/* Move from's segment length to to's segment. */
> +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> +{
> +	long len;
> +
> +	if (from == to)
> +		return;
> +
> +	len = rcu_segcblist_get_seglen(rsclp, from);
> +	if (!len)
> +		return;
> +
> +	rcu_segcblist_add_seglen(rsclp, to, len);
> +	rcu_segcblist_set_seglen(rsclp, from, 0);
> +}
> +
> +/* Increment segment's length. */
> +static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
> +{
> +	rcu_segcblist_add_seglen(rsclp, seg, 1);
> +}
> +
>   /*
>    * Increase the numeric length of an rcu_segcblist structure by the
>    * specified amount, which can be negative.  This can cause the ->len
> @@ -119,26 +160,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
>   	rcu_segcblist_add_len(rsclp, 1);
>   }
>   
> -/*
> - * Exchange the numeric length of the specified rcu_segcblist structure
> - * with the specified value.  This can cause the ->len field to disagree
> - * with the actual number of callbacks on the structure.  This exchange is
> - * fully ordered with respect to the callers accesses both before and after.
> - */
> -static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> -{
> -#ifdef CONFIG_RCU_NOCB_CPU
> -	return atomic_long_xchg(&rsclp->len, v);
> -#else
> -	long ret = rsclp->len;
> -
> -	smp_mb(); /* Up to the caller! */
> -	WRITE_ONCE(rsclp->len, v);
> -	smp_mb(); /* Up to the caller! */
> -	return ret;
> -#endif
> -}
> -
>   /*
>    * Initialize an rcu_segcblist structure.
>    */
> @@ -149,8 +170,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
>   	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
>   	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
>   	rsclp->head = NULL;
> -	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
>   		rsclp->tails[i] = &rsclp->head;
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}
>   	rcu_segcblist_set_len(rsclp, 0);
>   	rsclp->enabled = 1;
>   }
> @@ -246,6 +269,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>   {
>   	rcu_segcblist_inc_len(rsclp);
>   	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
> +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
>   	rhp->next = NULL;
>   	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
>   	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> @@ -274,27 +298,13 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
>   	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
>   		if (rsclp->tails[i] != rsclp->tails[i - 1])
>   			break;
> +	rcu_segcblist_inc_seglen(rsclp, i);
>   	WRITE_ONCE(*rsclp->tails[i], rhp);
>   	for (; i <= RCU_NEXT_TAIL; i++)
>   		WRITE_ONCE(rsclp->tails[i], &rhp->next);
>   	return true;
>   }
>   
> -/*
> - * Extract only the counts from the specified rcu_segcblist structure,
> - * and place them in the specified rcu_cblist structure.  This function
> - * supports both callback orphaning and invocation, hence the separation
> - * of counts and callbacks.  (Callbacks ready for invocation must be
> - * orphaned and adopted separately from pending callbacks, but counts
> - * apply to all callbacks.  Locking must be used to make sure that
> - * both orphaned-callbacks lists are consistent.)
> - */
> -void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
> -					       struct rcu_cblist *rclp)
> -{
> -	rclp->len = rcu_segcblist_xchg_len(rsclp, 0);
> -}
> -
>   /*
>    * Extract only those callbacks ready to be invoked from the specified
>    * rcu_segcblist structure and place them in the specified rcu_cblist
> @@ -307,6 +317,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>   
>   	if (!rcu_segcblist_ready_cbs(rsclp))
>   		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
>   	*rclp->tail = rsclp->head;
>   	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
>   	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> @@ -314,6 +325,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>   	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
>   		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
>   			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
> +	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>   }
>   
>   /*
> @@ -330,11 +342,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>   
>   	if (!rcu_segcblist_pend_cbs(rsclp))
>   		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
>   	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
>   	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
>   	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> -	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
>   		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}
>   }
>   
>   /*
> @@ -345,7 +362,6 @@ void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
>   				struct rcu_cblist *rclp)
>   {
>   	rcu_segcblist_add_len(rsclp, rclp->len);
> -	rclp->len = 0;
>   }
>   
>   /*
> @@ -359,6 +375,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
>   
>   	if (!rclp->head)
>   		return; /* No callbacks to move. */
> +	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
>   	*rclp->tail = rsclp->head;
>   	WRITE_ONCE(rsclp->head, rclp->head);
>   	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
> @@ -379,6 +396,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
>   {
>   	if (!rclp->head)
>   		return; /* Nothing to do. */
> +
> +	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
>   	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
>   	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
>   }
> @@ -403,6 +422,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>   		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
>   			break;
>   		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
>   	}
>   
>   	/* If no callbacks moved, nothing more need be done. */
> @@ -423,6 +443,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>   		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
>   			break;  /* No more callbacks. */
>   		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, j);
>   		rsclp->gp_seq[j] = rsclp->gp_seq[i];
>   	}
>   }
> @@ -444,7 +465,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>    */
>   bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>   {
> -	int i;
> +	int i, j;
>   
>   	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
>   	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> @@ -487,6 +508,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>   	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
>   		return false;
>   
> +	/* Accounting: everything below i is about to get merged into i. */
> +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> +		rcu_segcblist_move_seglen(rsclp, j, i);
> +
>   	/*
>   	 * Merge all later callbacks, including newly arrived callbacks,
>   	 * into the segment located by the for-loop above.  Assign "seq"
> @@ -514,13 +539,24 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>   	struct rcu_cblist donecbs;
>   	struct rcu_cblist pendcbs;
>   
> +	lockdep_assert_cpus_held();
> +
>   	rcu_cblist_init(&donecbs);
>   	rcu_cblist_init(&pendcbs);
> -	rcu_segcblist_extract_count(src_rsclp, &donecbs);
> +
>   	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
>   	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> +
> +	/*
> +	 * No need smp_mb() before setting length to 0, because CPU hotplug
> +	 * lock excludes rcu_barrier.
> +	 */
> +	rcu_segcblist_set_len(src_rsclp, 0);
> +
>   	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> +	rcu_segcblist_insert_count(dst_rsclp, &pendcbs);
>   	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
>   	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> +
>   	rcu_segcblist_init(src_rsclp);
>   }
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 1d2d61406463..cd35c9faaf51 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -89,8 +89,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>   			   struct rcu_head *rhp);
>   bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
>   			   struct rcu_head *rhp);
> -void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
> -				 struct rcu_cblist *rclp);
>   void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>   				    struct rcu_cblist *rclp);
>   void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
