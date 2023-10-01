Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A9BE748E6
	for <rcu@archiver.kernel.org>; Sun,  1 Oct 2023 00:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjJAATm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Sep 2023 20:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjJAATl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Sep 2023 20:19:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58449D3
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 17:19:39 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bffa8578feso248838011fa.2
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 17:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696119577; x=1696724377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peGJXHAEIFqpS/OFlHocneddfXUq7BetnrL3NnUdkuI=;
        b=JgXefdHKHouVuD3yUTrxg4XELJjMImRwEIrhiOd/cVHTn6/zqjyzKwlWdUDmEcDWkl
         Vz7v2kyTZT2BUDZR5KyovzA/W4MD819dzA+O05FPSRmCunH99EXSLRj2kEtVy7xhLKNK
         4X74Jiw1ycQR2XxvfimGmGYqVc+hRGQJlWMz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696119577; x=1696724377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peGJXHAEIFqpS/OFlHocneddfXUq7BetnrL3NnUdkuI=;
        b=bx08f3fD4AQ9q6Dg5He8B5i/c2YnQ4nh8YtnCi9z7EeGeyz7qJclgpGOPa24nU4Xoi
         i1eqhodK99gHs4fDjYfD686+/tIegRBO4827YT/0o2DbdXdyBKS/cRCJV0YtpGvX+nFU
         fkyAg7StF0vTo+bPMVcnkTpqa/Kyx314EHabZEBrA8983LQ2iAqzYNq1YccC0Gm0aHQU
         +JGAg07+45CrhzP5p0ZBQlMKQEjhzsWT6gKblAOGGcEUUqMj+WoEfpF+8bCvd/0C5chq
         r4DzxffkQfzfiJouIUNX00j+zC749agnpHF/fGeUJQPj/nKtYvIoh42Xqn7CyS9Y0InU
         LWjg==
X-Gm-Message-State: AOJu0YyeBZKx6Hb2sjGJxbns1KcPasqE4gLy2i1Ry7l9w40Pal91hDqV
        eB1N6kT2AJRVFZ25gIqhj1Kp6vzycP+0owEz8fSfDfIEXiu8QkBgBSY=
X-Google-Smtp-Source: AGHT+IHc64LDDBG/ltZtw31xwRynY0pk2Qq/+VBP+DGZ0TQs6qnql4CgOSeF8tAIGRTo38niyNdxOS2HgcbHhqn4Fvc=
X-Received: by 2002:a2e:99cc:0:b0:2c0:ff6:984f with SMTP id
 l12-20020a2e99cc000000b002c00ff6984fmr7081126ljj.49.1696119576787; Sat, 30
 Sep 2023 17:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com> <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
In-Reply-To: <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 30 Sep 2023 20:19:25 -0400
Message-ID: <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 30, 2023 at 6:01=E2=80=AFAM Neeraj upadhyay <neeraj.iitr10@gmai=
l.com> wrote:
>
> On Fri, Sep 29, 2023 at 3:35=E2=80=AFAM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > Hello,
> > Firstly, kudos to the detailed report and analysis. Rare failures are
> > hard and your usage crash/kdump is awesome to dig deeper into the
> > issue..
> >
> > On Thu, Sep 28, 2023 at 3:59=E2=80=AFAM zhuangel570 <zhuangel570@gmail.=
com> wrote:
> > >
> > > Hi,
> > >
> > > We encounter SRCU hung issue in stable tree 5.4.203, we are running V=
M create
> > > and destroy concurrent test, the issue happens after several weeks. N=
ow we
> > > didn't have a way to reproduce this issue, the issue happens randomly=
, this
> > > is the second time we found it in this year.
> > >
> > >
> > >
> > > CASE1: entry of CPU 136 belongs to GP 288 was accelerated to GP 292
> > > - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callback=
s.
> > > - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queu=
e entry
> > >   to SDP.
> > > - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, work=
load run
> > >   faster than CPU 136, start GP, set rcu_seq_start.
> > > - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found n=
o need
> > >   to start GP.
> > > - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks=
,
> > >   "accelerate" the seq of new added entry to 292 (it should be 288).
> >
> > But srcu_gp_seq is at 304 right now. How does it matter that the CB is
> > marked for 292? It should be ready to execute anyway even at 292. Note
> > the meaning of "acceleration", the idea is to start conservatively and
> > move the callbacks forward as more accurate information is available.
> > Considering this, 292 initially should be OK IMHO (that's just more
> > conservative than 288)..
> >
>
> Maybe it matters, as for a CPU, the callbacks will only be scheduled
> in srcu_gp_end() for the GPs, for which it has updated ->srcu_data_have_c=
bs[idx]
> and ->srcu_have_cbs[idx]

Right but if I am looking at the code correctly, nothing guarantees
that srcu_invoke_callbacks is called before srcu_gp_seq can advance.
So all callbacks that were previously queued for older grace periods
should be run whenever srcu_invoke_callbacks() eventually runs. That's
why I was thinking that part looked normal to me (segments having
older GP numbers).

> > >
> > > /*
> > >  * CASE2
> > >  * - entry of CPU 136 belongs to GP 288 was accelerated to GP 296.
> > >  * - GP0: 280-284, GP1: 284-288, GP2: 288-292.
> > >  */
> > >
> > > /* [GP0][CPU-136] */
> > > process_srcu {
> > >  srcu_gp_end
> > > }
> > >
> > >                   /* [GP1][CPU-136] */
> > >                   synchronize_srcu {
> > >                    __call_srcu {
> > >                     rcu_segcblist_enqueue
> > >                                            /* [GP1][CPU-041] */
> > >                                            synchronize_srcu {
> > >                                             __call_srcu {
> > >                                              srcu_funnel_gp_start
> > >                                               srcu_gp_start
> > >                                             }
> > >                                            }
> > >                                            process_srcu {
> > >                                             srcu_gp_end
> > >                                              rcu_seq_end
> > >                                            }
> > >                   /* [GP1][CPU-136] */
> > >                     srcu_funnel_gp_start
> > >                    }
> > >                   }
> > > /* [GP0][CPU-136] */
> > > srcu_invoke_callbacks {
> >
> > If srcu_invoke_callbacks() was really called for the rdp, I would have
> > expected rcu_segcblist_advance() to advance all those pending
> > callbacks to 304.
>
> If the callback is in NEXT_TAIL and not assigned GP num,
> rcu_segcblist_advance() won't move it and next accelerate in
> srcu_invoke_callbacks() will
> assign it the next gp sequence num.

Sure, and after that again it will call srcu_schedule_cbs_sdp() so
that should be fine and the next workqueue invocation
srcu_invoke_callbacks() can advance at that time. Right?

if (more) {
  srcu_schedule_cbs_sdp(sdp, 0);
}

thanks,

 - Joel
