Return-Path: <SRS0=l9jG=3S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ADFC2D0DB
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C73D20716
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 16:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueJ6r87y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA2QCO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:02:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33199 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QCN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jan 2020 11:02:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so9067226pgk.0;
        Wed, 29 Jan 2020 08:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k8mHbmQQsrXwIuxRQsm7SslFnT6vNFl5PlAX5KpkYSQ=;
        b=ueJ6r87yt1XMC7LlrQYQKxOSAAX09m036BtYkdjlMPVSTIc9L5e/GrpfSdgYh7yz5N
         dHpTkWQFk445H92oj8dND7X+f8wPxXHtnCdMO8vXgpbBEfQR5QMXPI+sTRNDCWL6K5zJ
         0dRGGepvfo0htl11QbrfHI72cNfdlqablwjouQsP34mO6kASH9MmI923RLjPDcQY/KtP
         6KPayDh5Opilunyh8ZF5NLS9mBSH+Uc7Lg/7plRx94f+jZHgNYbY7cAwosX+qX3pR9Ii
         z4YtQn+zVsq5eTaS87NXNR6U8DV6jAWfw7r6R4T74Gr8nc0WEAZwMGQJ6JTM7RjQQ/0F
         V1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8mHbmQQsrXwIuxRQsm7SslFnT6vNFl5PlAX5KpkYSQ=;
        b=PUJlKp2HM1ip50aSC/sUpdwbbmtVFHe24ovuxWMqsZOx554DhbfcAkcA6iPIr1TOhn
         k12jrzNiSpSBHKOavaAoZz0oXN/TOsq1G80CcMDlo+tnPVipaRdZqtSxYFc2sFw4y+Jb
         gLgakZe+ZVsxdbjrnrQe90NdkQb2zD5LNCl8vHVOmcVKGoF18Fv5CiWK1ByU32iXs+nI
         vm89Ykn7WJNuIgPlI7dPgIgs85nNRaeC+SyNeG8hZs3c1eEioyb29GXn2/yaxcrp21ci
         Q4mwQxyRFYR5i3cXfmsnzA3upAOGt5FVUaw+O3qTQL2qMFIKgtEqGxYTLLxtprqM8NZC
         43nA==
X-Gm-Message-State: APjAAAX+8yzS7oZiZTjFMAODw1a8UcFlRlAyteTt9Vls+mzxegdrowMs
        1xnG/5LmC4OQ7IATPPaEfQ==
X-Google-Smtp-Source: APXvYqzrD+7oSyDpZl9ImkaISh0MgIPrwKGmgL0z/k1vQvBM6d+UcE9172zZWN39NOmWegWjZopjRA==
X-Received: by 2002:aa7:800e:: with SMTP id j14mr275989pfi.174.1580313733106;
        Wed, 29 Jan 2020 08:02:13 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee5:e7da:cc5e:c7d9:2a24:390])
        by smtp.gmail.com with ESMTPSA id z30sm3274298pff.131.2020.01.29.08.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 08:02:12 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Wed, 29 Jan 2020 21:32:04 +0530
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     madhuparnabhowmik10@gmail.com, peterz@infradead.org,
        mingo@kernel.org, christian.brauner@ubuntu.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
Message-ID: <20200129160204.GA15449@madhuparna-HP-Notebook>
References: <20200128172008.22665-1-madhuparnabhowmik10@gmail.com>
 <20200129123046.GA1726@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129123046.GA1726@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 29, 2020 at 01:30:47PM +0100, Oleg Nesterov wrote:
> On 01/28, madhuparnabhowmik10@gmail.com wrote:
> >
> > kernel/exit.c:626:40: warning: incorrect type in assignment
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  kernel/exit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index bcbd59888e67..c5a9d6360440 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -623,8 +623,8 @@ static void forget_original_parent(struct task_struct *father,
> >  	reaper = find_new_reaper(father, reaper);
> >  	list_for_each_entry(p, &father->children, sibling) {
> >  		for_each_thread(p, t) {
> > -			t->real_parent = reaper;
> > -			BUG_ON((!t->ptrace) != (t->parent == father));
> > +			rcu_assign_pointer(t->real_parent, reaper);
> 
> Another case when RCU_INIT_POINTER() makes more sense (although to me it
> too looks confusing). We didn't modify the new parent.
>
Alright, I will resend this patch with RCU_INIT_POINTER().

Thank you,
Madhuparna

> Oleg.
> 
