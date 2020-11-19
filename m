Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59F0C56201
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 08:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6467F246BB
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 08:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Gu3r2wG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgKSIPG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:15:06 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:27894 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgKSIPG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 03:15:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605773705; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=VXp5SnSN9uEFFUl9UwtEc5ed7pOgL8l/fp0l4w8Ivb4=; b=Gu3r2wG5EBwY051Kg+B3Qk+kVnpz2lpR8XCqJjbuEypjfNj1ZdPHf7OhxfpDX1+wamtA43wM
 ll0ymeD0Pio8SzaZvbHAbCsdBeaEu9tdgDkEC7H1qmF2sb2T9eibG0g7Ic8UiI1XC2gJowLE
 lJI5nUaN1WWX8tq0wm0i9ztxaSI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fb62983e9b7088622072653 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Nov 2020 08:14:59
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59DCCC43463; Thu, 19 Nov 2020 08:14:58 +0000 (UTC)
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03377C433ED;
        Thu, 19 Nov 2020 08:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03377C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH RFC tip/core/rcu 1/5] srcu: Make Tiny SRCU use multi-bit
 grace-period counter
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, rcu@vger.kernel.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-1-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <72dffe43-b746-6d75-1f6a-9936d709be63@codeaurora.org>
Date:   Thu, 19 Nov 2020 13:44:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117004052.14758-1-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a polling interface for SRCU grace periods.  This
> polling needs to distinguish between an SRCU instance being idle on the
> one hand or in the middle of a grace period on the other.  This commit
> therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
> a defacto boolean to a free-running counter, using the bottom bit to
> indicate that a grace period is in progress.  The second-from-bottom
> bit is thus used as the index returned by srcu_read_lock().
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   include/linux/srcutiny.h | 4 ++--
>   kernel/rcu/srcutiny.c    | 5 +++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 5a5a194..fed4a2d 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -15,7 +15,7 @@
>   
>   struct srcu_struct {
>   	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
> -	short srcu_idx;			/* Current reader array element. */
> +	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
>   	u8 srcu_gp_running;		/* GP workqueue running? */
>   	u8 srcu_gp_waiting;		/* GP waiting for readers? */
>   	struct swait_queue_head srcu_wq;
> @@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
>   {
>   	int idx;
>   
> -	idx = READ_ONCE(ssp->srcu_idx);
> +	idx = (READ_ONCE(ssp->srcu_idx) & 0x2) / 2;

Should we use bit 0x2 of (READ_ONCE(ssp->srcu_idx) + 1) , if GP 
(srcu_drive_gp()) is in progress? Or am I missing something here?

idx = ((READ_ONCE(ssp->srcu_idx) +1) & 0x2) / 2;

Also, any reason for using divison instead of shift; something to
do with 16-bit srcu_idx which I am missing here?

Thanks
Neeraj

>   	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
>   	return idx;
>   }
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 6208c1d..5598cf6 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
>   	ssp->srcu_cb_head = NULL;
>   	ssp->srcu_cb_tail = &ssp->srcu_cb_head;
>   	local_irq_enable();
> -	idx = ssp->srcu_idx;
> -	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> +	idx = (ssp->srcu_idx & 0x2) / 2;
> +	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>   	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
>   	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
>   	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
> +	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>   
>   	/* Invoke the callbacks we removed above. */
>   	while (lh) {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
