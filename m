Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB45C433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 13:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiELN4x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354764AbiELN4w (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 09:56:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13E68F91
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 06:56:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g6so10459379ejw.1
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K3ANpDH7TQa6hQ9iJ5bA2NJ4LRyBx0UH8tpNcriMps=;
        b=D6wkSAK1bhw4IF7tL+UNzBD1Dt9t/+l9/kCqt3BhiaSqRrO8uZZhtzHZ7+MWSKkDNP
         Mm5U8NUaQ8T/lNbunSjC/1zyVmq8lsciW/jx/MR6Cbu+cGIvpUzgPqA++DcyFg6VRp0A
         EHyufhdBkt2WNbFiQRTD8+D6xZIrPJCNHfPmS5YTzMZwsIjLaifqWJlmAu/iDaf9owJo
         xtdYYtwH1lMQNyOvJ24s0/wNp8VSXILzAQg996gox79HYc18+tRhpXzipY2ks3nnuL75
         QacG2n9SrtS58aQbGZ3ig27sw3wOpO+0PBDaeeA0SX1mN3fER99Mzczd4dfzslByJdFM
         y8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K3ANpDH7TQa6hQ9iJ5bA2NJ4LRyBx0UH8tpNcriMps=;
        b=DEqaSMiZmYij5a5ExlpieckvZBWLgALxGwgbKhq5ronuFwA9gmVdn9wEhC8OrkDZhb
         r/XzzVopCY1oC39BXgiExCQDcLdz+jr+kmmhKvbZ6O5nTz4nu8wl7XaHjvPJL85bj8WX
         32Y8ZIrktuKfNuIkat7Uon+76MxJgnp5qs63A+EXNhFdw9j2de+GhU/L2d1D+nlyJELy
         LngjZgBxrw6XNgBY//WOCh6hcozpi+LCGts+zVP48VFxIOVZw5E9IinDTIfI5lUHXzyL
         RKiWJYgxABK1t8BtYRDC0Z9far+yxOnf1AnXxuG301nLW6+FdIMOapo/wk5zkx7++dK7
         d5SQ==
X-Gm-Message-State: AOAM533XLLoRc3KpuyYffIVdoEsz8eHX+Va+CK/ONKOkasRQ5oYU5FPg
        NEFodHqL8R5QS9hh8AWTUTJrVd/N1KGk4YfD7YLTCTAW
X-Google-Smtp-Source: ABdhPJysQ8ySUcS1rrQvPM47zCE5y2NTdT/2LEuZ9FBEmyx91sQFVNj1QMZOeTKtblCy8ihMcMQt9GO+e8orKNzmho8=
X-Received: by 2002:a17:907:2da9:b0:6f8:6104:659 with SMTP id
 gt41-20020a1709072da900b006f861040659mr44819ejc.556.1652363808303; Thu, 12
 May 2022 06:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com> <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
In-Reply-To: <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 12 May 2022 15:56:37 +0200
Message-ID: <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Never mind. I port it into 5.10

On Thu, May 12, 2022 at 3:09 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Joel!
>
> Which kernel version have you used for this series?
>
> --
> Uladzislau Rezki
>
> On Thu, May 12, 2022 at 5:18 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, May 11, 2022 at 11:04 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > Hello!
> > > Please find the proof of concept version of call_rcu_lazy() attached. This
> > > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > > Rushikesh Kadam from Intel for investigating it with me.
> > >
> > > Some numbers below:
> > >
> > > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > > system is very lightly loaded but constantly running few RCU callbacks very
> > > often. This confuses the power management hardware that the system is active,
> > > when it is in fact idle.
> > >
> > > For example, when ChromeOS screen is off and user is not doing anything on the
> > > system, we can see big power savings.
> > > Before:
> > > Pk%pc10 = 72.13
> > > PkgWatt = 0.58
> > > CorWatt = 0.04
> > >
> > > After:
> > > Pk%pc10 = 81.28
> > > PkgWatt = 0.41
> > > CorWatt = 0.03
> > >
> > > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > > can see that the display pipeline is constantly doing RCU callback queuing due
> > > to open/close of file descriptors associated with graphics buffers. This is
> > > attributed to the file_free_rcu() path which this patch series also touches.
> > >
> > > This patch series adds a simple but effective, and lockless implementation of
> > > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > > initiate a flush of one or more per-CPU lists.
> > >
> > > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > > of function graph tracer when increasing that.
> > >
> > > One drawback of this series is, if another frequent RCU callback creeps up in
> > > the future, that's not lazy, then that will again hurt the power. However, I
> > > believe identifying and fixing those is a more reasonable approach than slowing
> > > RCU down for the whole system.
> > >
> > > NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> > > at runtime to turn it on or off globally. It is default to on. Further, please
> > > use the sysctls in lazy.c for further tuning of parameters that effect the
> > > flushing.
> > >
> > > Disclaimer 1: Don't boot your personal system on it yet anticipating power
> > > savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> > > I believe this series should be good for general testing.
> > >
> > > Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> > > net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> > > of review and agreements.
> >
> > I did forget to add Disclaimer 3, that this breaks rcu_barrier() and
> > support for that definitely needs work.
> >
> > thanks,
> >
> >  - Joel
>
>
>
> --
> Uladzislau Rezki



-- 
Uladzislau Rezki
