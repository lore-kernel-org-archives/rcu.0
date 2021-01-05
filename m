Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B356C433E0
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12AF22CA1
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 16:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAEQaF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbhAEQaE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 11:30:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71EC061793;
        Tue,  5 Jan 2021 08:29:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l11so74029287lfg.0;
        Tue, 05 Jan 2021 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WnKBAJVxaowk5MMmWYJeufW/YY0cNztLm0VvLAro1vA=;
        b=fURn9bOv3P/p4cp2iKgs4R1KSHwzlBISuB5l7hmbgr2m0VDOpMlRldjjH/6B6EpJWf
         +ScfItVpJyAG/ZfT+qHs+aZX7oCU2hMZDUP8L/RM8dYKlfysJXmrrNF6qatk86qC9x6O
         B/dzzTXlw3QYb04hueAf4/MQRTknN/Hth25T7EmPOX7+wRBAVEcoqp/D2kmd8DTasyG9
         MOYMckeOfHOxD33h8B4WpKekj5VqaG2c/Q+qrZdVjaZ6AoFjfeobyHAPMoHihEW22B/m
         RJxK3yYUdYx0mc7xJeaiq8a598qMOcvAl/jn9tES1XSN8KIcW2EDn+G4q1d2jnPg+Xih
         YeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WnKBAJVxaowk5MMmWYJeufW/YY0cNztLm0VvLAro1vA=;
        b=uU2MERb1jLPcpAjRI2ZXBXI1s8+208GIuRch9Tg36oyTWww46RImh9YkpLWzItEyos
         uPLdqGwURrt7IYihxa/suLEGVSyTbYA+3kTBmmOogdRa4A9TOvr7wuyZFyyTH9i0RylB
         YjMjC8ZB1j34XoVInqOzszx9mKxyPR56gdZWFto0GD2PdSQbafeW2IxUA13zUMasVKqa
         PaZsXAyig+9hy3n7HMRs2MDm8qJrOJmT+s/ykY6fYu1t4uqS+SDWK2cbvQn0L7+Xf1t6
         e3pbzsmp9dBqivHzemo41+2Ees2eFhcHNaE4Xk97ieC6XFG/YYHkuKUzDArqmt4g4f0D
         wUqA==
X-Gm-Message-State: AOAM533hQXedcjZT46uKZp0ZY/lMpKWR0JXL3V70phhN4wyCTrVWbbuY
        UTgPqqKbEhJxj97x4GhqV6/ge2Z4fzE=
X-Google-Smtp-Source: ABdhPJy5I4KmUU2D1eK6L9+2fhJOb70aRXLJX7tqprrilhPBBux8G8iXkrdSZolqzRQx+ysFJHNXZA==
X-Received: by 2002:a2e:720c:: with SMTP id n12mr222633ljc.2.1609864162746;
        Tue, 05 Jan 2021 08:29:22 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v63sm14662lfa.89.2021.01.05.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 08:29:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 5 Jan 2021 17:29:19 +0100
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
Message-ID: <20210105162919.GA1800@pc638.lan>
References: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
 <20210105131441.GA2457@pc638.lan>
 <20210105145659.GD17086@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105145659.GD17086@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 05, 2021 at 06:56:59AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 05, 2021 at 02:14:41PM +0100, Uladzislau Rezki wrote:
> > Dear, Lukas.
> > 
> > > Dear Uladzislau,
> > > 
> > > in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
> > > macro"), you have refactored the kfree_rcu macro.
> > > 
> > > Since then, make htmldocs warns:
> > > 
> > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > 'ptr' description in 'kfree_rcu'
> > > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > > 'rhf' description in 'kfree_rcu'
> > > 
> > > As you deleted the two arguments in the macro definition, kerneldoc
> > > cannot resolve the argument names in the macro's kerneldoc
> > > documentation anymore and warns about that.
> > > 
> > > Probably, it is best to just turn the formal kerneldoc references to
> > > the two arguments, which are not used in the macro definition anymore,
> > > simply into two informal references in the documentation.
> > > 
> > Thanks for your suggestion. I am not sure if htmldocs supports something
> > like "__maybe_unused", but tend to say that it does not. See below the
> > patch:
> > 
> > <snip>
> > >From 65ecc7c58810c963c02e0596ce2e5758c54ef55d Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Tue, 5 Jan 2021 13:23:30 +0100
> > Subject: [PATCH] rcu: fix kerneldoc warnings
> > 
> > After refactoring of the kfree_rcu(), it becomes possible to use
> > the macro with one or two arguments. From the other hand, in the
> > description there are two arguments in the macro definition expected.
> > That is why the "htmldocs" emits a warning about it:
> > 
> > <snip>
> > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > 'ptr' description in 'kfree_rcu'
> > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > 'rhf' description in 'kfree_rcu'
> > <snip>
> > 
> > Fix it by converting two parameters into informal references in the
> > macro description.
> > 
> > Fixes: 3d3d9ff077a9 ("rcu: Introduce kfree_rcu() single-argument macro")
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcupdate.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index ebd8dcca4997..e678ce7f5ca2 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -854,8 +854,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> >  
> >  /**
> >   * kfree_rcu() - kfree an object after a grace period.
> > - * @ptr: pointer to kfree for both single- and double-argument invocations.
> > - * @rhf: the name of the struct rcu_head within the type of @ptr,
> > + * ptr: pointer to kfree for both single- and double-argument invocations.
> > + * rhf: the name of the struct rcu_head within the type of ptr,
> >   *       but only for double-argument invocations.
> >   *
> >   * Many rcu callbacks functions just call kfree() on the base structure.
> > -- 
> > 2.20.1
> > <snip>
> > 
> > Paul, does it work for you?
> 
> If it works for the documentation generation, then it works for me.  ;-)
> 
OK. Then we need the patch to be reviewed by the documentation generation :)

Dear, linux-doc folk!

Could you please review the patch that is in question?

Thank you in advance.

--
Vlad Rezki
