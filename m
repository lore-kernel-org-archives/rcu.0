Return-Path: <SRS0=l9jG=3S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63172C2D0DB
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F98206D4
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324696;
	bh=mmpAAS3Ko7PNWRvgxGUh3N56reOH9iOx1rTuUTkDSeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t/Lz53bf0X3gpjJUm3PLdyIqDUF6Qa+LavGioLxA+GM3gRopJXBIw2awX56cKXNig
	 ILamsY6WIHs0wwtl6rpdfD0o4vqlFEWsk17NlTWLbfLQT2CV7hgPAprnC2sHPusVKn
	 03eA3F8nDf5ITloYYlAuRdR3QAF84T0VeDr4Zwas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgA2TEz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:04:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43533 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgA2TEz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jan 2020 14:04:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so513529ljm.10
        for <rcu@vger.kernel.org>; Wed, 29 Jan 2020 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTxpg9MeHuZ64pDGRpya4uIsSc8RC7lqfQ9WDK+ACzQ=;
        b=VVTccVFGNgPYvbLsRcfqqcYoip4MnvcsfWIQA8NIIdUxdwmCyGqn9XF7AM07xfOwgX
         MEUycooZvIV4Xac5E0h6vWMYSJPOC88DqLgsjrdJtzuTHGkmnC7QVZWFJRsMgU7VDSLw
         3I/DU2yFwe0eOkvmXUkCykx98ogMkjIB1Wi4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTxpg9MeHuZ64pDGRpya4uIsSc8RC7lqfQ9WDK+ACzQ=;
        b=PutkXqRzbQmwViygqrUODN23Tmag7cFU2JeeD3mgTXQuh4pbTn7dlYYK8eNMt/MIZw
         Psq4oPc/y3hrvy24Su+qDyRmkvwDLQsWjNZvbu+N5x6knkkcRkPN/pgPY8hX+CvesUGK
         /yGkak2A98Mcq2xZBhFriB6aWCC3mPT/HQQBGFFfx5j2gFGxFQcdbmn+R1O+MQj9ZEXh
         jK3M1OtxM7pJ4+kQ1ogNjyI1BjoAsx+CoHZAxOdpdUP2ltOu71c5T0pe/uPppyPrz955
         LdiEpo2FKpdx8kWyMSj4Xxq81fbNo2EmJanqdPC0VGvRycwoPtqrMS9S7HV7paLNi298
         BTWg==
X-Gm-Message-State: APjAAAVQbhbCgIU4hRiGPgAk4KnRQHQ8t3q1eMNSgBTb/F1IiPiEjFdY
        nQkOmOgxKE9I3MlcempkVx1ICSMPee0=
X-Google-Smtp-Source: APXvYqy5isEMIwPqiFTxcQ7pVioWPwEansU2nFbadeTkJ5tPn6Xeh70GoLUObJzvzzvSKpF06zOu2Q==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr402778ljj.26.1580324692637;
        Wed, 29 Jan 2020 11:04:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h19sm1428258lji.86.2020.01.29.11.04.51
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:04:51 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id z26so413867lfg.13
        for <rcu@vger.kernel.org>; Wed, 29 Jan 2020 11:04:51 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr402695lfm.152.1580324690992;
 Wed, 29 Jan 2020 11:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20200129120206.GA15554@paulmck-ThinkPad-P72>
In-Reply-To: <20200129120206.GA15554@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jan 2020 11:04:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK-nw7PizDEzMgKwQQ6H5NXg0=NTwb6ECDb5PfchFQjQ@mail.gmail.com>
Message-ID: <CAHk-=whK-nw7PizDEzMgKwQQ6H5NXg0=NTwb6ECDb5PfchFQjQ@mail.gmail.com>
Subject: Re: [GIT PULL tip/core/rcu urgent] RCU fix for boot-time splat
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 29, 2020 at 4:02 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello, Ingo,
>
> This pull request contains a single commit that fixes an embarrassing
> bug discussed here:

Ingo, just FYI: I'll just take this pull directly, just to avoid
having the warning in my current tree.

               Linus
