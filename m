Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496AC2D0DB
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C09322527
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 17:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADlD8+7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgA0RPE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:15:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43706 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0RPD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jan 2020 12:15:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so230018plq.10;
        Mon, 27 Jan 2020 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pf0S3I7vm4DQQ+rPfSSMEtOHhIykr+8LjXy2v0z/gKo=;
        b=ADlD8+7AhV4HzY3kn3Ja8H1Ycseuc28mPYXZZ/eAyrR62S2ZsMjPrTBwJ+SSgxsiri
         efC5T5z3CfQONzDAsBLjN5sJEgqIRYExedglJcFORykliKnmEAqMBDFBPDFENgjgtums
         HOWaeM626innmksq7XKDCb+WCnXvY6NTUm7bBmdCx42Ie0QIrvueia5inIIGcnpz8uGC
         9qpepbRm32bWkk18JtnCnBBiecFn4dBG0JxAYQPleKK6IrQaQuvZvw1YK+oJEwjkSmty
         9FqQ6NHPzrJQm3ioPl//09wv612aAK5LCsIZOH3T8T2SamMky43OEMz7mcQa6Pu3XBZS
         vwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pf0S3I7vm4DQQ+rPfSSMEtOHhIykr+8LjXy2v0z/gKo=;
        b=KTATdu9h0ybcKUWsGaX8AsZczE+g9F9/UpTHEyfcBkVbpoeNe6cKViFYZmNTniYt3R
         AZmspiM+XlUqQjVMcayXSTLQ+t82rbeBFiok8DVzz+3tkk8okOt4EYQujmwNCbMhNh9L
         7fsL3c6Ym2M66sHzMwYCRYC+xIJFbvPL+9Z1GKn3zjIliJB45Q0LHuMoxAIZxqaHnVk8
         a+bC47RLwdo5qz+WB7X7uiIFyFXqW1SiUCYewSdRbPS5E5REnjeDIabNfGaaRTPwlS3c
         /PcSzFH36+hmFPDEI+0b31GwsS/PNLqSUDH8KTKaXPW593T7I9zddg0sPhnr+LGB+4+a
         ehSA==
X-Gm-Message-State: APjAAAU97S+YERNCExcyz9N5BLxvjoQQ94Nbwpb8kpTCWYjzXnx/Phvt
        dFGMlnvvmtNpVEEJ2ycVBw==
X-Google-Smtp-Source: APXvYqzom7c2cD2NnMvS2GD3/InzZy/uvSEfzngg4NO7xKuRkgQSq7Bn8jFMo9WlIKjnCpC22NXWnQ==
X-Received: by 2002:a17:902:ff11:: with SMTP id f17mr18053213plj.273.1580145302885;
        Mon, 27 Jan 2020 09:15:02 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee2:faa0:c576:b7c8:dab8:85b])
        by smtp.gmail.com with ESMTPSA id k9sm16398869pjo.19.2020.01.27.09.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2020 09:15:02 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Mon, 27 Jan 2020 22:44:53 +0530
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, paulmck@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200127171453.GA4002@madhuparna-HP-Notebook>
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
 <20200127092951.GA1116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127092951.GA1116@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 27, 2020 at 10:29:52AM +0100, Oleg Nesterov wrote:
> On 01/24, madhuparnabhowmik10@gmail.com wrote:
> >
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -918,7 +918,7 @@ struct task_struct {
> >  
> >  	/* Signal handlers: */
> >  	struct signal_struct		*signal;
> > -	struct sighand_struct		*sighand;
> > +	struct sighand_struct __rcu		*sighand;
> >  	sigset_t			blocked;
> >  	sigset_t			real_blocked;
> >  	/* Restored if set_restore_sigmask() was used: */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index bcd46f547db3..9ad8dea93dbb 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
> >  		 * must see ->sighand == NULL.
> >  		 */
> >  		spin_lock_irqsave(&sighand->siglock, *flags);
> > -		if (likely(sighand == tsk->sighand))
> > +		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> >  			break;
> >  		spin_unlock_irqrestore(&sighand->siglock, *flags);
> >  	}
> 
> ACK,
> 
> perhaps you can also cleanup copy_sighand(). rcu_assign_pointer() makes no
> sense, we should either move it down or simply use RCU_INIT_POINTER().
> 
Sure, I will do it and send a patch soon.

Thank you,
Madhuparna

> Oleg.
> 
