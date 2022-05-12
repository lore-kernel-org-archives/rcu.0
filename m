Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F4C433FE
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 14:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354957AbiELODs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354983AbiELODp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 10:03:45 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821EC57B2A
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 07:03:39 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hf18so4389578qtb.0
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIjhX9zlnG1C2kdUMd43hgO4DlJW4qQ7npM3Ai91UX8=;
        b=w5l6MTV+iv5No1m8qgCY9msXWJY8cFb9e9TQ3WFE0tjXOrzpMLjbye6dg0osvVk2oZ
         EEDvsH5xdlhzofTUjmIF/brhFcTrKe8ah6S/Te5z1dnjWhoLiZjmvUUvoO99ZxAxT2vx
         Ogt4ht5ZzzcVTkNxciSerrJY/aWBg9tK08kNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hIjhX9zlnG1C2kdUMd43hgO4DlJW4qQ7npM3Ai91UX8=;
        b=iVWT9XJMlI9zUBSHqSxVBXSTm2+v3VS1yaTnv3D8U9XtttI/AR2OgKKK3+7xelKScM
         Miz88XUH8pMkqSy0kIqrrmY8QHOLAAUt3c3tJD6eh2lYyKzj6b9d/i+3XW/81Vga8oo9
         WFFQgCGgJpmEQHCUhiBcA1T+tWYwXQzVVzV/z1Zij6J+0gWuOifYbyZj5nkG4FoQorNh
         K6BrsjJwi7AmmWwNzMTmsxm6n2iV5wpxOxDc08ZgK3S6+73Bw2GDqzYusB9xSnn1xNPi
         nguQDyGVnLuUeO4d/Q+MEAvMwHfAgg7MrBxo7sae1y0AbluBoq5ZmhuRSr+Kz8qRw5DX
         Ek/w==
X-Gm-Message-State: AOAM531H/+azer25zvp0hpDDlXlu8v0/dOjXyGQv9bBMyFoYf3CdaNjS
        KNdZnM5V/qgpURSgeYuUoa5xbQ==
X-Google-Smtp-Source: ABdhPJygkPpMs8R2oIgTw2LtWYT81LM/xvudrnIGCOCfl5Ys8WfCfYlUaRvbEl9DeZcQXth+MbAIZw==
X-Received: by 2002:ac8:4e43:0:b0:2f3:cdd9:f4d4 with SMTP id e3-20020ac84e43000000b002f3cdd9f4d4mr24142731qtw.490.1652364218639;
        Thu, 12 May 2022 07:03:38 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id r12-20020a05622a034c00b002f3bbad9e37sm3020377qtw.91.2022.05.12.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:03:38 -0700 (PDT)
Date:   Thu, 12 May 2022 14:03:37 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <Yn0TuehXj6VoWG0A@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> Never mind. I port it into 5.10

Oh, this is on mainline. Sorry about that. If you want I have a tree here for
5.10 , although that does not have the kfree changes, everything else is
ditto.
https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4

thanks,

 - Joel



> 
> On Thu, May 12, 2022 at 3:09 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > Hello, Joel!
> >
> > Which kernel version have you used for this series?
> >
> > --
> > Uladzislau Rezki
> >
> > On Thu, May 12, 2022 at 5:18 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Wed, May 11, 2022 at 11:04 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > Hello!
> > > > Please find the proof of concept version of call_rcu_lazy() attached. This
> > > > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > > > Rushikesh Kadam from Intel for investigating it with me.
> > > >
> > > > Some numbers below:
> > > >
> > > > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > > > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > > > system is very lightly loaded but constantly running few RCU callbacks very
> > > > often. This confuses the power management hardware that the system is active,
> > > > when it is in fact idle.
> > > >
> > > > For example, when ChromeOS screen is off and user is not doing anything on the
> > > > system, we can see big power savings.
> > > > Before:
> > > > Pk%pc10 = 72.13
> > > > PkgWatt = 0.58
> > > > CorWatt = 0.04
> > > >
> > > > After:
> > > > Pk%pc10 = 81.28
> > > > PkgWatt = 0.41
> > > > CorWatt = 0.03
> > > >
> > > > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > > > can see that the display pipeline is constantly doing RCU callback queuing due
> > > > to open/close of file descriptors associated with graphics buffers. This is
> > > > attributed to the file_free_rcu() path which this patch series also touches.
> > > >
> > > > This patch series adds a simple but effective, and lockless implementation of
> > > > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > > > initiate a flush of one or more per-CPU lists.
> > > >
> > > > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > > > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > > > of function graph tracer when increasing that.
> > > >
> > > > One drawback of this series is, if another frequent RCU callback creeps up in
> > > > the future, that's not lazy, then that will again hurt the power. However, I
> > > > believe identifying and fixing those is a more reasonable approach than slowing
> > > > RCU down for the whole system.
> > > >
> > > > NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> > > > at runtime to turn it on or off globally. It is default to on. Further, please
> > > > use the sysctls in lazy.c for further tuning of parameters that effect the
> > > > flushing.
> > > >
> > > > Disclaimer 1: Don't boot your personal system on it yet anticipating power
> > > > savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> > > > I believe this series should be good for general testing.
> > > >
> > > > Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> > > > net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> > > > of review and agreements.
> > >
> > > I did forget to add Disclaimer 3, that this breaks rcu_barrier() and
> > > support for that definitely needs work.
> > >
> > > thanks,
> > >
> > >  - Joel
> >
> >
> >
> > --
> > Uladzislau Rezki
> 
> 
> 
> -- 
> Uladzislau Rezki
