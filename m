Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C571C6FA82
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 22:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITWfJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITWfI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 18:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E55E567
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 15:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D9562E5D
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 22:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84341C433D6;
        Tue, 20 Sep 2022 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663713305;
        bh=nI6M0m90LBjBDewJDicnWkXGsRLNKez174y110inGoE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RXX2IV4rz223rBUKff2N2Y5Im6UMhJTZqd4mCsQEUTWw4oqTNqzAwxQxa7W62C6VW
         Kt8pCrF94H3PLHblKDmDgCejBYtF4YgXR1Fc2l9OpKk2ignNfgWEW+syI/YUBOWLfV
         SL5LA3vmRs1dO/FHosKmjB8xOLW9uTu7kb2Ko7oMTuAtBy2bEShE5W6T4Uw1N1FrCH
         qX0r7PUwq0p8Hd4wTwGn/GNnnLP5RQ0KeW9DFv0lg8PwIw/f6T67+m4Ue+yCAJAIc8
         2Er7v2Zr3e3otczGuij/bMVPTmnhYGw7bMh1RinTFgWRYDNxQVvQGu+6GHEVygY6X4
         UCFoX0gncNJTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1B1525C1503; Tue, 20 Sep 2022 15:35:05 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:35:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220920223505.GV4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQGPwkTQjxAb5p4OOhJkMA-L93JNTsa-WaXs0Ts7=Oakw@mail.gmail.com>
 <20220919223211.GJ4196@paulmck-ThinkPad-P17-Gen-1>
 <f061b798-e6f6-1523-52c3-12fe7966f809@joelfernandes.org>
 <a2882e80-1723-9004-f67a-cd8332aa701d@joelfernandes.org>
 <d72808e1-fc27-f158-37b7-ef23c23e74c1@joelfernandes.org>
 <CAEXW_YRsp4HqwAPaDq9VYRptwgdcp7mPJjRH1msE42gzGajBjQ@mail.gmail.com>
 <20220920123208.GL4196@paulmck-ThinkPad-P17-Gen-1>
 <Yyn+qSZiYI02WxOv@google.com>
 <20220920190306.GR4196@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YThgajt5C86GoEn_N8ywMByfO_4Ni0CHB85tm1yBG+tsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YThgajt5C86GoEn_N8ywMByfO_4Ni0CHB85tm1yBG+tsg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 06:27:52PM -0400, Joel Fernandes wrote:
> On Tue, Sep 20, 2022 at 3:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > > > >>>> Are you saying we should not make call_rcu() default-lazy for
> > > > > > >>>> everyone? According to Thomas, anyone expecting call_rcu() to finish
> > > > > > >>>> in any reasonable amount of time is a bug, and that usecase needs to
> > > > > > >>>> be fixed to use synchronize_rcu(). Are we saying now that that's not
> > > > > > >>>> our direction?
> > > > > > >>>
> > > > > > >>> I am saying that Thomas can sometimes get quite enthusiastic about
> > > > > > >>> a particular direction.  Plus I strongly suspect that Thomas has not
> > > > > > >>> actually reviewed all of the RCU callbacks.
> > > > > > >>>
> > > > > > >>> Of course, I agree that it won't hurt to try out Thomas's suggestion,
> > > > > > >>> which is why I did not object at the time.  But we should be fully
> > > > > > >>> prepared for it to blow up in our faces.  ;-)
> > > > > > >>
> > > > > > >> Makes sense, thanks for clarifying. My impression was he does expect some pain
> > > > > > >> in the short-term but the pain is worth not introduction a new opt-in API.
> > > > > > >>
> > > > > > >> I am wondering if putting it behind a CONFIG option will delay the pain too
> > > > > > >> much. Thoughts? I am assuming that we want the CONFIG to turn it off by default.
> > > > > > >
> > > > > > > I tried a poor man's version of Thomas's idea by doing
> > > > > > > jiffies_till_first_fqs=1000 and rcu.rcu_expedited=1 boot parameters. Of course
> > > > > > > this just for trying has no regard for memory pressure and such so it is in the
> > > > > > > 'do not try at home' category.
> > > > > > >
> > > > > > > Then I tried jiffies_till_first_fqs=128 and compare before/after kernel logs.
> > > > > > >
> > > > > > > These are on ChromeOS hardware (5.19-rc4 kernel)
> > > > > > > For jiffies_till_first_fqs=1000 Everything is fine until this point:
> > > > > > >     8.383646] Freeing unused kernel image (initmem) memory: 1676K
> > > > > > >    11.378880] Write protecting the kernel read-only data: 28672k
> > > > > > >
> > > > > > > I do not see this 3 second delay with jiffies_till_first_fqs=128.
> > > > > > >     8.411866] Freeing unused kernel image (initmem) memory: 1676K
> > > > > > >     8.656701] Write protecting the kernel read-only data: 28672k
> > > > > >
> > > > > > At least this could be because of the rodata write protection stuff calling
> > > > > > rcu_barrier():
> > > > > >
> > > > > > From init/main.c
> > > > > >
> > > > > > #ifdef CONFIG_STRICT_KERNEL_RWX
> > > > > > static void mark_readonly(void)
> > > > > > {
> > > > > >         if (rodata_enabled) {
> > > > > >                 /*
> > > > > >                  * load_module() results in W+X mappings, which are cleaned
> > > > > >                  * up with call_rcu().  Let's make sure that queued work is
> > > > > >                  * flushed so that we don't hit false positives looking for
> > > > > >                  * insecure pages which are W+X.
> > > > > >                  */
> > > > > >                 rcu_barrier();
> > > > > >                 mark_rodata_ro();
> > > > > >                 rodata_test();
> > > > > >         } else
> > > > > >                 pr_info("Kernel memory protection disabled.\n");
> > > > > > }
> > > > > >
> > > > > >
> > > > > > I think rcu_barrier() does not play well with jiffiest_till_first_fqs (probably
> > > > > > because of the missing wake ups I found in the existing code, I should try that
> > > > > > patch on this test..).
> > > > > >
> > > > > > Is it expected that a sleep involving jiffies_till_first_fqs does not get
> > > > > > disturbed due to rcu_barrier() ? That seems like a bug to me. At least for
> > > > > > !NOCB, I don't see any call the rcu_gp_kthread_wake() from rcu_barrier()!
> > > >
> > > > Another approach is to take your current stack of patches, but only those
> > > > to RCU, and then as Thomas suggests, make call_rcu() behave lazily and
> > > > make a call_rcu_expedited() that retains the current behavior.  Keep the
> > > > current grace-period timings.
> > >
> > > Yes these sound good. But one issue is, we do not know all the cases that
> > > needed call_rcu_expedited(). There is the per-cpu refcount which needs it,
> > > but I'm not aware of any others. If you take the patches, can we add convert
> > > to call_rcu_expedited() as regressions happen?
> >
> > Exactly.
> >
> > Several of the calls to wait_rcu_gp() would need their arguments to
> > change from call_rcu() to call_rcu_expedited().  Oddly enough, including
> > the call from synchronize_rcu_expedited() in the case where there are
> > to be no expedited grace periods.  ;-)
> 
> Oh true, I totally missed that. So if we are going with it this way
> (everything async is lazy and then selectively make them non-lazy),
> then we can't do without a call_rcu_expedited() API in the patchset.
> Right? So I'll go work on that API then. It should be somewhat trivial
> to do, I think.

Yes, it is needed.

> One question - call_rcu_expedited() just means "use regular non lazy
> rcu", not "use expedited grace periods" right? In this case, is it
> better to call it call_rcu_fast() or call_rcu_nonlazy() to avoid
> conflicts with the "expedited" terminology in the
> synchronize_{s,}rcu_expedited() APIs?

I agree that call_rcu_expedited() is likely to cause confusion.
The call_rcu_fast() is nice and short, but the result really is not all
that fast.  The call_rcu_nonlazy() sounds good, but I am sure that as
usual there will be no shortage of bikeshedders.  ;-)

> > > > Then make synchronize_rcu() and friends use call_rcu_expedited() and see
> > > > if you can get away with only a small number of call_rcu_expedited()
> > > > "upgrades".
> > >
> > > Right. It is a bit of a chicken-and-egg problem, if we have to whitelist
> > > everything, then we have to blacklist as we go. If we blacklist everything,
> > > then we may miss whitelisting something.
> > >
> > > Thoughts?
> >
> > Try it and see what happens.  We can always fall back to call_rcu_lazy().
> 
> Ok :) I'll rewrite my patchset this way and push it out soon without
> further ado, and I'll fix any regressions I notice by converting to
> the _fast() API.

Sounds good!

								Thanx, Paul

> > > Meanwhile just to clarify- I am very much invested in seeing the current
> > > stack of patches merged soon give or take the _expedited() conversions,
> > > however I did the above jiffies_till_first experiments in the hopes they
> > > would show the ones that need such conversion quickly.
> >
> > I suggest doing the experiment on top of your patch stack, but excluding
> > the call_rcu_lazy() conversios.  That way, as we come to agreement on
> > pieces we can pull the patches in, so that the experiments do not get
> > in the way.
> 
> Yes, sounds good!
> 
> thanks,
> 
>  - Joel
