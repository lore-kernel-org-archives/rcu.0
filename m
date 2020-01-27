Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F830C32771
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 09:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663142168B
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 09:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PimJ8yow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgA0JaF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:30:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgA0JaF (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 27 Jan 2020 04:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580117404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDSg7vKNkgUU6jWUsJmpRRkdzJQUOjJxGGK53N4Ir/o=;
        b=PimJ8yow41winEJrvjM0uws+1/oPWOKGIkQbU5oPxmv3ImPyBl5yCcjC3Qhzlv3jiXIArq
        xo6BrKHLVMaJ/kr5Wwfb8LmJpiUu3nrDT5E/qNEET8shRMN+0VqgzXFbykB+dwRhUsBpzZ
        Sn+KR48fVaOn++ib9MB0Sig+zwX9Jkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-U0vpYBDcMXmf1lpVbUuKfQ-1; Mon, 27 Jan 2020 04:29:59 -0500
X-MC-Unique: U0vpYBDcMXmf1lpVbUuKfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE97B8024F1;
        Mon, 27 Jan 2020 09:29:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1CC98704A;
        Mon, 27 Jan 2020 09:29:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 27 Jan 2020 10:29:57 +0100 (CET)
Date:   Mon, 27 Jan 2020 10:29:52 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, paulmck@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200127092951.GA1116@redhat.com>
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 01/24, madhuparnabhowmik10@gmail.com wrote:
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -918,7 +918,7 @@ struct task_struct {
>  
>  	/* Signal handlers: */
>  	struct signal_struct		*signal;
> -	struct sighand_struct		*sighand;
> +	struct sighand_struct __rcu		*sighand;
>  	sigset_t			blocked;
>  	sigset_t			real_blocked;
>  	/* Restored if set_restore_sigmask() was used: */
> diff --git a/kernel/signal.c b/kernel/signal.c
> index bcd46f547db3..9ad8dea93dbb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
>  		 * must see ->sighand == NULL.
>  		 */
>  		spin_lock_irqsave(&sighand->siglock, *flags);
> -		if (likely(sighand == tsk->sighand))
> +		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
>  			break;
>  		spin_unlock_irqrestore(&sighand->siglock, *flags);
>  	}

ACK,

perhaps you can also cleanup copy_sighand(). rcu_assign_pointer() makes no
sense, we should either move it down or simply use RCU_INIT_POINTER().

Oleg.

