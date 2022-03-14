Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC13C433F5
	for <rcu@archiver.kernel.org>; Mon, 14 Mar 2022 20:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiCNUSs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbiCNUSr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Mar 2022 16:18:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC35340C0
        for <rcu@vger.kernel.org>; Mon, 14 Mar 2022 13:17:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l20so29212118lfg.12
        for <rcu@vger.kernel.org>; Mon, 14 Mar 2022 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llWQpUugVIez20+golvS85g3cCvwC31DD0QwwK3Qx28=;
        b=DkZTTgDSXMSP8ycn8g7aDVO7MMxXsfSAxTIeaYTtorLLanSxli2WnOx6QwAcxXK3NF
         DjAQXDoP0lfFrOsJ6MD3CHiG2wbXFclPK0VJxS+dFWsr6OJd6vtkNet+rH6UzNggFVPE
         KpMHTjuGBhE7vD1SxpFm2Q6UBy+aKunBko6AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llWQpUugVIez20+golvS85g3cCvwC31DD0QwwK3Qx28=;
        b=sakyTjygh/G1XENAHNQdcfrEWnskjv0wBnwNnHrWzr9YOl7B64DqjQxp/wgPaXDz+w
         GvICS9NogWVqUO3dtlkQ8I7aMhMELnhZJsFzIEQYUDxM95SgZvGtcYDfWh9c/7Amdg3m
         EsNizLHqSvmQDwV+QM+hF++5Yo4nNOnKu9jpEcdhCMrQdcqXtc463l2t2FjkUBZcFlX3
         cssjctD6dS0liDH4VvULbfJ11Nqs+8LGcYeAjC+ZWg0J2V/6UD6OSD0BMHcvcoO92ATt
         l1Mpz5DLYIhTRQ/ppzOP4vTfEpxuoSWzWDqvXz4JqQe+QYq5ls+d6V0YirrVNzCB91cR
         3Q7g==
X-Gm-Message-State: AOAM5308gi1xCtbUZ7UKVceRpeMaCtoGlC51xqjiQ2va2ZNkBHmy9TxH
        Ybw/HDn+MhpiaWnZCQwb3cr6wW3LvtMubK35
X-Google-Smtp-Source: ABdhPJyTkLAU+z8xsVmkf+j6GUicQMdylAOX4fDVULkIAKkp2SSntFeRUP7iTNOZAz+ljR/82quLBg==
X-Received: by 2002:a05:6512:2393:b0:448:39cd:4c59 with SMTP id c19-20020a056512239300b0044839cd4c59mr14561359lfv.580.1647289050933;
        Mon, 14 Mar 2022 13:17:30 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m10-20020a2e97ca000000b00247e2d9a22esm4151742ljj.32.2022.03.14.13.17.29
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 13:17:29 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id c15so7022961ljr.9
        for <rcu@vger.kernel.org>; Mon, 14 Mar 2022 13:17:29 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr14977824lja.443.1647289049378; Mon, 14
 Mar 2022 13:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1> <20220314154857.GA2637810@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220314154857.GA2637810@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Mar 2022 13:17:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEVLfoypyZHwdLjh3vX_BSJO1JJBjha2XgcghSX=sdgw@mail.gmail.com>
Message-ID: <CAHk-=wjEVLfoypyZHwdLjh3vX_BSJO1JJBjha2XgcghSX=sdgw@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.18
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rcu <rcu@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 14, 2022 at 8:49 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> OK, I was apparently unable to distinguish v5.17-rc8 from v5.18 yesterday
> evening.  :-/
>
> I will resent both pull requests next week, and please accept my apologies
> for the bother.

"resent" and "resend" are very different ;)

Anyway, no bother - I just assumed this meant that you sent your pull
request for 5.18 early. Which is very much ok, and no bother at all.
In fact, if things are ready, early pull requests are generally good
things.

But since you resent them, I'll just archive this email (and the LKMM
one), and am now expecting a new set of pull requests that you don't
hate that much later..

               Linus
