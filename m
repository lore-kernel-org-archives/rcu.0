Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F95CC433FE
	for <rcu@archiver.kernel.org>; Wed,  2 Nov 2022 17:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiKBR3h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiKBR3b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Nov 2022 13:29:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E55C616A
        for <rcu@vger.kernel.org>; Wed,  2 Nov 2022 10:29:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n12so47107949eja.11
        for <rcu@vger.kernel.org>; Wed, 02 Nov 2022 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxDde4qRqyEca/IxQGMrFPEDI17+HmAsloAmejuARRk=;
        b=U0Aw83ukmKY0OzHlVsYXFy96EGLa3UosLHR02xRYJOCY1UbsE5ZIjk7tNiSB8eBxyS
         +M0iVEX8qR55wMktPIzxm8cO/ZcZUN7xyp1FsToRVNP92sycBMLDXiFO7xCuj3BvwDn1
         d7fyhlIGpZf1HW5pw05W8HACwBhK1YwCZKfPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxDde4qRqyEca/IxQGMrFPEDI17+HmAsloAmejuARRk=;
        b=A6HKHvBzsGKv4tI1G4RFKMoHQk1k9thqwfkgT486DPeCUpKOO/B3in4v8yWYeCvPLi
         gvrGoCGekeu2AtiH0rcdWGefgCeEWCWU0X4Ph0/CQHXZNGHSWwzq5SqKXSVq71TTqppr
         8PkmvcKupGCtHN431DNftg2Jb3uwXw1Bm+S3fg62dyP/nj3WGas6tBsCwsB6uUCa4Zx9
         t8XhK8JfTv8yeF1HfIL4VoLIPT6CL7aGVPL/2sXw/nJqV8bCMcbO7li/8QKDaYNmYuYc
         l5J2XfKyiXYnGgGO1qmtxJ1J33xMJL7ArSMjKkP6uEMoho5xBuEsmDT8UicY+mh8SddJ
         ohLg==
X-Gm-Message-State: ACrzQf1Zsqjwnm4ZafTQbMdj6ZWS/tYLTWcUkSs9PK4nM1gyN7e3YJxa
        T8J3dCudn9RYbNGZKB2GjrlRo7/4+wMlRjzOsdf3yg==
X-Google-Smtp-Source: AMsMyM7qW87qtVq6mAzTAUGDt6XQJj9jlqw6I8dI3sxMhuYJ852+sK8kEehKAshQNpssgzP2yp8L2pX/6wQaKoInMiw=
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id
 wu1-20020a170906eec100b00782638476bemr24655611ejb.756.1667410167148; Wed, 02
 Nov 2022 10:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636> <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
 <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1> <Y2KnxKDebPKiqTFZ@pc636>
In-Reply-To: <Y2KnxKDebPKiqTFZ@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Nov 2022 13:29:17 -0400
Message-ID: <CAEXW_YRquk15oGMCrYXLTKWtMzfPJhEJpjENM_rqt4qjwtAt+g@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 2, 2022 at 1:24 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Wed, Nov 02, 2022 at 09:35:44AM -0700, Paul E. McKenney wrote:
> > On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
> > > On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> > > > > On ChromeOS, I am (almost) always seeing the optimization trigger.
> > > > > Tested boot up and trace_printk'ing how often it triggers.
> > > > >
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 18 +++++++++++++++++-
> > > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 591187b6352e..3e4c50b9fd33 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > >
> > > > >  /**
> > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > > > > + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
> > > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > > > > @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > >       raw_spinlock_t lock;
> > > > >       struct delayed_work monitor_work;
> > > > > +     struct rcu_data *rdp;
> > > > > +     unsigned long last_gp_seq;
> > > > >       bool initialized;
> > > > >       int count;
> > > > >
> > > > > @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> > > > >                       mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > >               return;
> > > > >       }
> > > > > +     krcp->last_gp_seq = krcp->rdp->gp_seq;
> > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > >  }
> > > > >
> > > > > @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > > >                       // be that the work is in the pending state when
> > > > >                       // channels have been detached following by each
> > > > >                       // other.
> > > > > -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > > > > +                     //
> > > > > +                     // NOTE about gp_seq wrap: In case of gp_seq overflow,
> > > > > +                     // it is possible for rdp->gp_seq to be less than
> > > > > +                     // krcp->last_gp_seq even though a GP might be over. In
> > > > > +                     // this rare case, we would just have one extra GP.
> > > > > +                     if (krcp->last_gp_seq &&
> > > > >
> > > > This check can be eliminated i think. A kfree_rcu_cpu is defined as
> > > > static so by default the last_gp_set is set to zero.
> > >
> > > Ack.
> > >
> > > > > @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
> > > > >       for_each_possible_cpu(cpu) {
> > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > >
> > > > > +             krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > +             krcp->last_gp_seq = 0;
> > > > >
> > > > Yep. This one can be just dropped.
> > > >
> > > > But all the rest looks good :) I will give it a try from test point of
> > > > view. It is interested from the memory footprint point of view.
> > >
> > > Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it
> > > is still worth a test.
> >
> > Just for completeness, the main purpose of rdp->gp_seq is to reject
> > quiescent states that were seen during already-completed grace periods.
> >
> So it means that instead of gp_seq reading we should take a snaphshot
> of the current state:
>
> snp = get_state_synchronize_rcu();
>
> and later on do a:
>
> cond_synchronize_rcu(snp);
>
> to wait for a GP.

This can't be called from the timer IRQ handler though (monitor)

> Or if the poll_state_synchronize_rcu(oldstate)) != 0
> queue_rcu_work().

But something like this should be possible (maybe)

> Sorry for a description using the RCU API functions name :)

I believe you will have to call rcu_poll_gp_seq_start() as well if you
are using polled API. I am planning to look at this properly more,
soon. Right now I am going to write up the rcutop doc and share with
you guys.

(Maybe RCU polling is the right thing to do as we reuse all the infra
and any corner case it is handling)

thanks,

- Joel


> --
> Uladzislau Rezki
