Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4DC433EF
	for <rcu@archiver.kernel.org>; Thu, 28 Oct 2021 13:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004C7610A0
	for <rcu@archiver.kernel.org>; Thu, 28 Oct 2021 13:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhJ1NdS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhJ1NdQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Oct 2021 09:33:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA16261040;
        Thu, 28 Oct 2021 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635427849;
        bh=2AU5vMARnoD7CkinUW7V2ShndNd+uKH+pR6OdrEij04=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MGab7tyS50J9fDwYO3sPuUnkvQjjW4+A0/rRJPW4n0CpPd4gefT2D5jhu/0v3qHg5
         ZkqV4ZDMqXLXjmsgPwu1ZgY/BX1CQRZu+KdgjZSNlHmvPfAWBCh+0fMQBrT5QMuOhX
         KscBrn7vqpxR3giMSKl1AtpncRAzLdiLsRlyZLKIsL+7o30x4vOd+La0wRysUbNBZ1
         9eKa4idRFn1aVyhum3TQzYY1T4oA0L0QKapSUDWBUvIOU2g0d4FFodSrmTQAPmYZvh
         sQRFZ7gfRD4jFFXewvCnQXJ+6Nasi25j/IF4feL5nIWgsRYSBt2LuDQ3Ipzp/SqijB
         So3T6Lie2g4kQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3E3BC5C00AA; Thu, 28 Oct 2021 06:30:49 -0700 (PDT)
Date:   Thu, 28 Oct 2021 06:30:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] refscale: always log the error message
Message-ID: <20211028133049.GC880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
 <20211025032658.22889-3-lizhijian@cn.fujitsu.com>
 <5f4c53e4-34aa-98f6-343f-0de18df830f2@fujitsu.com>
 <20211026140632.GV880162@paulmck-ThinkPad-P17-Gen-1>
 <0c9868b6-a143-b098-aa0d-bf525f32ed8c@fujitsu.com>
 <c4a3691e-38b9-60d5-ed8b-77e5442cfd07@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4a3691e-38b9-60d5-ed8b-77e5442cfd07@fujitsu.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 27, 2021 at 07:21:34AM +0000, lizhijian@fujitsu.com wrote:
> Hi Paul
> 
> During adding the missing '\n', i also found there are some verbose control error message
> Should we convert it like [PATCH 3/3] refscale: always log the error message

These do indeed look like they should always be logged.  Good catches!

							Thanx, Paul

> lizj@FNSTPC: linux$ git grep VERBOSE.*_ERRSTRING
> include/linux/torture.h:#define VERBOSE_TOROUT_ERRSTRING(s) \
> kernel/locking/locktorture.c: VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
> kernel/locking/locktorture.c: VERBOSE_TOROUT_ERRSTRING("reader_tasks: Out of memory");
> kernel/rcu/rcuscale.c:#define VERBOSE_SCALEOUT_ERRSTRING(s) \
> kernel/rcu/rcuscale.c:          VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
> kernel/rcu/rcuscale.c:          VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
> kernel/rcu/rcuscale.c:          VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
> kernel/rcu/rcuscale.c:          VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> kernel/rcu/rcuscale.c:          VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> kernel/rcu/rcutorture.c: VERBOSE_TOROUT_ERRSTRING("out of memory");
> kernel/rcu/rcutorture.c: VERBOSE_TOROUT_ERRSTRING("out of memory");
> kernel/rcu/rcutorture.c: VERBOSE_TOROUT_ERRSTRING("out of memory");
> kernel/rcu/rcutorture.c: VERBOSE_TOROUT_ERRSTRING("out of memory");
> kernel/scftorture.c:#define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
> kernel/scftorture.c:            VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
> kernel/scftorture.c:            VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
> kernel/scftorture.c:            VERBOSE_SCFTORTOUT_ERRSTRING("out of memory");
> kernel/torture.c:               VERBOSE_TOROUT_ERRSTRING("Failed to alloc mask");
> kernel/torture.c:               VERBOSE_TOROUT_ERRSTRING(f);
> 
> 
> 
> Thanks
> 
> 
> 
> On 27/10/2021 13:17, Li Zhijian wrote:
> >
> >
> > On 26/10/2021 22:06, Paul E. McKenney wrote:
> >> On Mon, Oct 25, 2021 at 06:12:40AM +0000, lizhijian@fujitsu.com wrote:
> >>>
> >>> On 25/10/2021 11:26, Li Zhijian wrote:
> >>>> Generally, error message should be logged anyhow.
> >>>>
> >>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >>>> ---
> >>>>    kernel/rcu/refscale.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> >>>> index a4479f00dcdc..f055d168365a 100644
> >>>> --- a/kernel/rcu/refscale.c
> >>>> +++ b/kernel/rcu/refscale.c
> >>>> @@ -58,8 +58,8 @@ do {                                            \
> >>>>        }                                        \
> >>>>    } while (0)
> >>>>    -#define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
> >>>> -    do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
> >>>> +#define SCALEOUT_ERRSTRING(s, x...) \
> >>>> +    do { pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
> >>>>       MODULE_LICENSE("GPL");
> >>>>    MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
> >>>> @@ -651,7 +651,7 @@ static int main_func(void *arg)
> >>>>        result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
> >>>>        buf = kzalloc(800 + 64, GFP_KERNEL);
> >>>>        if (!result_avg || !buf) {
> >>>> -        VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> >>>> +        SCALEOUT_ERRSTRING("out of memory");
> >>> '\n' should be added to the last to flush it.
> >> And there might well be other missing "\n" instances in similar messages
> >> in rcuscale.c, rcutorture.c, scftorture.c, locktorture.c, and torture.c.
> >> Please feel free to send a patch for each file needing this help.
> >
> > Sure, i will do that.
> >
> > Thanks
> > Zhijian
> >
> >> I queued your other three patches for v5.17 (not this coming merge window,
> >> but the one after that), thank you!  I did wordsmith the commit logs,
> >> so please check to see if I messed anything up.
> >>
> >>                             Thanx, Paul
> >>
> >>>>            goto oom_exit;
> >>>>        }
> >>>>        if (holdoff)
> >>>> @@ -837,7 +837,7 @@ ref_scale_init(void)
> >>>>        reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
> >>>>                       GFP_KERNEL);
> >>>>        if (!reader_tasks) {
> >>>> -        VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> >>>> +        SCALEOUT_ERRSTRING("out of memory");
> >>> ditto
> >>>
> >>> Thanks
> >>> Zhijian
> >>>>            firsterr = -ENOMEM;
> >>>>            goto unwind;
> >>>>        }
> >
