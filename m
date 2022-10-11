Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DECC433FE
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJKRpQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJKRpO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 13:45:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F12E6AA
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 10:45:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l127so11445287iof.12
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xH4szhLQ9lo52EIlDPuABeYiQRNpOGbXO1EMEBvf2E=;
        b=c5vE4z4d062tsOIqsjv8GH+B5jtkv+mViPakJlB3g34EBSUonGSrb9NP7BTicFc3PM
         wmPC+/8PZCLh03AL75qnywtfcBFW79r/gz76F8xr1BN5PW548diBx8ZkJJ6O4z3uJiFm
         YNtxhHfz9E+eSu21kRDkHsvqJZNKdbximbGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xH4szhLQ9lo52EIlDPuABeYiQRNpOGbXO1EMEBvf2E=;
        b=oXgZ48U71d/6YfZUnFhO9ZXkBTH7SeXWwKUQ1lEjQN9Xfn+gML3ImqDu3b9nmBH2uf
         Zv1vuTh8iDoWPUwrAV74rGbovY2h7GJFnh7yMtk9clL2nhEs8txE2wT/+mbgAMHFpTeI
         mUtk4S8sNVeeZomXnPPCiFxZYnpLwzlSI8jr78cE9kJsPCp1NySSpuk44/i1HZAJlqNV
         rzl1MGCofy7x57zaxF9FXULSHvd91xrM9ypQ1SftQQGMtRRjIBK+Bfm+eVnTC+oEIsWT
         mgo4Hy7MnN2kf0+GuW+T5zaehsgQBHzq4jSdzS5dp8vqigUiziKRRr2dTeddbFnMoNPp
         /R9A==
X-Gm-Message-State: ACrzQf0b7eC4oKoccYvYFxJI3cQvlXj76Zbh3XOgjK8RM17jNPDsfHLi
        60NJ6+b+inh0QIxviwklSwJLDD2WUygDjruWRj05kg==
X-Google-Smtp-Source: AMsMyM6fzT2TKdbM6buZFdhAM+QZcR7gjpiR1Y1MzI9STAunA5zQ0SQTFcYkv1hUPMwJHM5lOIZe4iR++FTh+VBA5no=
X-Received: by 2002:a05:6638:40a2:b0:35a:bd14:1a31 with SMTP id
 m34-20020a05663840a200b0035abd141a31mr13552857jam.107.1665510312785; Tue, 11
 Oct 2022 10:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org> <20221006191130.GC4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221006191130.GC4196@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 11 Oct 2022 13:44:59 -0400
Message-ID: <CAEXW_YRuPQWdqEvk-5T4Kn2y_kPDtB1wby490uue8=BUS1UWjg@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 6, 2022 at 3:11 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[..]
> >  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > -                             bool *was_alldone, unsigned long flags)
> > +                             bool *was_alldone, unsigned long flags,
> > +                             bool lazy)
> >  {
> >       unsigned long c;
> >       unsigned long cur_gp_seq;
> >       unsigned long j = jiffies;
> >       long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > +     bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
>
> In the alphabet, "b" comes before "c".  Picky, but it does make these
> things easier to find.  Which can be important when you are searching
> for all occurrences of something -- nice to be able to find the variable
> in alpha order without interrupting your search.

For this comment, I cannot reorder it because it will break as ncbs
needs to be defined before it is used. I will leave this one alone if
it is Ok with you.

I am OK with all the other comments.

Thanks.
