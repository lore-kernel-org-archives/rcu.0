Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E132C4332F
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 15:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJPP46 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJPP44 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 11:56:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9652B2E9C4
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 08:56:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p16so7399632iod.6
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vog1YlNccwd6IAjfOrBTBXzBPiMg9Fk15Ih5tIXeCPM=;
        b=Bmcp+DBK743YLYdoRYyixSmm1u/4R/rZzgWtLrLJUv62esbyDG0t7aAdChhiGXIHjA
         qWvI02ipG6j3q4foAbzKd8wZMIm4axWxcyqMXzZyCWE4RvfqRTmIgwDyIVFCkz7C7QdJ
         bhwDkah2oLSYsD2gHnZCchEgPkPcPqXH36s80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vog1YlNccwd6IAjfOrBTBXzBPiMg9Fk15Ih5tIXeCPM=;
        b=JLbL3Hy3fKtGpYUXLEl8Wm276bHBx2nZwrq/MbSxSCvKcoMHNlOTL/9VyJ6iq6zpMM
         I2edLh+0Z1SIH+23l/6L/FN8fdkOv5aaibGYoOaTwTZKJEbhdFdchIb1wQ1xSFrcmhgu
         o6PWIKF12TM40Migcp9bzcCqCdPvwXhYUy/T/d5xP/Y07oG7FC61CQaw7vyY2rB93EWb
         LWlZs+R6vXa7ABMIUxNFoikKB0z+/N82JMBlNkNyXLXsyzhTk0fn9DrdBbNBD7O0zzWU
         FBQF4Jxkh/MLi/s7tduoJUxWVVoVVWirPORoFpOxYUvmmFQBvJrQHBPeMpa4vQkGuHjx
         nGXw==
X-Gm-Message-State: ACrzQf17m3YpM+qz6FOaECThFG8tfmLCmAuId9O1ht9OMu2G6Z1RMwlm
        LmfchNWaxIhyfJNwG+OXXvy+1n8QM1Xfr+Ca3ebk8Q==
X-Google-Smtp-Source: AMsMyM4zacrwSvTvrpB9P6hhTEO7M4uX/F5mXLMcNbiV3edgHdvQWi/YJm4p0pSShibFP3f0BJ/EdIFm37YelG37elc=
X-Received: by 2002:a02:a513:0:b0:363:b0dc:222b with SMTP id
 e19-20020a02a513000000b00363b0dc222bmr3318308jam.213.1665935813952; Sun, 16
 Oct 2022 08:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-2-joel@joelfernandes.org> <20221014142127.GE4221@paulmck-ThinkPad-P17-Gen-1>
 <20221014144019.GB1108603@lothringen> <20221014150344.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQoRUJ=0_GJG6JunR58yASmehPanp14zbR3Y+KAGL1TDA@mail.gmail.com>
 <20221014154606.GJ4221@paulmck-ThinkPad-P17-Gen-1> <20221014204750.GA1119620@lothringen>
 <20221016151655.GA5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221016151655.GA5600@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 16 Oct 2022 11:56:42 -0400
Message-ID: <CAEXW_YSHN=OWhSu3=Qr+SCeo+=HOHmj3=votKXPmTk0Us2SpdA@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 16, 2022 at 11:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Oct 14, 2022 at 10:47:50PM +0200, Frederic Weisbecker wrote:
> > On Fri, Oct 14, 2022 at 08:46:06AM -0700, Paul E. McKenney wrote:
> > > On Fri, Oct 14, 2022 at 11:19:28AM -0400, Joel Fernandes wrote:
> > > > I agree with the discussion, though if all CBs are in the bypass list,
> > > > the patch will also save 2 jiffies.
> > > >
> > > > So just commit messages that need rework then? This one can be taken instead:
> > > > https://lore.kernel.org/rcu/21ECDA9F-81B1-4D22-8B03-020FB5DADA4F@joelfernandes.org/T/#m14d21fbce23539a521693a4184b28ddc55d7d2c5
> > >
> > > This one looks plausible to me.
> >
> > With the following modified diff (passed 25 hours of TREE01):
>
> Very good!
>
> Could one of you (presumably Joel) please send v9?
>
> Just to avoid me getting the wrong patch in the wrong place or similar.
> Or mangling the required rebase following a pull (otherwise, as soon as I
> create branches, Stephen Rothwell notes the lack of a committer signoff.)

Taking a break from raking leaves so doing it right now! Those leaves!

 - Joel
